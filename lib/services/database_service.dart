import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bloodlink.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Donors table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS donors (
        id TEXT PRIMARY KEY,
        fullName TEXT NOT NULL,
        bloodType TEXT NOT NULL,
        lastDonationDate TEXT,
        deferralStatus TEXT,
        phoneNumber TEXT,
        email TEXT,
        location TEXT,
        totalDonations INTEGER DEFAULT 0,
        lastDonationCenter TEXT,
        password TEXT
      )
    ''');

    // Blood requests table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS blood_requests (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        bloodType TEXT NOT NULL,
        quantity TEXT,
        urgency TEXT,
        hospital TEXT,
        location TEXT,
        date TEXT,
        contactNumber TEXT,
        status TEXT DEFAULT 'active'
      )
    ''');

    // Campaigns table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS campaigns (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        startDate TEXT,
        endDate TEXT,
        location TEXT,
        organizer TEXT,
        contactInfo TEXT,
        status TEXT DEFAULT 'active'
      )
    ''');

    // Donation centers table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS donation_centers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT,
        city TEXT,
        phoneNumber TEXT,
        email TEXT,
        workingHours TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');

    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Check if donors table is empty
    final donorCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM donors'));
    if (donorCount == 0) {
      await db.insert('donors', {
        'id': '1999-011234567',
        'fullName': 'Rufatiro Aline',
        'bloodType': 'A+',
        'lastDonationDate': '30/07/2025',
        'deferralStatus': 'N/A',
        'phoneNumber': '0791476030',
        'email': 'rufatiro@gmail.com',
        'location': 'Nyarugenge, Kigali, Rwanda',
        'totalDonations': 204,
        'lastDonationCenter': 'RBC City Center',
        'password': 'password123',
      });
    }

    // Check if blood_requests table is empty
    final requestCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM blood_requests'));
    if (requestCount == 0) {
      final requests = [
        {
          'id': '1',
          'title': 'Emergency B+ Blood Needed',
          'description': 'Urgent need for B+ blood for emergency surgery',
          'bloodType': 'B+',
          'quantity': '2 units',
          'urgency': 'Critical',
          'hospital': 'King Faisal Hospital',
          'location': 'Kigali',
          'date': '12/10/2025',
          'contactNumber': '+250781234567',
          'status': 'active',
        },
        {
          'id': '2',
          'title': 'Emergency O- Blood Needed',
          'description': 'Critical need for O- blood for accident victim',
          'bloodType': 'O-',
          'quantity': '3 units',
          'urgency': 'Critical',
          'hospital': 'CHUK',
          'location': 'Kigali',
          'date': '15/10/2025',
          'contactNumber': '+250782345678',
          'status': 'active',
        },
        {
          'id': '3',
          'title': 'A+ Blood Required',
          'description': 'Blood needed for cancer patient treatment',
          'bloodType': 'A+',
          'quantity': '1 unit',
          'urgency': 'High',
          'hospital': 'Kibagabaga Hospital',
          'location': 'Kigali',
          'date': '18/10/2025',
          'contactNumber': '+250783456789',
          'status': 'active',
        },
      ];

      for (var request in requests) {
        await db.insert('blood_requests', request);
      }
    }

    // Check if campaigns table is empty
    final campaignCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM campaigns'));
    if (campaignCount == 0) {
      final campaigns = [
        {
          'id': '1',
          'title': 'APR 2025 Blood Drive',
          'description': 'Annual blood donation drive to support hospitals',
          'startDate': '12/10/2025',
          'endDate': '24/10/2025',
          'location': 'Kigali Convention Center',
          'organizer': 'Rwanda Biomedical Centre',
          'contactInfo': '+250788765432',
          'status': 'active',
        },
      ];

      for (var campaign in campaigns) {
        await db.insert('campaigns', campaign);
      }
    }

    // Check if donation_centers table is empty
    final centerCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM donation_centers'));
    if (centerCount == 0) {
      final centers = [
        {
          'id': '1',
          'name': 'RBC City Center',
          'address': 'KN 3 Ave, Kigali',
          'city': 'Kigali',
          'phoneNumber': '+250788123456',
          'email': 'rbc.city@rbc.gov.rw',
          'workingHours': 'Mon-Fri: 8:00 AM - 5:00 PM, Sat: 9:00 AM - 1:00 PM',
          'latitude': -1.9575,
          'longitude': 30.0647,
        },
      ];

      for (var center in centers) {
        await db.insert('donation_centers', center);
      }
    }
  }

  // FIXED: getBloodRequests method
  Future<List<Map<String, dynamic>>> getBloodRequests() async {
    try {
      final db = await database;
      final result = await db.query(
        'blood_requests',
        where: 'status = ?',
        whereArgs: ['active'],
      );
      return result;
    } catch (e) {
      print('Error in getBloodRequests: $e');
      // Return empty list if there's an error
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCampaigns() async {
    try {
      final db = await database;
      final result = await db.query(
        'campaigns',
        where: 'status = ?',
        whereArgs: ['active'],
      );
      return result;
    } catch (e) {
      print('Error in getCampaigns: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDonationCenters() async {
    try {
      final db = await database;
      final result = await db.query('donation_centers');
      return result;
    } catch (e) {
      print('Error in getDonationCenters: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getDonorById(String id) async {
    try {
      final db = await database;
      final maps = await db.query(
        'donors',
        where: 'id = ?',
        whereArgs: [id],
      );
      return maps.isNotEmpty ? maps.first : null;
    } catch (e) {
      print('Error in getDonorById: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getDonorByEmail(String email) async {
    try {
      final db = await database;
      final maps = await db.query(
        'donors',
        where: 'email = ?',
        whereArgs: [email],
      );
      return maps.isNotEmpty ? maps.first : null;
    } catch (e) {
      print('Error in getDonorByEmail: $e');
      return null;
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    try {
      final db = await database;
      final maps = await db.query(
        'donors',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      return maps.isNotEmpty;
    } catch (e) {
      print('Error in authenticateUser: $e');
      return false;
    }
  }

  Future<bool> registerUser(String email, String password, Map<String, dynamic> userData) async {
    try {
      final db = await database;

      // Check if user already exists
      final existing = await db.query(
        'donors',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (existing.isNotEmpty) {
        return false;
      }

      final newUser = {
        ...userData,
        'email': email,
        'password': password,
        'id': '${DateTime.now().millisecondsSinceEpoch}',
      };

      await db.insert('donors', newUser);
      return true;
    } catch (e) {
      print('Error in registerUser: $e');
      return false;
    }
  }

  Future<bool> updateDonor(Map<String, dynamic> donor) async {
    try {
      final db = await database;
      final rows = await db.update(
        'donors',
        donor,
        where: 'id = ?',
        whereArgs: [donor['id']],
      );
      return rows > 0;
    } catch (e) {
      print('Error in updateDonor: $e');
      return false;
    }
  }
}