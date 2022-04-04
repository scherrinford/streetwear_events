// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:streetwear_events/models/Event.dart';
//
// class EventDao {
//   // 1
//   final CollectionReference collection =
//   FirebaseFirestore.instance.collection('events');
//
//   final eventDao = DataBaseService();
//
//   saveProduct(Event event) {
//     print(event);
//     if (event == null) {
//       var newProduct = Event(uid, name, description, location, eventId, date, time);
//       eventDao.saveProduct(newProduct);
//     } else {
//       //Update
//       var updatedProduct = Product(name: _name, price: _price, uid: _uid, descryption: _description,category: _category,productId: _productId);
//       firestoreService.saveProduct(updatedProduct);
//     }
//   }
// }