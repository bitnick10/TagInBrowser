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

  UpdateStarsName();
  UpdateTagsName();
  UpdateImages();

  print("main() end");
}

void UpdateStarsName() {
  var starsNameDiv = querySelector("#stars_name");
  nexus.Select1("E:\\z_study\\study.db", "select distinct star from filter").then((String data) {
    List dataList = JSON.decode(data);
    for (var name in dataList) {
      AnchorElement a = new AnchorElement();
      a.href = "index.html?star=" + name;
      a.innerHtml = name;
      starsNameDiv.children.add(a);
    }
  });
}

void UpdateTagsName() {
  var starsNameDiv = querySelector("#tags_name");
  nexus.Select1("E:\\z_study\\study.db", "select distinct tags from filter").then((String data) {
    List dataList = JSON.decode(data);
    for (var name in dataList) {
      AnchorElement a = new AnchorElement();
      a.href = "index.html?tags=" + name;
      a.innerHtml = name;
      starsNameDiv.children.add(a);
    }
  });
}

void UpdateImages() {
  if (Uri.base.queryParameters["star"] != null) {
    nexus.Select1("E:\\z_study\\study.db", "select id from filter where star = '" + Uri.base.queryParameters["star"] + "'").then((String data) {
      var imagesDiv = querySelector("#images");
      imagesDiv.children.clear();
      for (var v in JSON.decode(data)) {
        AddImage("E:\\z_study", v);
      }
    });
    return;
  }
  if (Uri.base.queryParameters["tags"] != null) {
    nexus.Select1("E:\\z_study\\study.db", "select id from filter where tags = '" + Uri.base.queryParameters["tags"] + "'").then((String data) {
      var imagesDiv = querySelector("#images");
      imagesDiv.children.clear();
      for (var v in JSON.decode(data)) {
        AddImage("E:\\z_study", v);
      }
    });
    return;
  }
  nexus.ReadDir("E:\\z_study").then((String data) {
    List dataList = JSON.decode(data);
    for (var d in dataList) {
      if (d["IsDir"]) {
        AddImage("E:\\z_study", d["Name"]);
      }
    }
  });
  nexus.ReadDir("F:\\z_study").then((String data) {
    List dataList = JSON.decode(data);
    for (var d in dataList) {
      if (d["IsDir"]) {
        AddImage("F:\\z_study", d["Name"]);
      }
    }
  });
}

void AddImage(String storagePath, String id) {
  var imagesDiv = querySelector("#images");
  AnchorElement a = new AnchorElement();
  a.href = "javascript:void(0)";
  a.onClick.listen((event) =>
  HttpRequest.getString(nexus.host + "/command?name=explorer.exe&arg=" + storagePath + "\\" + id));
  a.title = id;
  ImageElement img = new ImageElement();
  img.width = 314;
  img.height = (img.width * 1080 / 1920).toInt();
  img.alt = id;
  img.src = nexus.host + "/file?path=" + storagePath + "\\" + id + "\\preview\\001.jpg";
  a.children.add(img);
  imagesDiv.children.add(a);
}

void OnButtonReadDirClick(MouseEvent event) {
  nexus.ReadDir("C:\\").then((String data) {
    result.innerHtml = data;
    List infos = JSON.decode(data);
    result.innerHtml = infos[0]["Name"];

  });
}