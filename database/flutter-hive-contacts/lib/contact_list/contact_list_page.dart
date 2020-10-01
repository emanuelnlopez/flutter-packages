import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hive_contacts/contact_list/contact_list_bloc.dart';
import 'package:flutter_hive_contacts/contact_list/new_contact_form.dart';
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
              List<Widget> children = [];
              if (snapshot.hasData == true) {
                children.add(
                  Expanded(
                    child: ListView.builder(
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
                    ),
                  ),
                );
              } else {
                children.add(
                  Expanded(child: Container()),
                );
              }
              children.add(
                NewContactForm(bloc: _bloc),
              );
              return Column(
                children: children,
              );
            }),
      ),
    );
  }
}
