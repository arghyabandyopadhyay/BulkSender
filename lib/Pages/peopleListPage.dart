import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';

class PeopleListPage extends StatefulWidget {
  @override
  _PeopleListPageState createState() => _PeopleListPageState();

  const PeopleListPage();
}
class _PeopleListPageState extends State<PeopleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(child: Text("hell"),),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.contact_phone),onPressed: () async {
        Contacts.addContact(new Contact(displayName: "Student Anay",phones: [Item(label: "mobile",value: "7224077631")])).then((value) => print(value.displayName));
      },),
    );
  }

}