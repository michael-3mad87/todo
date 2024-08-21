import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/login_screen.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/home_page.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/taps/tasks/custom_button.dart';
import 'package:todo/taps/tasks/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: settingProvider.themMode == ThemeMode.light
                    ? AppTheme.darktItem
                    : AppTheme.white,
        ),
        title: Text(
          'Create Account',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: settingProvider.themMode == ThemeMode.light
                    ? AppTheme.darktItem
                    : AppTheme.white,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Name can not be less than 3 character';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'email can not be less than 5 character';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: passwordController,
                isPassword: true,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return 'Password can not be less than 8 character';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                label: 'Create Account',
                oppressed: register,
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: const Text(
                  'Already have an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
        nameController.text,
        passwordController.text,
        emailController.text,
      ).then(
        (user) {
          Provider.of<UserProvider>(context, listen: false).updateUser(user);
          Navigator.pushReplacementNamed(context, HomePage.routName);
        },
      ).catchError(
        (error) {
          Fluttertoast.showToast(
              msg: "Something wrong",
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.white,
              fontSize: 16.0);
        },
      );
    }
  }
}
