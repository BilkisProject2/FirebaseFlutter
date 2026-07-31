import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/screen/VerifyOtpScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

import '../../../widgets/RoundButton.dart';
import '../../../ui/Utils/utils.dart';

class LoginWithPhoneScreen extends ConsumerStatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  ConsumerState<LoginWithPhoneScreen> createState() =>
      _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState
    extends ConsumerState<LoginWithPhoneScreen> {

  final phoneController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final repo = ref.read(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "+91xxxxxxxxxx",
              ),
            ),

            const SizedBox(height: 40),

            Roundbutton(

              title: "Send OTP",

              loading: loading,

              onTap: () async {

                setState(() {
                  loading = true;
                });

                await repo.loginWithPhone(

                  phone: phoneController.text,

                  codeSent: (verificationId) {

                    setState(() {
                      loading = false;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyOtpScreen(
                          verificationId: verificationId,
                        ),
                      ),
                    );

                  },

                  failed: (e) {

                    setState(() {
                      loading = false;
                    });

                    Utils().toastMessage(e.message.toString());

                  },

                );

              },

            )

          ],
        ),
      ),
    );
  }
}