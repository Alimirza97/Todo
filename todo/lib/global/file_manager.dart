import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:todo/global/global_data_model.dart';

class FileManager {
  String filePath = "";

  Future<String> get _localDevicePath async {
    final _devicePath = await getApplicationDocumentsDirectory();
    return _devicePath.path;
  }

  Future<File> _localFile({
    String? folderName,
    required String fileName,
    required String fileType,
  }) async {
    final _path = await _localDevicePath;
    if (folderName != null) {
      var _newPath = await Directory("$_path/$folderName").create();
      return File("${_newPath.path}/$fileName.$fileType");
    }
    return File("$_path/$fileName.$fileType");
  }

  Future downloadFile({
    required String url,
    String? folderName,
    required String fileName,
    required String fileType,
  }) async {
    final _response = await http.get(Uri.parse(url));
    if (_response.statusCode == 200) {
      final _file = await _localFile(
          fileName: fileName, fileType: fileType, folderName: folderName);
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      logger.wtf("File Writing Complated. File Path ${_saveFile.path}");
      filePath = _saveFile.path;
    } else {
      logger.e(_response.statusCode);
    }
  }

  Future<String?> readAsString({
    String? folderName,
    required String fileName,
    required String fileType,
  }) async {
    final _file = await _localFile(
        fileName: fileName, fileType: fileType, folderName: folderName);
    filePath = _file.path;
    try {
      final _saveFile = await _file.readAsString();
      logger.wtf("File Read Complated. File $_saveFile");
      return _saveFile;
    } catch (e) {
      logger.e("${e.toString().split("(")[1].split(")")[0]}");
      return null;
    }
  }

  Future writeAsString({
    String? folderName,
    required String fileName,
    required String fileType,
    required String data,
  }) async {
    final _file = await _localFile(
        fileName: fileName, fileType: fileType, folderName: folderName);
    final _saveFile = await _file.writeAsString(data);
    logger.wtf("File Writing Complated. File Path ${_saveFile.path}");
    filePath = _saveFile.path;
  }
}
