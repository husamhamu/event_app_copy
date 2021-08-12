import 'package:event_app/app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      //email: "fake.email@fake.com", password: "fake123"
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // await userCredential.user!.updateDisplayName('User Name');
      print('just signed in ${userCredential.user!.displayName}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      errorCallback(e);
    }
  }

  //
  // Future<User> signInAnonymously() async {
  //   final authResult = await _firebaseAuth.signInAnonymously();
  //   return _userFromFirebase(authResult.user);
  // }

  // Future<User> signInWithGoogle() async {
  //   final googleUser = await _googleSignIn.signIn();
  //   final googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   final authResult = await _firebaseAuth.signInWithCredential(credential);
  //   return _userFromFirebase(authResult.user);
  // }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<User?> currentUser() async {
    // _firebaseAuth.userChanges().listen((event) {
    //
    // });
    return _firebaseAuth.currentUser;
  }
}
