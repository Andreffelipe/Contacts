import 'package:contact/models/contact.model.dart';
import 'package:contact/repositories/contact.repository.dart';
import 'package:mobx/mobx.dart';

part 'home.controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  bool showSearch = false;

  @observable
  ObservableList<ContactModel> contacts = ObservableList<ContactModel>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String term) async {
    final repository = ContactRepository();
    contacts = ObservableList<ContactModel>();
    var data = await repository.search(term);
    contacts.addAll(data);
  }
}
