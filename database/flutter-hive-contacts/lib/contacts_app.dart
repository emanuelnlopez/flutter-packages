import 'package:flutter/material.dart';
import 'package:flutter_hive_contacts/contact_list/contact_list_page.dart';
import 'package:hive/hive.dart';

class ContactsApp extends StatefulWidget {
  @override
  _ContactsAppState createState() => _ContactsAppState();
}

class _ContactsAppState extends State<ContactsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Contacts App',
      home: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return ContactListPage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
