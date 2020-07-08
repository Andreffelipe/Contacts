import 'package:contact/models/contact.model.dart';
import 'package:contact/setting/setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {
  final Database db;
  ContactRepository({this.db});

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future create(ContactModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
        TABLE_NAME,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace, // evita dados repetidos
      );
    } catch (err) {
      print("ERROR => $err");
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(maps.length, (index) {
        return ContactModel(
            id: maps[index]['id'],
            name: maps[index]['name'],
            email: maps[index]['email'],
            phone: maps[index]['phone'],
            image: maps[index]['image'],
            addressLine1: maps[index]['addressLine1'],
            addressLine2: maps[index]['addressLine2'],
            latLng: maps[index]['latLng']);
      });
    } catch (err) {
      return List<ContactModel>();
    }
  }

  Future<List<ContactModel>> search(String term) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "name LIKE ?",
        whereArgs: [
          '%$term%',
        ],
      );
      return List.generate(maps.length, (index) {
        return ContactModel(
            id: maps[index]['id'],
            name: maps[index]['name'],
            email: maps[index]['email'],
            phone: maps[index]['phone'],
            image: maps[index]['image'],
            addressLine1: maps[index]['addressLine1'],
            addressLine2: maps[index]['addressLine2'],
            latLng: maps[index]['latLng']);
      });
    } catch (err) {
      return List<ContactModel>();
    }
  }

  Future<ContactModel> getContact(int id) async {
    try {
      final Database db = await _getDatabase();
      final int index = 0;
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );

      return ContactModel(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email'],
          phone: maps[index]['phone'],
          image: maps[index]['image'],
          addressLine1: maps[index]['addressLine1'],
          addressLine2: maps[index]['addressLine2'],
          latLng: maps[index]['latLng']);
    } catch (err) {
      return ContactModel();
    }
  }

  Future update(ContactModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.update(
        TABLE_NAME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (err) {
      print(err);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      print(err);
      return;
    }
  }

  Future updateImage(int id, String imagePath) async {
    try {
      final Database db = await _getDatabase();
      final model = await getContact(id);

      model.image = imagePath;

      await db.update(
        TABLE_NAME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (err) {
      print(err);
      return;
    }
  }
}
