import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {

  final FirebaseAuth auth = FirebaseAuth.instance;
   User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) {

    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  Future<UserCredential> signup({
    required String email,
    required String password,
  }) {

    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  Future<void> logout() async {

    await auth.signOut();

  }

  Future<void> forgotPassword(String email) async {

    await auth.sendPasswordResetEmail(
      email: email,
    );

  }
  Future<void> verifyOtp({
  required String verificationId,
  required String smsCode,
}) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );

  await auth.signInWithCredential(credential);
}

Future<void> loginWithPhone({
  required String phone,
  required Function(String verificationId) codeSent,
  required Function(FirebaseAuthException e) failed,
}) async {
  await auth.verifyPhoneNumber(
    phoneNumber: phone,

    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    },

    verificationFailed: failed,

    codeSent: (String verificationId, int? token) {
      codeSent(verificationId);
    },

    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

}