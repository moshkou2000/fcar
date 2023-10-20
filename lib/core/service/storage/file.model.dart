import 'dart:io';

import 'package:camera/camera.dart';

class FileModel {
  final File? file;
  final XFile? xFile;
  final String? directory;
  final String? extension;
  final String? name;
  final String? path;

  FileModel({
    this.file,
    this.xFile,
    this.extension,
    this.directory,
    this.name,
    this.path,
  });
}
