import 'package:firebase_auth/firebase_auth.dart';
import 'package:mosq/models/masjid.dart';
import 'package:mosq/models/user.dart' as ModelUser;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user based on Firebase User
  ModelUser.User? _mapUser(User? user) {
    if (user == null) {
      return null;
    }

    ModelUser.User result = ModelUser.User(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
    );
    return result;
  }

  // Auth user stream change
  Stream<ModelUser.User?> get user {
    return _auth.authStateChanges().map(_mapUser);
  }

  // Sign In with email pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result.user == null) {
        return null;
      } else {
        var user = _mapUser(result.user) as ModelUser.User;
        await user.loadMasjid();
        return user;
      }
    } on FirebaseAuthException catch(e) {
      final String? error;
      switch (e.code) {
        case 'wrong-password':
          error = 'Wrong username or password.';
          break;
        case 'user-not-found':
          error = 'Wrong username or password,';
          break;
        case 'user-disabled':
          error = 'User is disabled, please contact administrator.';
          break;
        case 'invalid-email':
          error = 'Invalid email';
          break;
        default:
          error = null;
          print(e.code);
      }
      return error;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Register email pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (result.user == null) {
        return null;
      } else {

        Masjid masjid = Masjid(nama: 'Masjid Agung Jami');
        await masjid.save();

        ModelUser.User user = _mapUser(result.user) as ModelUser.User;
        user.masjidId = masjid.id;
        await user.save();

        user.masjid = masjid;

        return user;
      }
    } on FirebaseAuthException catch(e) {
      final String? error;
      switch(e.code) {
        case 'weak-password':
          error = 'Please use stronger password';
          break;
        case 'email-already-in-use':
          error = 'Email already in use';
          break;
        case 'invalid-email':
          error = 'Invalid email';
          break;
        case 'operation-not-allowed':
          error = 'Operation not allowed';
          break;
        default:
          error = null;
          print(e.code);
      }
      return error;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
