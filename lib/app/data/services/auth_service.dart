import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxString userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(_auth.authStateChanges());
    ever(currentUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) async {
    if (user == null) {
      userRole.value = '';
    } else {
      await _fetchUserRole(user.uid);
    }
  }

  Future<void> _fetchUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        userRole.value = doc.data()?['role'] ?? 'anggota';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_role', userRole.value);
      }
    } catch (e) {
      print('Error fetching role: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role');
  }
}
