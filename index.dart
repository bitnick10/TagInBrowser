import 'dart:html';
import 'dart:convert';
import 'dart:core';

import 'Nexus.dart';

ButtonInputElement buttonReadDir;
Element result;

Nexus nexus = new Nexus("http://192.168.1.170:17000");

void main() {
  print("in main()");
  result = querySelector('#result');
  buttonReadDir = querySelector("#btn_readdir");
  buttonReadDir.onClick.listen(OnButtonReadDirClick);

  UpdateImages();

  AnchorElement a = new AnchorElement();
  var stardiv = querySelector("#star");
  ImageElement img = new ImageElement();
  img.width = 480;
  img.height = (img.width * 1080 / 1920).toInt();
  img.src = nexus.host + "/file?path=" + "E:\\z_study\\Caribbean 011615_074\\preview\\001.jpg";
  img.marginEdge.left = 110;
  //a.nodeValue = "asdf";
  //img.src =nexus.host+"/file?path=" +"C:\\a a\\ss.png";
  a.text = "baidu.com";
  a.href = "http://baidu.com";
//  stardiv.children.add(a);
//  stardiv.children.add(img);
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
//  stardiv.children.add(img.clone(true));
  //String data = nexus.Select1("E:\\z_study\\study.db", "select id from filter where id like 't%'");
  //result.innerHtml = data;

  print("abc");
  window.console.debug("aaa");
}

//class VideoInfo {
//  String folderPath;
//  String id;
//  List<String> previewPaths = new List<String>();
//}

void UpdateImages() {
  //var imagesdiv = querySelector("#images");
  //List<VideoInfo> videosInfo = new List<VideoInfo>();
  nexus.ReadDir("E:\\z_study").then((String data) {
    AfterReadDir("E:\\z_study",data);
  });
  nexus.ReadDir("F:\\z_study").then((String data) {
    AfterReadDir("F:\\z_study",data);
  });
}

void AfterReadDir(String dir,String data) {
  var imagesdiv = querySelector("#images");
  List dataList = JSON.decode(data);
  for (var d in dataList) {
    if (d["IsDir"]) {
      AnchorElement a = new AnchorElement();
      a.href = "javascript:void(0)";
      a.onClick.listen((event) =>
      HttpRequest.getString(nexus.host + "/command?name=explorer.exe&arg=" +  dir+"\\"+ d["Name"])
      );
      a.title = d["Name"];
      ImageElement img = new ImageElement();
      img.width = 314;
      img.height = (img.width * 1080 / 1920).toInt();
      img.alt = d["Name"];
      img.src = nexus.host + "/file?path=" + dir+"\\" + d["Name"] + "\\preview\\001.jpg";
      a.children.add(img);
      imagesdiv.children.add(a);
      //VideoInfo info = new VideoInfo();
      //info.folderPath = "E:\\z_study";
      //info.id = d["Name"];
      //nexus.ReadDir()
      // videosInfo.add(info);
    }
  }
}

void OnButtonReadDirClick(MouseEvent event) {
  nexus.ReadDir("C:\\").then((String data) {
    result.innerHtml = data;
    List infos = JSON.decode(data);
    result.innerHtml = infos[0]["Name"];

  });
}