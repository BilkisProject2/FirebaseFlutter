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


    /*
  First understand the whole flow

Suppose your phone number is:

+91 9876543210
Step 1

User enters phone number.

9876543210

↓

Step 2

Flutter asks Firebase

"Please send an OTP."

↓

Firebase sends

652831

to the user's phone.

↓

Step 3

User types

652831

↓

Step 4

Flutter sends OTP back to Firebase.

↓

Firebase checks

Correct?

YES ✅

↓

User is logged in.

There are only TWO functions
loginWithPhone()

Purpose:

Send OTP.

verifyOtp()

Purpose:

Verify OTP and login.

Function 1
Future<void> verifyOtp({

Let's go word by word.

Future

Means

This function takes some time.

Because Firebase is on the Internet.

Think

Phone

↓

Internet

↓

Firebase

↓

Wait...

It cannot happen instantly.

<void>

Means

This function returns nothing.

Example

verifyOtp()

↓

Nothing comes back.

It only logs the user in.

verifyOtp

Function name.

You could even write

checkOtp()

or

login()

But

verifyOtp

is the best name because that's what it does.

Next
required String verificationId,

This means

This function needs

verificationId

What is that?

When Firebase sends OTP,

it also gives you

verificationId

Think of it like

OTP Ticket Number

Example

verificationId

=

ABCD123XYZ

It is NOT the OTP.

It is just an ID Firebase uses.

Next
required String smsCode,

This is

The OTP typed by the user.

Example

652831

So now we have

verificationId

ABCD123XYZ

and

OTP

652831
Next
}) async {

Remember

async

means

This function will wait for Firebase.

Next
PhoneAuthCredential credential =

This creates a variable

called

credential

Think

credential

↓

Login Card

Firebase needs this login card.

Next
PhoneAuthProvider.credential(

This creates the login card.

Imagine

verificationId

+

OTP

↓

Credential
Next
verificationId: verificationId,

This sends

ABCD123XYZ

to Firebase.

Next
smsCode: smsCode,

This sends

652831

to Firebase.

Now Firebase has

verificationId

+

OTP

It can verify them.

Next
await auth.signInWithCredential(credential);

Very important.

This means

Credential

↓

Firebase

↓

Login User

If OTP is correct

User Logged In

If OTP is wrong

Login Failed
End
verifyOtp()

finished.
Second Function
Future<void> loginWithPhone({

Purpose

Send OTP

This function DOES NOT login.

It only sends OTP.

Next
required String phone,

Phone number.

Example

+919876543210
Next
required Function(String verificationId) codeSent,

This means

When Firebase sends OTP,

call this function.

Imagine

Firebase

↓

OTP Sent

↓

Run codeSent()

Inside

Firebase gives

verificationId

because you'll need it later.

Next
required Function(FirebaseAuthException e) failed,

If something goes wrong,

call this function.

Example

Invalid Phone

↓

failed()

or

Network Error

↓

failed()
Next
await auth.verifyPhoneNumber(

This is the Firebase function.

It sends OTP.

Think

Phone Number

↓

Firebase

↓

Send OTP
Next
phoneNumber: phone,

Send the phone number.

Example

+919876543210
Next
verificationCompleted:

Sometimes Android automatically reads the OTP.

User never types it.

Example

SMS arrives

↓

Android reads it

↓

Auto Login

That's what this callback handles.

Inside

await auth.signInWithCredential(credential);

Automatically logs the user in.

Next
verificationFailed: failed,

If sending OTP fails,

run

failed()

Example

Wrong phone number

↓

failed()
Next
codeSent:

This runs when

Firebase successfully sends OTP.

Example

Firebase

↓

OTP Sent

↓

codeSent()
Next
(String verificationId, int? token)

Firebase gives

verificationId

and

token

Most apps ignore the token.

Next
codeSent(verificationId);

Call YOUR function.

Pass the verificationId.

Later,

when user enters OTP,

you'll use it in

verifyOtp()
Last
codeAutoRetrievalTimeout:

Suppose Android waits for automatic OTP reading.

Nothing happens.

After some time,

Firebase says

Time Out

This callback runs.

Many apps leave it empty.

Complete Flow
User enters phone

↓

loginWithPhone()

↓

Firebase sends OTP

↓

codeSent()

↓

Save verificationId

↓

User enters OTP

↓

verifyOtp()

↓

Create Credential

↓

Firebase checks OTP

↓

signInWithCredential()

↓

Logged In ✅
Easy memory trick

There are only 3 important Firebase methods to remember:

Method	Easy Meaning
verifyPhoneNumber()	Send OTP
PhoneAuthProvider.credential()	Create a login credential using verificationId + OTP
signInWithCredential()	Log the user in using that credential

So whenever you see this code again, think:

loginWithPhone() → Send OTP
verifyOtp() → Check OTP and log the user in
  */
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
    // phoneNumber: phone,
    //  verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
    //   verificationFailed: (FirebaseAuthException error) {  }, 
    //   codeSent: (String verificationId, int? forceResendingToken) {  }, 
    //   codeAutoRetrievalTimeout: (String verificationId) {  },

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