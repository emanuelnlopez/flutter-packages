import 'package:flutter/material.dart';
import 'package:flutter_hive_contacts/contact_list/contact_list_bloc.dart';
import 'package:flutter_hive_contacts/data/contact.dart';

class NewContactForm extends StatefulWidget {
  NewContactForm({
    Key key,
    @required this.bloc,
  })  : assert(bloc != null),
        super(key: key);

  final ContactListBloc bloc;

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _age;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _age = value,
              ),
            ),
            SizedBox(width: 12.0),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                _formKey.currentState.save();
                final contact = Contact(
                  age: int.parse(_age),
                  name: _name,
                );
                widget.bloc.addContact(contact);
              },
            ),
          ],
        ),
      ),
    );
  }
}
