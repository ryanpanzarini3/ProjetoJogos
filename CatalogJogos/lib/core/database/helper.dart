class DatabaseHelper {
 static final DatabaseHelper instance = DatabaseHelper._init();
 static Database? _database;
 DatabaseHelper._init();
 Future<Database> get database async {
 if (_database != null) return _database!;
 _database = await _initDB('games.db');
 return _database!;
 }
 Future<Database> _initDB(String fileName) async {
 final dbPath = await getDatabasesPath();
 final path = join(dbPath, fileName);
 return await openDatabase(path, version: 1, onCreate: _createDB);
 }
 Future _createDB(Database db, int version) async {
 await db.execute('''
 CREATE TABLE favorites (
 id INTEGER PRIMARY KEY,
 name TEXT NOT NULL,
 backgroundImage TEXT,
 rating REAL,
 released TEXT
 )
 ''');
 }
}