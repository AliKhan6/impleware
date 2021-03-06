import 'package:calkitna_mobile_app/core/models/allergy.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/documents.dart';
import 'package:calkitna_mobile_app/core/models/measurements.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/models/medicine_images.dart';
import 'package:calkitna_mobile_app/core/models/patient_record.dart';
import 'package:calkitna_mobile_app/core/models/pharmacist.dart';
import 'package:calkitna_mobile_app/core/models/symptom_checker.dart';
import 'package:calkitna_mobile_app/core/models/symptoms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/chat.dart';
import '../models/settings.dart';

class DatabaseService {
  final firestoreRef = FirebaseFirestore.instance;
  final firebaseDb = FirebaseDatabase.instance.ref().child('chat_system');
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

  /// Register app user
  addPatientRecord(PatientRecord user, String id) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('patient_record')
          .doc(id)
          .set(user.toJson())
          .then((value) => debugPrint('user record registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  // Register app user
  updatePatientRecord(PatientRecord user) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('patient_record')
          .doc(user.id)
          .update(user.toJson())
          .then((value) => debugPrint('user record registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Register app user
  addMeasurements(Measurements user, String id) async {
    debugPrint("User @Id => ${user.id}");
    try {
      await _db
          .collection('measurements')
          .doc(id)
          .set(user.toJson())
          .then((value) => debugPrint('user record registered successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAppUser');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Get User from database using this funciton
  Future<PatientRecord> getPatientRecord(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('patient_record').doc(id).get();
      if (snapshot.exists) {
        debugPrint('patinet record Data: ${snapshot.data()}');
        return PatientRecord.fromJson(snapshot.data()!, snapshot.id);
      } else {
        return PatientRecord();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return PatientRecord();
    }
  }

  /// Get User from database using this funciton
  Future<Measurements> getMeasurements(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('measurements').doc(id).get();
      if (snapshot.exists) {
        debugPrint('Measurements Data: ${snapshot.data()}');
        return Measurements.fromJson(snapshot.data()!, snapshot.id);
      } else {
        return Measurements();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return Measurements();
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

  /// Get User from database using this funciton
  Future<Pharmacist> getPharmacist(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getPharmacist: id: $id');
    try {
      final snapshot = await _db.collection('pharmacists').doc(id).get();
      debugPrint('Pharmacist Data: ${snapshot.data()}');
      return Pharmacist.fromJson(snapshot.data()!, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getPharmacist');
      debugPrint(s.toString());
      return Pharmacist();
    }
  }

  updateClientFcm(AppUser appUser, id) async {
    await _db
        .collection("app_user")
        .doc(id)
        .update(appUser.toJson())
        .then((value) => debugPrint('fcm updated successfully'));
  }

  updatePharmacist(Pharmacist appUser, id) async {
    await _db
        .collection("pharmacists")
        .doc(id)
        .update(appUser.toJson())
        .then((value) => debugPrint('fcm updated successfully'));
  }

  Future<List<AppUser>> getAppUsers() async {
    debugPrint("getAppUsers/");
    try {
      List<AppUser> post = [];
      QuerySnapshot snapshot = await _db.collection('app_user').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No users found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            AppUser.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('users :: db => ${post.length}');

      return post;
    } catch (e, s) {
      debugPrint("Exception/gettingUsers=========> $e, $s");
      return [];
    }
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
  updateAllergies(String id, int isSelected) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('allergies')
          .doc(id)
          .update({'isSelected': isSelected}).then(
              (value) => debugPrint('allergy updated successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
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
  addSettins(String id, Setting medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('settings')
          .doc(id)
          .set(medicine.toJson())
          .then((value) => debugPrint('medicines added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Get User from database using this funciton
  Future<Setting> getSettins(id) async {
    //Todo: Rename getUsers -> getUser
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('settings').doc(id).get();
      if (snapshot.exists) {
        debugPrint('settings Data: ${snapshot.data()}');
        return Setting.fromJson(snapshot.data()!, snapshot.id);
      } else {
        return Setting();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return Setting();
    }
  }

  /// Register app user
  addMedicineImages(String id, String medicine) async {
    DateTime now = DateTime.now();
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('medicine-images')
          .add({'imageUrl': medicine, 'createdAt': now}).then(
              (value) => debugPrint('medicine image added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  Future<List<MedicineImages>> getMedicineImages(String id) async {
    debugPrint("getMedicineImages/");
    try {
      List<MedicineImages> post = [];
      QuerySnapshot snapshot = await _db
          .collection('app_user')
          .doc(id)
          .collection('medicine-images')
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No allergies found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(MedicineImages.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('Allergies :: db => ${post.length}');

      return post;
    } catch (e, s) {
      debugPrint("Exception/getAllergies=========> $e, $s");
      return [];
    }
  }

  Future<List<Documents>> getDocuments(String id) async {
    debugPrint("getDocuments/");
    try {
      List<Documents> post = [];
      QuerySnapshot snapshot = await _db
          .collection('app_user')
          .doc(id)
          .collection('documents')
          .get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No allergies found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            Documents.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('Allergies :: db => ${post.length}');

      return post;
    } catch (e, s) {
      debugPrint("Exception/getAllergies=========> $e, $s");
      return [];
    }
  }

  /// Register app user
  addDocument(String id, Documents medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('documents')
          .add(medicine.toJson())
          .then((value) => debugPrint('Document image added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Register app user
  deleteDocument(String id, Documents medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('documents')
          .doc(medicine.id)
          .delete()
          .then((value) => debugPrint('Document image deleted successfully'));
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

  /// Register app user
  deleteMedicine(String id, Medicine medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('medicines')
          .doc(medicine.id)
          .delete()
          .then((value) => debugPrint('medicines deleted successfully'));
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

  ///
  /// ==================>>>> Pharmacist users working area ================ ///
  ///
  Future<List<Pharmacist>> getPharmacists() async {
    debugPrint("getAllPharmacists/");
    try {
      List<Pharmacist> post = [];
      QuerySnapshot snapshot = await _db.collection('pharmacists').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No pharmacists found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            Pharmacist.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('Pharmacists :: db => ${post.length}');
      return post;
    } catch (e, s) {
      debugPrint("Exception/getPharmacists=========> $e, $s");
      return [];
    }
  }

  ///
  /// disease symptoms
  Future<List<Symptoms>> getSymptoms() async {
    debugPrint("getSymptoms/");
    try {
      List<Symptoms> post = [];
      QuerySnapshot snapshot = await _db.collection('symptoms').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No symptoms found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            Symptoms.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('symptoms :: db => ${post.length}');
      return post;
    } catch (e, s) {
      debugPrint("Exception/getSymptoms=========> $e, $s");
      return [];
    }
  }

  /// Register app user
  addMySymptoms(String id, SymptomChecker medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('symptoms')
          .add(medicine.toJson())
          .then((value) => debugPrint('symptoms added successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/addMedicine');
      debugPrint(s.toString());
      return false;
    }
  }

  /// Register app user
  updateMySymptoms(String id, SymptomChecker medicine) async {
    debugPrint("User @Id => $id");
    try {
      await _db
          .collection('app_user')
          .doc(id)
          .collection('symptoms')
          .doc(medicine.id)
          .update(medicine.toJson())
          .then((value) => debugPrint('symptoms updated successfully'));
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateSymptoms');
      debugPrint(s.toString());
      return false;
    }
  }

  Future<List<SymptomChecker>> getMySymptoms(String id) async {
    debugPrint("getAllSymptoms/");
    try {
      List<SymptomChecker> post = [];
      QuerySnapshot snapshot =
          await _db.collection('app_user').doc(id).collection('symptoms').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No symptoms found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(SymptomChecker.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      debugPrint('symptoms :: db => ${post.length}');
      return post;
    } catch (e, s) {
      debugPrint("Exception/getMySymptoms=========> $e, $s");
      return [];
    }
  }

  ////***************************************************************************** */
  ////***************************************************************************** */
  /// [[Chat messages are for both apps]]********************************* */
  ////***************************************************************************** */
  ////***************************************************************************** */

  ///
  /// Send message to database
  sendMessage(Chat message) {
    print('@sendMessage');
    try {
      firebaseDb
          .child('messages')
          .child('${message.pharmacistId}_${message.userId}')
          .push()
          .set(message.toJson())
          .then((value) => print('Message sent successfull!!!'));
    } catch (e) {
      print('Exception @sendMessageFirebaseDb: $e');
    }
  }

  ///
  /// Get messages as stream
  getMessagesStream(String stylistId, String customerId) {
    print('@getMessagesStream');
    Stream stream;
    try {
      stream = firebaseDb
          .child('messages')
          .child('${stylistId}_$customerId')
          .onChildAdded;
      return stream;
    } catch (e) {
      print('Exception @getMessagesStream: $e');
    }
  }
}
