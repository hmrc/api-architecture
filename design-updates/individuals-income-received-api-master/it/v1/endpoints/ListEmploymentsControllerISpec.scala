/*
 * Copyright 2021 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package v1.endpoints

import com.github.tomakehurst.wiremock.stubbing.StubMapping
import play.api.http.HeaderNames.ACCEPT
import play.api.http.Status._
import play.api.libs.json.{JsValue, Json}
import play.api.libs.ws.{WSRequest, WSResponse}
import support.IntegrationBaseSpec
import v1.fixtures.ListEmploymentsControllerFixture._
import v1.models.errors._
import v1.stubs.{AuditStub, AuthStub, DesStub, MtdIdLookupStub}

class ListEmploymentsControllerISpec extends IntegrationBaseSpec {

  private trait Test {

    val nino: String = "AA123456A"
    val taxYear: String = "2019-20"
    val employmentId: String = "4557ecb5-fd32-48cc-81f5-e6acd1099f3c"

    val desResponse: JsValue = Json.parse(
      """
        |{
        |   "employments": [
        |      {
        |         "employmentId": "4557ecb5-fd32-48cc-81f5-e6acd1099f3c",
        |         "employerName": "Vera Lynn",
        |         "employerRef": "123/AZ12334",
        |         "payrollId": "123345657",
        |         "startDate": "2019-01-01",
        |         "cessationDate": "2020-06-01",
        |         "dateIgnored": "2020-06-17T10:53:38Z"
        |      },
        |      {
        |         "employmentId": "4557ecb5-fd32-48cc-81f5-e6acd1099f3c",
        |         "employerName": "Vera Lynn",
        |         "employerRef": "123/AZ12334",
        |         "payrollId": "123345657",
        |         "startDate": "2019-01-01",
        |         "cessationDate": "2020-06-01",
        |         "dateIgnored": "2020-06-17T10:53:38Z"
        |      }
        |   ],
        |   "customerDeclaredEmployments": [
        |      {
        |         "employmentId": "4557ecb5-fd32-48cc-81f5-e6acd1099f3c",
        |         "employerName": "Vera Lynn",
        |         "employerRef": "123/AZ12334",
        |         "payrollId": "123345657",
        |         "startDate": "2019-01-01",
        |         "cessationDate": "2020-06-01",
        |         "submittedOn": "2020-06-17T10:53:38Z"
        |      },
        |      {
        |         "employmentId": "4557ecb5-fd32-48cc-81f5-e6acd1099f3c",
        |         "employerName": "Vera Lynn",
        |         "employerRef": "123/AZ12334",
        |         "payrollId": "123345657",
        |         "startDate": "2019-01-01",
        |         "cessationDate": "2020-06-01",
        |         "submittedOn": "2020-06-17T10:53:38Z"
        |      }
        |   ]
        |}
    """.stripMargin
    )

    val mtdResponse: JsValue = mtdResponseWithCustomHateoas(nino, taxYear, employmentId)

    def uri: String = s"/employments/$nino/$taxYear"

    def desUri: String = s"/income-tax/income/employments/$nino/$taxYear"

    def setupStubs(): StubMapping

    def request: WSRequest = {
      setupStubs()
      buildRequest(uri)
        .withHttpHeaders((ACCEPT, "application/vnd.hmrc.1.0+json"))
    }
  }

  "Calling the 'list employments' endpoint" should {
    "return a 200 status code" when {
      "any valid request is made" in new Test {

        override def setupStubs(): StubMapping = {
          AuditStub.audit()
          AuthStub.authorised()
          MtdIdLookupStub.ninoFound(nino)
          DesStub.onSuccess(DesStub.GET, desUri, OK, desResponse)
        }

        val response: WSResponse = await(request.get)
        response.status shouldBe OK
        response.json shouldBe mtdResponse
        response.header("Content-Type") shouldBe Some("application/json")
      }
    }

    "return error according to spec" when {

      "validation error" when {
        def validationErrorTest(requestNino: String, requestTaxYear: String, expectedStatus: Int, expectedBody: MtdError): Unit = {
          s"validation fails with ${expectedBody.code} error" in new Test {

            override val nino: String = requestNino
            override val taxYear: String = requestTaxYear

            override def setupStubs(): StubMapping = {
              AuditStub.audit()
              AuthStub.authorised()
              MtdIdLookupStub.ninoFound(nino)
            }

            val response: WSResponse = await(request.get)
            response.status shouldBe expectedStatus
            response.json shouldBe Json.toJson(expectedBody)
            response.header("Content-Type") shouldBe Some("application/json")
          }
        }

        val input = Seq(
          ("AA1123A", "2019-20", BAD_REQUEST, NinoFormatError),
          ("AA123456A", "20199", BAD_REQUEST, TaxYearFormatError),
          ("AA123456A", "2018-19", BAD_REQUEST, RuleTaxYearNotSupportedError),
          ("AA123456A", "2019-21", BAD_REQUEST, RuleTaxYearRangeInvalidError))

        input.foreach(args => (validationErrorTest _).tupled(args))
      }

      "des service error" when {
        def serviceErrorTest(desStatus: Int, desCode: String, expectedStatus: Int, expectedBody: MtdError): Unit = {
          s"des returns an $desCode error and status $desStatus" in new Test {

            override def setupStubs(): StubMapping = {
              AuditStub.audit()
              AuthStub.authorised()
              MtdIdLookupStub.ninoFound(nino)
              DesStub.onError(DesStub.GET, desUri, desStatus, errorBody(desCode))
            }

            val response: WSResponse = await(request.get)
            response.status shouldBe expectedStatus
            response.json shouldBe Json.toJson(expectedBody)
            response.header("Content-Type") shouldBe Some("application/json")
          }
        }

        def errorBody(code: String): String =
          s"""
             |{
             |   "code": "$code",
             |   "reason": "des message"
             |}
            """.stripMargin

        val input = Seq(
          (BAD_REQUEST, "INVALID_TAXABLE_ENTITY_ID", BAD_REQUEST, NinoFormatError),
          (BAD_REQUEST, "INVALID_TAX_YEAR", BAD_REQUEST, TaxYearFormatError),
          (NOT_FOUND, "NOT_FOUND", NOT_FOUND, NotFoundError),
          (INTERNAL_SERVER_ERROR, "SERVER_ERROR", INTERNAL_SERVER_ERROR, DownstreamError),
          (SERVICE_UNAVAILABLE, "SERVICE_UNAVAILABLE", INTERNAL_SERVER_ERROR, DownstreamError))

        input.foreach(args => (serviceErrorTest _).tupled(args))
      }
    }
  }
}