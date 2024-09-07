import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<User?> signinWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;
      final creds = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(creds);
      return userCredential.user;
    } catch (e) {
      print("Google sign-in failed: $e");
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
