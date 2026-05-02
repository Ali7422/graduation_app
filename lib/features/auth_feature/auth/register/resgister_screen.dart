import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/auth_feature/auth/validation/valisation.dart';
// import 'package:movies/features/firebase/firebase_auth.dart'; // Firebase disabled

class ResgisterScreen extends StatefulWidget {
  const ResgisterScreen({super.key});
  static const String routeName = "/ResgisterScreen";

  @override
  State<ResgisterScreen> createState() => _ResgisterScreenState();
}

class _ResgisterScreenState extends State<ResgisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool passwordVisible = false;
  bool rePasswordVisible = false;
  bool isLoading = false;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
void dispose() {
  nameController.dispose();
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  phoneController.dispose();
  super.dispose();
}


  Future<void> onRegister() async {
    if (!registerKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please check your data")));
      return;
    }

    setState(() => isLoading = true);
    try {
      // Firebase disabled - registration bypassed
      // await FirebaseAuthService.createAccountWithEmailAndPassword(
      //   email: emailController.text.trim(),
      //   password: passwordController.text.trim(),
      //   name: nameController.text.trim(),
      //   phone: phoneController.text.trim(),
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successfully Done")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration failed: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: registerKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image placeholder
                Container(
                  width: 150,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gold, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/gamer (1).png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Name
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: AppValidator.validateName,
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person, color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: AppValidator.validateEmail,
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email, color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: AppValidator.validatePassword,
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: AppColors.white),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                      child: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => AppValidator.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                  controller: confirmPasswordController,
                  obscureText: !rePasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock, color: AppColors.white),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() => rePasswordVisible = !rePasswordVisible);
                      },
                      child: Icon(
                        rePasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: AppValidator.validatePhone,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: Icon(Icons.phone, color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 30),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : onRegister,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.black,
                          )
                        : const Text("Create Account"),
                  ),
                ),
                const SizedBox(height: 10),

                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.gold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
