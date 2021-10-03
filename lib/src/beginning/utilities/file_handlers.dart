import 'dart:io';

Future<String> duplicateFile(String expected) async {
  final String ext = getFileExt(expected);
  String result = expected;
  int iterations = 0;
  while (true) {
    if (await File(result).exists()) {
      iterations += 1;
      result = result.replaceAll(ext, "");
      result += "($iterations)";
      result += ext;
    } else {
      return result;
    }
  }
}

String getFileExt(String file) {
  String trim = file.replaceRange(0, file.length - 5, "");
  if (trim.contains(".")) {
    String ext = trim.replaceRange(0, trim.indexOf("."), "");
    return ext;
  } else {
    throw Exception("No Extension found in $file");
  }
}
