import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/auth_feature/auth/validation/validation.dart';
import 'package:movies/features/auth_feature/presentation/manager/auth_cubit.dart';
import 'package:movies/features/auth_feature/presentation/manager/auth_state.dart';
import 'package:movies/nav_bar.dart';

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
  bool passwordVisible = false;
  bool rePasswordVisible = false;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successfully Done")),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeNavBar.routeName,
              (route) => false,
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
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
                        const SizedBox(height: 30),

                        // Create Account Button
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (registerKey.currentState!.validate()) {
                                      context.read<AuthCubit>().signUp(
                                            email: emailController.text.trim(),
                                            password: passwordController.text.trim(),
                                            fullName: nameController.text.trim(),
                                          );
                                    }
                                  },
                            child: state is AuthLoading
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
          },
        ),
      ),
    );
  }
}
