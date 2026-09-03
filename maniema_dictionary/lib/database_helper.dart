import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kamus_kambelembele.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }
  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE dictionary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        source_language TEXT NOT NULL,
        source_word TEXT NOT NULL,
        target_language TEXT NOT NULL,
        translation TEXT NOT NULL,
        source_example TEXT,
        target_example TEXT,
        audio_path TEXT
      )
    ''');
    await db.insert('dictionary', {
      'source_language': 'Kyenye Kasenga',
      'source_word': 'test',
      'target_language': 'Français',
      'translation': 'mot de démonstration',
      'source_example': 'Exemple de démonstration',
      'target_example': 'Exemple traduit de démonstration',
      'audio_path': null,
});
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dictionary_id INTEGER NOT NULL,
        source_language TEXT NOT NULL,
        source_word TEXT NOT NULL,
        target_language TEXT NOT NULL,
        translation TEXT NOT NULL,
        source_example TEXT,
        target_example TEXT,
        UNIQUE(dictionary_id, source_language, target_language)
  )
''');
  }
  Future<void> _onUpgrade(
  Database db,
  int oldVersion,
  int newVersion,
) async {
  if (oldVersion < 2) {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dictionary_id INTEGER NOT NULL,
        source_language TEXT NOT NULL,
        source_word TEXT NOT NULL,
        target_language TEXT NOT NULL,
        translation TEXT NOT NULL,
        source_example TEXT,
        target_example TEXT,
        UNIQUE(dictionary_id, source_language, target_language)
      )
    ''');
  }
}
  Future<int> insertEntry(Map<String, dynamic> entry) async {
    final db = await instance.database;
    return await db.insert(
      'dictionary',
      entry,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<int> addFavorite(Map<String, dynamic> favorite) async {
  final db = await instance.database;

  final existing = await db.query(
    'favorites',
    where: '''
      dictionary_id = ?
      AND source_language = ?
      AND target_language = ?
    ''',
    whereArgs: [
      favorite['dictionary_id'],
      favorite['source_language'],
      favorite['target_language'],
    ],
    limit: 1,
  );

  if (existing.isNotEmpty) {
    return existing.first['id'] as int;
  }

  return await db.insert(
    'favorites',
    favorite,
  );
}

  Future<List<Map<String, dynamic>>> searchEntries(
  String word,
  String sourceLanguage,
  String targetLanguage,
) async {
  final db = await instance.database;

  return await db.query(
    'dictionary',
     where: '''
      (
        source_language = ?
        AND target_language = ?
        AND source_word LIKE ?
      )
      OR
      (
        source_language = ?
        AND target_language = ?
        AND translation LIKE ?
      )
    ''',
    whereArgs: [
      sourceLanguage,
      targetLanguage,
      '%$word%',
      sourceLanguage,
      targetLanguage,
      '%$word%',
    ],
    orderBy: 'source_word ASC',
  );
}
  Future<List<Map<String, dynamic>>> getAllEntries() async {
    final db = await instance.database;
    return await db.query(
      'dictionary',
      orderBy: 'source_word ASC',
    );
  }
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await instance.database;

    return await db.query(
      'favorites',
      orderBy: 'source_word ASC',
  );
}
  Future<int> deleteEntry(int id) async {
    final db = await instance.database;
    return await db.delete(
      'dictionary',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteFavorite(int id) async {
  final db = await instance.database;

  return await db.delete(
    'favorites',
    where: 'id = ?',
    whereArgs: [id],
  );
}
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}