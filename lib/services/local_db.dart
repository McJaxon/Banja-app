//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights mapResulterved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either expmapResults or implied.

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  LocalDB._();

  late Database _db;

  Future get db async {
    _db = await initDb();
    return _db;
  }

  ///initialize the database
  static initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tuula.db');
    var taskDb = await openDatabase(path, version: 1);
    return taskDb;
  }

  ///delete the database
  static Future eraseDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tuula.db');
    var taskDb = await deleteDatabase(path);
    return taskDb;
  }

  ///alter table
  static Future<dynamic> alterTable(String tableName, String columnName) async {
    var dbClient = await await LocalDB._().db;
    var count = await dbClient.execute("ALTER TABLE $tableName ADD "
        "COLUMN $columnName TEXT;");

    return count;
  }

  ///insert end user details into table
  static Future writeUserDetails(var data) async {
    final dbClient = await LocalDB._().db;
    await dbClient.insert('end_user', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///insert end user details into table
  static Future writeLoanApplicationDetails(var data) async {
    final dbClient = await LocalDB._().db;
    await dbClient.insert('loan_application_details', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///insert loan category data into table
  static Future writeLoanCategoryData(List data) async {
    final dbClient = await LocalDB._().db;
    var batch = dbClient.batch();
    await dbClient.transaction((txn) async {
      data.forEach((clientMap) async {
        await batch.insert("loan_categories", clientMap);
      });
    });
    await batch.commit(noResult: true);
  }

  /// Creates pwd registration table
  static Future createAppTables() async {
    var dbClient = await LocalDB._().db;

    /// create loan category table
    await dbClient.execute('''
          CREATE TABLE IF NOT EXISTS loan_categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            loan_type TEXT NOT NULL,
            min_limit INTEGER NOT NULL,
            max_limit INTEGER NOT NULL,
            abbreviation TEXT,
            description TEXT
            );
            ''');

    ///create end user table
    await dbClient.execute('''
        CREATE TABLE IF NOT EXISTS end_user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nin character varying(254) NOT NULL,
            referral_id character varying(254),
            full_names character varying(254) NOT NULL,
            email_address character varying(254),
            location character varying(254) not null,
            profile_pic character varying(254) not null,
            phone_number character varying(254) not null,
            is_synced boolean NOT NULL DEFAULT 0
          );
            ''');

    await dbClient.execute('''
        CREATE TABLE IF NOT EXISTS loan_application_details (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            loan_type character varying(254) NOT NULL,
            loan_id TEXT NOT NULL,
            loan_amount INTEGER NOT NULL,
            tenure_period INTEGER NOT NULL,
            payment_frequency INTEGER NOT NULL,
            interest_rate INTEGER NOT NULL,
            transaction_source TEXT NOT NULL,
            principal INTEGER NOT NULL,
            payment_mode TEXT NOT NULL,
            payment_time TEXT NOT NULL,
            loan_period TEXT NOT NULL,
            interest INTEGER NOT NULL,
            outstanding_balance INTEGER NOT NULL,
            pay_off_date INTEGER NOT NULL,
            pay_back INTEGER NOT NULL,
            is_cleared boolean NOT NULL DEFAULT 0,
            approved_status boolean NOT NULL DEFAULT 0
          );
            ''');
  }

  //!Retrieve data from tables

  ///Retrieve loan categories from Db
  static Future<List<Map<String, dynamic>>> getLoanCategories() async {
    var dbClient = await LocalDB._().db;
    final mapResult = await dbClient.rawQuery("SELECT * FROM loan_categories");
    return mapResult;
  }

  ///Retrieve user details from Db
  static Future<List<Map<String, dynamic>>> getUserDetails() async {
    var dbClient = await LocalDB._().db;
    final mapResult = await dbClient.rawQuery(
      "SELECT * FROM end_user",
    );
    return mapResult;
  }

  ///Retrieve loan details from Db
  static Future<List<Map<String, dynamic>>> getLoanDetails() async {
    var dbClient = await LocalDB._().db;
    final maps =
        await dbClient.rawQuery('SELECT * FROM loan_application_details');
    return maps;
  }

  static Future<List<Map<String, dynamic>>> filterUnSyncedUserRecord() async {
    var dbClient = await LocalDB._().db;
    final mapResult =
        await dbClient.rawQuery('SELECT * FROM end_user where is_synced = 0');
    return mapResult;
  }

  ///update loan application  to flag is_synced = 1
  static updateLoanApplication() async {
    var dbClient = await LocalDB._().db;
    final mapResult = await dbClient
        .rawUpdate('UPDATE loan_application_details set is_synced = 1');
    return mapResult;
  }

  ///update user record to flag is_synced = 1
  static updateUseRecord() async {
    var dbClient = await LocalDB._().db;
    final mapResult =
        await dbClient.rawUpdate('UPDATE end_user set is_synced = 1');
    return mapResult;
  }
}
