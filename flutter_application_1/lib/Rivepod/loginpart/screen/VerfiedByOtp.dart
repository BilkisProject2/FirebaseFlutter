import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/Provider/authRepositoryProvider.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/post_screen.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VerfiedByOtp extends ConsumerStatefulWidget {
  final String verificationId;

  const VerfiedByOtp({
    super.key,
    required this.verificationId,
  });

  @override
  ConsumerState<VerfiedByOtp> createState() =>
      _VerfiedByOtpState();
}

class _VerfiedByOtpState
    extends ConsumerState<VerfiedByOtp> {

  final otpController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    if (otpController.text.trim().isEmpty) {
      Utils().toastMessage("Enter OTP");
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await ref.read(authRepositoryProvider).verifyOtp(
            verificationId: widget.verificationId,
            smsCode: otpController.text.trim(),
          );

      Utils().toastMessage("Login Successful");

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const PostScreen(),
          ),
        );
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VERIFY OTP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 40),

            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter 6 Digit OTP",
                prefixIcon: Icon(Icons.sms),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),

            Roundbutton(
              title: "VERIFY OTP",
              loading: loading,
              onTap: verifyOtp,
            ),

          ],
        ),
      ),
    );
  }
}