import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/Provider/authRepositoryProvider.dart';
import 'package:flutter_application_1/Rivepod/loginpart/screen/LoginScreen.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    setState(() {
      loading = true;
    });

    try {
      await ref.read(authRepositoryProvider).signup(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      Utils().toastMessage("Account Created Successfully");

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
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
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  }

                  if (value.length < 6) {
                    return "Password should be at least 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 40),

              Roundbutton(
                title: "Sign Up",
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signup();
                  }
                },
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text("Already have an account?"),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text("Login"),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}