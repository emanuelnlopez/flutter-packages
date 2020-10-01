import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hive_contacts/contact_list/contact_list_bloc.dart';
import 'package:flutter_hive_contacts/data/contact.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final _formKey = GlobalKey<FormState>();

  ContactListBloc _bloc;
  String _name;
  String _age;

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

  void _showContactCreationDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () {
              _formKey.currentState.save();
              final contact = Contact(
                age: int.parse(_age),
                name: _name,
              );
              _bloc.addContact(contact);
              Navigator.pop(context);
            },
            child: Text('Add Contact'),
          ),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _age = value,
              ),
            ],
          ),
        ),
        title: Text('Add new contact'),
      ),
    );
  }
}
