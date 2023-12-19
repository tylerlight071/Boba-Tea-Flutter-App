import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    //begin interactive sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser != null) {
      //obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      //create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return null;
    }
  }
}
