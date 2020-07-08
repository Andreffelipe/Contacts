import 'package:contact/android/views/address.view.dart';
import 'package:contact/android/views/editor-contact.view.dart';
import 'package:contact/android/views/home.view.dart';
import 'package:contact/android/views/loading.view.dart';
import 'package:contact/models/contact.model.dart';
import 'package:contact/repositories/contact.repository.dart';
import 'package:contact/shared/widgets/contact-details-image.widget.dart';
import 'package:contact/shared/widgets/contacts-details.description.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  final int id;

  DetailsView({
    @required this.id,
  });
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _repository = ContactRepository();

  onDelete() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Exclusão de Contato"),
          content: Text("deseja excluir este contato?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar")),
            FlatButton(onPressed: delete, child: Text("Excluir")),
          ],
        );
      },
    );
  }

  delete() {
    _repository
        .delete(widget.id)
        .then((_) => onSuccess())
        .catchError((error) => onError(error));
  }

  onSuccess() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  onError(error) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (context, snp) {
        if (snp.hasData) {
          ContactModel contact = snp.data;
          return page(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget page(BuildContext context, ContactModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          ContactDetailsImage(image: model.image),
          SizedBox(
            height: 10,
          ),
          ContactDetailsDescription(
              name: model.name, phone: model.phone, email: model.email),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch("tel://${model.email}");
                },
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: () {
                  launch("mailto://${model.email}");
                },
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.camera_enhance,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            title: Text(
              "Endereço",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.addressLine1 ?? "Nenhum endereço cadastrado",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  model.addressLine2 ?? "",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressView(),
                  ),
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Color(0xffff0000),
              child: FlatButton(
                onPressed: onDelete,
                child: Text(
                  "Excluir Contato",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                model: model,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
