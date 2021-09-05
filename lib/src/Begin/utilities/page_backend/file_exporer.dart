import 'dart:io';
import '../../begin.dart';

List selectedFolders = [];
Map fileExplorer = {};
List tempData = [];
String topLevelDir = "/storage/emulated/0";
String currentTopDir = "/storage/emulated/0/";

iterationManager(where) async {
  currentTopDir = where;
  fileExplorer = {};
  await getAllDir(where);
  for (int i = 0; i < tempData.length; i++) {
    if (tempData[i] != "/storage/emulated/0/Android") {
      fileExplorer[tempData[i]] = [
        selectedFolders.contains(tempData[i]),
        false
      ];
    }
  }
}

String previousDir(String dir) {
  String result = "";
  int index = dir.length - 1;
  while (index >= 0) {
    if (dir[index] == "/") {
      result = dir.replaceRange(index, dir.length, "");
      break;
    }
    index -= 1;
  }
  return result;
}

getAllDir(where) async {
  final dir = Directory(where);
  final files = await dir.list(recursive: false, followLinks: true).toList();
  tempData = [];
  for (int i = 0; i < files.length; i++) {
    if (files[i].statSync().type.toString() == "directory") {
      tempData.add(files[i].path);
    }
  }
}

saveLocations() async {
  musicBox.put('customLocations', selectedFolders);
}

bool isTicked(String path) {
  for (int i = 0; i < selectedFolders.length; i++) {
    if (selectedFolders[i].contains(path)) {
      return true;
    }
  }
  return false;
}

unTick(String path) {
  List<String> toRemove = [];
  for (int i = 0; i < selectedFolders.length; i++) {
    if (selectedFolders[i].contains(path)) {
      toRemove.add(selectedFolders[i]);
    }
  }
  toRemove.forEach((element) {
    selectedFolders.remove(element);
  });
}
