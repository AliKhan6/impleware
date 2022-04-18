import 'package:calkitna_mobile_app/core/models/allergy.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  /// Register app user
  registerAppUser(AppUser user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('app_user')
          .doc(user.id)
          .set(user.toJson())
          .then((value) => debugPrint('user registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Get User from database using this funciton
  Future<AppUser> getAppUser(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('app_user').doc(id).get();
      debugPrint('Client Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data()!, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  updateClientFcm(token, id) async {
    await _db.collection("app_user").doc(id).update({'fcmToken': token}).then(
        (value) => debugPrint('fcm updated successfully'));
  }

  Future<List<Allergy>> getAllergies() async {
    debugPrint("getAllergies/");
    try {
      List<Allergy> post = [];
      QuerySnapshot snapshot = await _db.collection('allergies').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No allergies found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            Allergy.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('Allergies :: db => ${post.length}');

      return post;
    } catch (e, s) {
      debugPrint("Exception/getAllergies=========> $e, $s");
      return [];
    }
  }

  /// Register app user
  addMedicine(String id, Medicine medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('medicines')
          .add(medicine.toJson())
          .then((value) => debugPrint('medicines added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Register app user
  updateMedicine(String id, Medicine medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('medicines')
          .doc(medicine.id)
          .update(medicine.toJson())
          .then((value) => debugPrint('medicines added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  Future<List<Medicine>> getAllMedicines(String id) async {
    debugPrint("getAllMedicines/");
    try {
      List<Medicine> post = [];
      QuerySnapshot snapshot = await _db
          .collection('app_user')
          .doc(id)
          .collection('medicines')
          .get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No medicines found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            Medicine.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('Medicines :: db => ${post.length}');

      return post;
    } catch (e, s) {
      debugPrint("Exception/getMedicins=========> $e, $s");
      return [];
    }
  }
}
