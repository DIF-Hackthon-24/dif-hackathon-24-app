class OssTokenForFabGraphQLQuery {
  static String getQuery() {
    return '''
query {
    createExternalAPIToken(initiator: "fab") {
        ossToken
    }
}
''';
  }
}
