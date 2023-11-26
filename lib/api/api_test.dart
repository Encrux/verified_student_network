import 'package:cloud_firestore/cloud_firestore.dart';

class TestApi {


  static Future<void> write() async {
    final db = FirebaseFirestore.instance;

    print("testdata");
    QuerySnapshot snapshot = await db.collection('posts').get();
    snapshot.docs.forEach((doc) {
      print(doc.data());
    });

    print("write");


    final cities = db.collection("cities");
    cities.add({
      "name": "Tokyo",
      "country": "Japan"
    });
    final data1 = <String, dynamic>{
      "name": "San Francisco",
      "state": "CA",
      "country": "USA",
      "capital": false,
      "population": 860000,
      "regions": ["west_coast", "norcal"]
    };
    cities.doc("SF").set(data1);

    final data2 = <String, dynamic>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA",
      "capital": false,
      "population": 3900000,
      "regions": ["west_coast", "socal"],
    };
    cities.doc("LA").set(data2);

    final data3 = <String, dynamic>{
      "name": "Washington D.C.",
      "state": null,
      "country": "USA",
      "capital": true,
      "population": 680000,
      "regions": ["east_coast"]
    };
    cities.doc("DC").set(data3);

    final data4 = <String, dynamic>{
      "name": "Tokyo",
      "state": null,
      "country": "Japan",
      "capital": true,
      "population": 9000000,
      "regions": ["kanto", "honshu"]
    };
    cities.doc("TOK").set(data4);

    final data5 = <String, dynamic>{
      "name": "Beijing",
      "state": null,
      "country": "China",
      "capital": true,
      "population": 21500000,
      "regions": ["jingjinji", "hebei"],
    };

    try {
      await cities.doc("BJ").set(data5);
    } catch (e) {
      print(e);
    }
  }
}