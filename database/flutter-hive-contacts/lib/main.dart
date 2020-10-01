import 'package:flutter/material.dart';
import 'package:flutter_hive_contacts/contacts_app.dart';
import 'package:flutter_hive_contacts/data/contact.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  runApp(ContactsApp());
}
