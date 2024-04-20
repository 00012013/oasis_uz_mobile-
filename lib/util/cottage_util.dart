import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class CottageUtil {
  static Future<List<File>> assetsToFiles(List<Asset> assets) async {
    List<File> files = [];
    for (var asset in assets) {
      ByteData byteData = await asset.getByteData();
      Uint8List bytes = byteData.buffer.asUint8List();
      String fileName = 'image_${DateTime.now()}';
      String tempDir = (await getTemporaryDirectory()).path;
      File file = File('$tempDir/$fileName');
      await file.writeAsBytes(bytes);
      files.add(file);
    }
    return files;
  }
}
