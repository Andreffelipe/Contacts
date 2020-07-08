import 'package:contact/android/views/details.view.dart';
import 'package:contact/android/views/editor-contact.view.dart';
import 'package:contact/android/widget/contact.list.item.dart';
import 'package:contact/android/widget/search-appbar.widget.dart';
import 'package:contact/controllers/home.controller.dart';
import 'package:contact/models/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    controller.search('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: SearchAppBar(
            controller: controller,
          ),
          preferredSize: Size.fromHeight(kToolbarHeight)),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            return ContactListItem(model: controller.contacts[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                model: ContactModel(id: 0),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
