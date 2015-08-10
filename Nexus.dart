import 'dart:html';
import 'dart:core';
import 'dart:async';

class Nexus {
  String host;

  String get Host => this.host;

  void set Host(String value) {
    this.host = value;
  }

  Nexus(String host) {
    this.host = host;
  }

  Future<String> ReadDir(String dirname) {
    return HttpRequest.getString(host + "/ReadDir?dirname=" + dirname);
  }

  Future<String> Select1(String dbname, String selectQuery) {
    String str = "/Select1?dbname=" + dbname + "&" + "query=" + selectQuery;
    String encodedString = Uri.encodeFull(host + str);

    return HttpRequest.getString(encodedString);
  }
}