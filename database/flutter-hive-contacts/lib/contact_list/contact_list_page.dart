import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hive_contacts/contact_list/contact_form_dialog.dart';
import 'package:flutter_hive_contacts/contact_list/contact_list_bloc.dart';
import 'package:flutter_hive_contacts/data/contact.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ContactListBloc();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _bloc.getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Contacts App')),
      body: SafeArea(
        child: StreamBuilder<List<Contact>>(
          stream: _bloc.contactListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData == true && snapshot.data.isNotEmpty == true) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final contact = snapshot.data[index];
                  return ListTile(
                    onTap: () => _showContactEditionDialog(contact, index),
                    subtitle: Text('Age: ${contact.age}'),
                    title: Text('Name: ${contact.name}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _bloc.deleteContact(index),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('There are no contacts to display'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showContactCreationDialog,
      ),
    );
  }

  _showContactEditionDialog(Contact contact, int index) {
    showDialog(
      context: context,
      child: ContactFormDialog(
        age: contact.age,
        callback: (name, age) {
          final newContact = Contact(
            age: int.parse(age),
            name: name,
          );
          _bloc.editContact(newContact, index);
        },
        name: contact.name,
      ),
    );
  }

  void _showContactCreationDialog() {
    showDialog(
      context: context,
      child: ContactFormDialog(
        callback: (name, age) {
          final contact = Contact(
            age: int.parse(age),
            name: name,
          );
          _bloc.addContact(contact);
        },
      ),
    );
  }
}
