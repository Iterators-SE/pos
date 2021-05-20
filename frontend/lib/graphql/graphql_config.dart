import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static Link link;
  static HttpLink httpLink = HttpLink('http://iterators-pos.herokuapp.com/graphql');

  static void setToken(String token) {
    var alink = AuthLink(getToken: () async => 'Bearer $token');
    GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink);
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    return GraphQLConfiguration.link != null
        ? GraphQLConfiguration.link
        : GraphQLConfiguration.httpLink;
  }
  
  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: getLink(),
    );
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: GraphQLCache(),
    ),
  );

}
