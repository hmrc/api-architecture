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

package v1.connectors

import config.AppConfig
import javax.inject.{Inject, Singleton}
import uk.gov.hmrc.http.{HeaderCarrier, HttpClient}
import utils.pagerDutyLogging.{Endpoint, LoggerMessages}
import v1.controllers.UserRequest
import v1.models.errors.ConnectorError
import v1.models.request.obligations.ObligationsRequest
import v1.models.response.obligations.ObligationsResponse

import scala.concurrent.{ExecutionContext, Future}

@Singleton
class ObligationsConnector @Inject()(val http: HttpClient,
                                     val appConfig: AppConfig) extends BaseDesConnector {

  def retrieveObligations(request: ObligationsRequest)(
    implicit hc: HeaderCarrier,
    ec: ExecutionContext,
    userRequest: UserRequest[_],
    correlationId: String): Future[DesOutcome[ObligationsResponse]] = {

    import v1.connectors.httpparsers.StandardDesHttpParser._

    val vrn = request.vrn.vrn

    implicit val connectorError: ConnectorError =
      ConnectorError(vrn, hc.requestId.fold(""){ requestId => requestId.value})
    implicit val logMessage: LoggerMessages.Value = Endpoint.RetrieveObligations.toLoggerMessage

    val queryParams: Seq[(String, String)] =
      Seq(
        "from" -> request.from,
        "to" -> request.to,
        "status" -> request.status
      ) collect {
        case (key, Some(value)) => key -> value
      }

    get(
      uri = DesUri[ObligationsResponse](s"enterprise/obligation-data/vrn/$vrn/VATC"),
      queryParams = queryParams
    )
  }
}
