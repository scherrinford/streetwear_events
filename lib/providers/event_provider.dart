import 'package:flutter/cupertino.dart';
import 'package:streetwear_events/models/Event.dart';
import 'package:streetwear_events/services/auth.dart';
import 'package:streetwear_events/services/database.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = DatabaseService();
  final authService = AuthService();
  String _name;
  String _uid;
  String _description;
  String _location;
  String _eventId;
  DateTime _dateTime;
  //var uuid = Uuid();

  //Getters
  String get name => _name;
  String get description => _description;
  String get location => _location;


  //Setters

  changeuid(String value) {
    _uid = value;
    notifyListeners();
  }

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  // changePrice(String value) {
  //   _price = double.parse(value);
  //   notifyListeners();
  // }
  //
  // changeCategory(String value) {
  //   _category =value;
  //   notifyListeners();
  // }

  changeDescription(String value){
    _description = value;
    notifyListeners();
  }

  loadValues(Event event){
    _name=event.name;
    _location = event.location;
    _uid = event.uid;
    _description = event.description;
    _eventId = event.eventId;
  }


  saveProduct() {
    print(_eventId);
    if (_eventId == null) {
      var newProduct = Event(_uid, _name, _description, _location, _eventId, _dateTime);
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct = Event(_uid, _name, _description, _location, _eventId, _dateTime);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId){
    firestoreService.removeProduct(productId);
  }

  getproduct(String productId){
    firestoreService.getProductById(productId);
  }

}