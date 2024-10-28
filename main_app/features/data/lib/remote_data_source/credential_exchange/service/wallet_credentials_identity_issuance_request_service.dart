import 'package:core/ioc/di_container.dart';
import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:shared_dependencies/base_service/base_service_request.dart';
import 'package:shared_dependencies/service_identifiers.dart';

class _Constants {
  static const identity = 'identity';
  static const requestBody = '''
{
  "issuerKey": {
    "type": "jwk",
    "jwk": {
      "kty": "OKP",
      "d": "mDhpwaH6JYSrD2Bq7Cs-pzmsjlLj4EOhxyI-9DM1mFI",
      "crv": "Ed25519",
      "kid": "Vzx7l5fh56F3Pf9aR3DECU5BwfrY6ZJe05aiWYWzan8",
      "x": "T3T4-u1Xz3vAV2JwPNxWfs4pik_JLiArz_WTCvrCFUM"
    }
  },
  "credentialConfigurationId": "OpenBadgeCredential_jwt_vc_json",
  "credentialData": {
    "@context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://purl.imsglobal.org/spec/ob/v3p0/context.json"
    ],
    "id": "urn:uuid:THIS WILL BE REPLACED WITH DYNAMIC DATA FUNCTION (see below)",
    "type": [
      "VerifiableCredential",
      "OpenBadgeCredential"
    ],
    "name": "Identity Credential",
    "issuer": {
      "type": [
        "Profile"
      ],
      "name": "IdentityIssuer",
      "url": "https://www.jff.org/",
      "image": "https://w3c-ccg.github.io/vc-ed/plugfest-1-2022/images/JFF_LogoLockup.png"
    },
    "credentialSubject": {
      "type": [
        "IdentityCredential"
      ],
      "achievement": {
        "id": "urn:uuid:ac254bd5-8fad-4bb1-9d29-efd938536926",
        "type": [
          "Verification"
        ],
        "name": "Identity Credential",
        "description": "Successful verification of user's passport",
        "criteria": {
          "type": "Criteria",
          "narrative": "Successful verification of user's passport"
        },
        "image": {
          "id": "https://w3c-ccg.github.io/vc-ed/plugfest-3-2023/images/JFF-VC-EDU-PLUGFEST3-badge-image.png",
          "type": "Image"
        }
      }
    }
  },
  "mapping": {
    "id": "<uuid>",
    "issuer": {
      "id": "<issuerDid>"
    },
    "credentialSubject": {
      "id": "<subjectDid>"
    },
    "issuanceDate": "<timestamp>",
    "expirationDate": "<timestamp-in:365d>"
  },
  "authenticationMethod": "PRE_AUTHORIZED",
  "issuerDid": "did:key:z6MkjoRhq1jSNJdLiruSXrFFxagqrztZaXHqHGUTKJbcNywp"
}
  ''';
}

class PostWalletCredentialsIdentityIssuanceService extends BaseGraphQLService {
  @override
  GraphQLRequest getGraphQLRequest(
    TaskParams? params, {
    Map<String, dynamic>? paramsInMap,
  }) {
    throw UnimplementedError();
  }

  @override
  RestRequest getRestRequest(TaskParams? params,
      {Map<String, dynamic>? paramsInMap}) {
    final response = WalletCredentialsResolvePresentationResponseModel();
    return RestRequest(
        type: RequestType.post,
        name: ServiceIdentifiers.postWalletCredentialsIdentityIssuance,
        data: response,
        body: _Constants.requestBody,
        showBusy: BusyType.none,
        cachePolicy: CachePolicy.none,
        queryParameters: {_Constants.identity: _Constants.identity});
  }
}
