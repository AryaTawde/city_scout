import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(

  );

  Future<UserCredential?> signInWithGoogle() async {
  try {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      return await _auth.signInWithPopup(googleProvider);
    }

    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);

  } catch (e) {
    print(e);
    return null;
  }
}

  Future<void> signOut() async {

    await _googleSignIn.signOut();

    await _auth.signOut();

  }

}