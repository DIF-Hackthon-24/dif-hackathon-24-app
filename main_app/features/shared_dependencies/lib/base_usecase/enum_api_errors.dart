enum APIErrors {
  DEFAULT_ERROR,
  INTERNAL_SERVER_ERROR,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  INVALID_TOKEN,
  EXPIRED_TOKEN,
  DEVICE_ID_MISMATCH,
  SUPPORT_SINGLE_LOGIN,
  USER_TYPE_NOT_SUPPORTED,
  USER_NOT_IN_PILOT_PROGRAM,
  UAE_PASS_ERROR_GET_TOKEN,
  UAE_PASS_ERROR_GET_USER,
  CO_APPLICANT_USER,
  NO_INTERNET_ACCESS,
  API_ERROR_WITHOUT_REPORTING_OPTION,
  NON_ELIGIBLE_APPLICANT,
  ELIGIBILITY_CALCULATION_IN_PROGRESS,
  EXEMPTION_NO_ACTIVE_APPLICATIONS,
}

extension APIErrorCodes on String {
  APIErrors get enm {
    switch (this) {
      case 'GS-MS-00-500':
        return APIErrors.INTERNAL_SERVER_ERROR;
      case 'GS-MS-00-400':
        return APIErrors.BAD_REQUEST;
      case 'GS-MS-01-401':
        return APIErrors.UNAUTHORIZED;
      case 'GS-MS-01-403':
        return APIErrors.FORBIDDEN;
      case 'US-MS-02-401':
        return APIErrors.INVALID_TOKEN;
      case 'US-MS-03-401':
        return APIErrors.EXPIRED_TOKEN;
      case 'US-MS-04-401':
        return APIErrors.DEVICE_ID_MISMATCH;
      case 'US-MS-05-401':
        return APIErrors.SUPPORT_SINGLE_LOGIN;
      case 'US-MS-06-403':
        return APIErrors.USER_TYPE_NOT_SUPPORTED;
      case 'US-MS-06-404':
        return APIErrors.USER_NOT_IN_PILOT_PROGRAM;
      case 'US-UPS-01-XXX':
        return APIErrors.UAE_PASS_ERROR_GET_TOKEN;
      case 'US-UPS-02-XXX':
        return APIErrors.UAE_PASS_ERROR_GET_USER;
      case 'US-MS-36-406':
      case 'US-MS-37-406':
      case 'US-MS-38-406':
      case 'US-MS-06-406':
        return APIErrors.CO_APPLICANT_USER;
      case 'GIS-ODB-34-400':
      case 'GIS-ELMS-03-409':
      case 'GIS-ODB-35-400':
      case 'ELMS-SHB-03-409':
      case 'GIS-MS-14-400':
      case 'GIS-MS-15-400':
      case 'ELMS-ELMS-18-409':
        return APIErrors.API_ERROR_WITHOUT_REPORTING_OPTION;
      case 'no_internet_access':
        return APIErrors.NO_INTERNET_ACCESS;
      case 'US-MS-06-400':
        return APIErrors.NON_ELIGIBLE_APPLICANT;
      case 'DHP-CBA-04-404':
        return APIErrors.ELIGIBILITY_CALCULATION_IN_PROGRESS;
      case 'DHP-MS-62-404':
        return APIErrors.EXEMPTION_NO_ACTIVE_APPLICATIONS;
      default:
        return APIErrors.DEFAULT_ERROR;
    }
  }
}
