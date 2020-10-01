import 'dart:async';

import 'package:flutter_hive_contacts/core/bloc.dart';
import 'package:flutter_hive_contacts/data/contact.dart';
import 'package:hive/hive.dart';

class ContactListBloc extends Bloc {
  final _contactListController = StreamController<List<Contact>>.broadcast();
  final Box _contactListBox = Hive.box('contacts');

  Stream<List<Contact>> get contactListStream => _contactListController.stream;

  @override
  void dispose() {
    _contactListController.close();
  }

  Future<void> addContact(Contact contact) async {
    await _contactListBox.add(contact);
    getContacts();
  }

  Future<void> getContacts() async {
    List<Contact> contactList = [];
    for (var i = 0; i < _contactListBox.length; i++) {
      contactList.add(_contactListBox.getAt(i) as Contact);
    }
    _contactListController.add(contactList);
  }

  Future<void> deleteContact(int index) async {
    await _contactListBox.deleteAt(index);
    getContacts();
  }
}
