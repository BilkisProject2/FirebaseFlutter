import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/Provider/authRepositoryProvider.dart';
import 'package:flutter_application_1/Rivepod/loginpart/screen/VerfiedByOtp.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWithPhonenuber extends ConsumerStatefulWidget {
  const LoginWithPhonenuber({super.key});

  @override
  ConsumerState<LoginWithPhonenuber> createState() =>
      _LoginWithPhonenuberState();
}

class _LoginWithPhonenuberState
    extends ConsumerState<LoginWithPhonenuber> {
  final phonenumberContoller = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    phonenumberContoller.dispose();
    super.dispose();
  }

  Future<void> loginWithPhone() async {
    setState(() {
      loading = true;
    });

    try {
      await ref.read(authRepositoryProvider).loginWithPhone(
            phone: phonenumberContoller.text.trim(),

            codeSent: (verificationId) {
              setState(() {
                loading = false;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VerfiedByOtp(
                    verificationId: verificationId,
                  ),
                ),
              );
            },

            failed: (e) {
              setState(() {
                loading = false;
              });

              Utils().toastMessage(e.message ?? e.toString());
            },
          );
    } catch (e) {
      setState(() {
        loading = false;
      });

      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN WITH PHONE NUMBER"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: phonenumberContoller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "+91 9876543210",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 40),

            Roundbutton(
              title: "LOGIN WITH OTP",
              loading: loading,
              onTap: () {
                if (phonenumberContoller.text.trim().isEmpty) {
                  Utils().toastMessage("Enter Phone Number");
                } else {
                  loginWithPhone();
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}