import lib.session
import os

def fix_file(file_path, old_text, new_text):
    with open(file_path, 'r') as file:
        content = file.read()

    if old_text in content:
        content = content.replace(old_text, new_text)
        with open(file_path, 'w') as file:
            file.write(content)
        print(f"Fixed: {file_path}")
    else:
        print(f"Text not found in: {file_path}")

# Add math imports
print("Adding math imports...")
fix_file(
    "lib/services/database_service.dart",
    "import 'package:sqflite/sqflite.dart';",
    "import 'dart:math';\nimport 'package:sqflite/sqflite.dart';"
)

fix_file(
    "lib/models/donation_center_model.dart",
    "class DonationCenter {",
    "import 'dart:math';\n\nclass DonationCenter {"
)

# Fix null safety issues
print("\nFixing null safety issues...")
fix_file(
    "lib/screens/verify_record_1.dart",
    "border: Border.all(color: Colors.grey[200]),",
    "border: Border.all(color: Colors.grey[200]!),"
)

fix_file(
    "lib/screens/verify_record_2.dart",
    "border: Border.all(color: Colors.blue[100]),",
    "border: Border.all(color: Colors.blue[100]!),"
)

print("\nDone! Run 'flutter clean && flutter pub get && flutter run'")