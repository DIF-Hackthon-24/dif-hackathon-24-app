abstract class IGraphqlQueryBuilder{
  String getQuery(String? languageCode, String?  journeyType,String?  operation);
}


abstract class INewApplicationGraphlQueryBuilder{
  String getQuery(String? languageCode, String?  journeyType,String?  operation,String? type);
}