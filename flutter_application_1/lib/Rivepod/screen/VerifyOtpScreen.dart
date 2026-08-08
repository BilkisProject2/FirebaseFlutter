import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/post_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

import '../../../posts/post_screen.dart';
import '../../../widgets/RoundButton.dart';
import '../../../ui/Utils/utils.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {

  final String verificationId;

  const VerifyOtpScreen({
    super.key,
    required this.verificationId,
  });

  @override
  ConsumerState<VerifyOtpScreen> createState() =>
      _VerifyOtpScreenState();
}

class _VerifyOtpScreenState
    extends ConsumerState<VerifyOtpScreen> {

  final otpController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final repo = ref.read(authRepositoryProvider);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Verify OTP"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter OTP",
              ),
            ),

            const SizedBox(height: 40),

            Roundbutton(

              title: "Verify",

              loading: loading,

              onTap: () async {

                setState(() {
                  loading = true;
                });

                try {

                 await repo.verifyOtp(
  verificationId: widget.verificationId,
  smsCode: otpController.text,
);

                  setState(() {
                    loading = false;
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PostScreen(),
                    ),
                  );

                } catch (e) {

                  setState(() {
                    loading = false;
                  });

                  Utils().toastMessage(e.toString());

                }

              },

            )

          ],
        ),
      ),
    );
  }
}