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
    //String ret;
    return HttpRequest.getString(host + "/ReadDir?dirname=" + dirname);
    //.then((String content) {
    //    ret = content;
    //    return content;
    //print(content);
    //result.innerHtml += content;
    //List infos = JSON.decode(content);
    //result.innerHtml = infos[0]["Name"];
    //print(infos[0]);
    //result.innerHtml = content.replaceAll("\n", "<br/>");
    //  }).catchError((Error error) {
    //   print("http request error<br/>");
    //   print(error.toString());
    //  });
    //  return ret;
  }

  Future<String> Select1(String dbname, String selectQuery) {
    String str = "/Select1?dbname=" + dbname + "&" + "query=" + selectQuery;
    String encodedString = Uri.encodeFull(host + str);
    //String ret;

    return HttpRequest.getString(encodedString);
    //.then((String content) {
    //  ret = content;
    //return content;
    //print(content);
    //result.innerHtml += content;
    //List infos = JSON.decode(content);
    // result.innerHtml += infos[0];
    //}).catchError((Error error) {
    //  print("http request error<br/>");
    //  print(error.toString());
    //});
    // return ret;
  }
}