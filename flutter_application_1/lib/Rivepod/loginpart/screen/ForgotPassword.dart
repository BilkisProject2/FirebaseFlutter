import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/Provider/authRepositoryProvider.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() =>
      _ForgotPasswordState();
}

class _ForgotPasswordState
    extends ConsumerState<ForgotPassword> {
  final emailController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Email"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await ref
          .read(authRepositoryProvider)
          .forgotPassword(emailController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Reset Email Sent"),
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Roundbutton(
              title: "Forgot Password",
              loading: loading,
              onTap: resetPassword,
            ),

          ],
        ),
      ),
    );
  }
}