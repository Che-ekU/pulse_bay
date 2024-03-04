import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pulse_bay_task/app/app_provider.dart';
import 'package:pulse_bay_task/app/constants/assets.dart';
import 'package:pulse_bay_task/app/constants/constants.dart';
import 'package:pulse_bay_task/app/constants/theme.dart';
import 'package:pulse_bay_task/app/widgets/primary_button.dart';
import 'package:pulse_bay_task/home/home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PulseBayTheme.bgColor,
      bottomSheet: const _BottomForm(),
      appBar: AppBar(
        backgroundColor: PulseBayTheme.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.leftChevron),
          onPressed: () {},
        ),
      ),
      body: SizedBox(
        height: 200,
        child: Center(
          child: Image.asset(Assets.pulsebayLogo, width: 200),
        ),
      ),
    );
  }
}

class _BottomForm extends StatefulWidget {
  const _BottomForm();

  @override
  State<_BottomForm> createState() => _BottomFormState();
}

class _BottomFormState extends State<_BottomForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: PulseBayTheme.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: PulseBayTheme.primaryColor),
            ),
            const SizedBox(height: 7),
            const Text(
              'Hello there, Sign in to continue!',
              style: TextStyle(fontSize: 12, color: PulseBayTheme.black),
            ),
            const SizedBox(height: 10),
            Transform.scale(
              scaleX: 1.07,
              child: const Divider(
                thickness: 0.3,
                color: Color(0xffC6C6C8),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email Address',
              style: TextStyle(
                fontSize: 14,
                color: PulseBayTheme.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: appProvider.emailController,
                    style: const TextStyle(
                      fontSize: 12,
                      color: PulseBayTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: PulseBayTheme.pbInputDecoration(
                      helperText: '',
                      hint: 'Enter Email Address...',
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 30),
                      fillColor: PulseBayTheme.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 5,
                      ),
                    ),
                    validator: (value) {
                      if (!RegExp(Constants.emailPattern)
                          .hasMatch(value ?? '')) {
                        return 'Invalid mail';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (String? value) {
                      // setState(() {
                      //   selectedValue = value;
                      // }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      color: PulseBayTheme.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, setState) => TextFormField(
                      controller: appProvider.passwordController,
                      style: const TextStyle(
                        fontSize: 12,
                        color: PulseBayTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      obscureText: !passwordVisible,
                      decoration: PulseBayTheme.pbInputDecoration(
                        hint: '******',
                        fillColor: PulseBayTheme.white,
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 30),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: passwordVisible
                                ? PulseBayTheme.black
                                : PulseBayTheme.black.withOpacity(0.2),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 5,
                        ),
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '*Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 12,
                  color: PulseBayTheme.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              onTapFunction: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  if (await appProvider.login()) {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Home(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email or password'),
                      ),
                    );
                  }
                }
              },
              buttonText: 'Login',
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account?',
                  style: TextStyle(
                    fontSize: 12,
                    color: PulseBayTheme.black,
                  ),
                ),
                Text(
                  ' Register!',
                  style: TextStyle(
                    fontSize: 12,
                    color: PulseBayTheme.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
