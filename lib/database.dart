import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  late FirebaseFirestore firestore;
  // initialise()
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String code) async {
    try {
      await firestore.collection("countries").add({
        "name": name,
        "code": code,
        "timestrap": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("countries").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>?> read() async {
    QuerySnapshot querySnapshot;
    List<dynamic> docs = [];
    try {
      querySnapshot = await firestore.collection('countries').get();
      // if (querySnapshot.docs.isNotEmpty) {}

      if (querySnapshot.docs.isEmpty) {
        print("error return");
      } else {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc["name"], "code": doc["code"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (ex) {
      print(ex);
    }
    return null;
  }

  Future<void> update(String id, String name, String code) async {
    try {
      await firestore
          .collection("countries")
          .doc(id)
          .update({"name": name, "code": code});
    } catch (e) {
      print(e);
    }
  }
}
