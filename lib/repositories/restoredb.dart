import 'package:contact/setting/setting.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

restoreDB() async {
  var path;

/*   if (Platform.isAndroid) {
    path = "/data/data/com.example.keepinDB/databases/banco.db";
  } else if (Platform.isIOS) {
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, "banco.db");
  } */
  var databasesPath = await getDatabasesPath();
  path = join(databasesPath, DATABASE_NAME);
  await deleteDatabase(path);

  //Verifique se o banco de dados existe
/*   var exists = await databaseExists(path);

  if (!exists) {
    // Deve acontecer apenas na primeira vez que você inicia seu aplicativo
    print("Criando nova cópia a partir de assets");

    // Verifique se o diretório pai existe
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copiar do ativo
    ByteData data = await rootBundle.load(join("assets", "banco.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Escreva e libere os bytes gravados
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Abrindo banco de dados existente");
  }
  // abra o banco de dados
  Database db = await openDatabase(path, readOnly: false);
  print(db.toString()); */

/*     await Future.delayed(Duration(seconds: 10), () {
         db.close();
         print("close DB");
    }); */
}
