import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  await GoogleSignIn.instance.initialize(
    clientId:
        "354532996095-f7fo016lr77ki7kus71si2s1o7o1ao83.apps.googleusercontent.com",
  );
  final GoogleSignInAccount account =
      await GoogleSignIn.instance.authenticate();
  final GoogleSignInAuthentication
  authentication = account.authentication;
  final credential =
      GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );
  return FirebaseAuth.instance
      .signInWithCredential(credential);
}

void listenAutState(
  Function(User?) onChangeAuthState,
) {
  FirebaseAuth.instance.authStateChanges().listen(
    onChangeAuthState,
  );
}
