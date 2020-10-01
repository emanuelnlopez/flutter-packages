import 'package:flutter/material.dart';

typedef OnDataSubmitted = Null Function(String name, String age);

class ContactFormDialog extends StatefulWidget {
  const ContactFormDialog({
    this.age,
    @required this.callback,
    Key key,
    this.name,
  })  : assert(callback != null),
        isNew = age == null,
        super(key: key);

  final int age;
  final OnDataSubmitted callback;
  final String name;
  final bool isNew;

  @override
  _ContactFormDialogState createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();

  String _age;
  String _name;

  @override
  void initState() {
    super.initState();
    _age = widget.age?.toString();
    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {
            _formKey.currentState.save();
            widget.callback(_name, _age);
            Navigator.pop(context);
          },
          child: Text(widget.isNew ? 'Save' : 'Update'),
        ),
      ],
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              initialValue: _name,
              onSaved: (value) => _name = value,
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              initialValue: _age,
              keyboardType: TextInputType.number,
              onSaved: (value) => _age = value,
            ),
          ],
        ),
      ),
      title: Text(widget.isNew ? 'Add contact' : 'Update contact'),
    );
  }
}
