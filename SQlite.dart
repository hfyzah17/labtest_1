import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BmiDB {
  static const String _dbName = 'bitp3453_bmi';
  static const String _tblName = 'bmi';
  static const String _colUsername = 'username';
  static const String _colWeight = 'weight';
  static const String _colHeight = 'height';
  static const String _colGender = 'gender';
  static const String _colStatus = 'bmi_status';

  Database? _db;

  BmiDB._();
  static final BmiDB _instance = BmiDB._();

  factory BmiDB() {
    return _instance;
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    String path = join(await getDatabasesPath(), _dbName);
    _db = await openDatabase(path, version: 1, onCreate: (createdDb, version) async {
      for (String tableSql in BmiDB.tableSQLStrings) {
        await createdDb.execute(tableSql);
      }
    });
    return _db!;
  }

  static List<String> tableSQLStrings = [
    '''
    CREATE TABLE IF NOT EXISTS $_tblName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_colUsername TEXT,
      $_colWeight DOUBLE,
      $_colHeight DOUBLE,
      $_colGender int,
      $_colStatus TEXT
    )
    '''
  ];

  Future<void> init() async {
    Database db = await _instance.database;
    List<Map<String, dynamic>> results = await db.query(_tblName);

    if (results.isNotEmpty) {
      for (Map<String, dynamic> result in results) {
        // Populate TextFields with retrieved data
        double weight = result[_colWeight];
        double height = result[_colHeight];
        String status = result[_colStatus];

        // Update TextFields accordingly
      }
    }
  }

  Future<int> insert(String username, double weight, double height, int gender,
      String status) async {
    Database db = await _instance.database;
    return await db.insert(_tblName, {
      _colUsername: username,
      _colWeight: weight,
      _colHeight: height,
      _colGender: gender,
      _colStatus: status,
    });
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await _instance.database;
    return await db.query(_tblName);
  }

  Future<int> update(int id, String username, double weight, double height,
      int gender, String status) async {
    Database db = await _instance.database;
    return await db.update(
        _tblName,
        {
          _colUsername: username,
          _colWeight: weight,
          _colHeight: height,
          _colGender: gender,
          _colStatus: status,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await _instance.database;
    return await db.delete(_tblName, where: 'id = ?', whereArgs: [id]);
  }
}
