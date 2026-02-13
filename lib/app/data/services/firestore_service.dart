import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  Future<void> setDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(docId).set(data);
  }

  Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collection, String docId) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream(
      String collection, String docId) {
    return _firestore.collection(collection).doc(docId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(
      String collection) {
    return _firestore.collection(collection).snapshots();
  }
}
