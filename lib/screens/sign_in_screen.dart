import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/screens/main/main_screen.dart';
import 'package:progmob_magical_destroyers/screens/send_forgot_password_email_screen.dart';
import 'package:progmob_magical_destroyers/screens/sign_up_screen.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button_bottom_bar.dart';
import 'package:progmob_magical_destroyers/widgets/horizontal_divider.dart';
import 'package:progmob_magical_destroyers/widgets/icon_button_circ;e.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isRememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _toggleRememberMe() {
    setState(() {
      _isRememberMe = !_isRememberMe;
    });
  }

  bool _validateInput() {
    return _checkEmail(_emailController.text) == null &&
        _checkPassword(_passwordController.text) == null;
  }

  void _signIn() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed", "Please fill the form correctly");
      return;
    }

    Get.offAll(() => Main());
  }

  String? _checkEmail(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(title: "Welcome Back 👋"),
                SizedBox(height: 10),
                Text(
                    "Sign in to your account to continue your journey towards lorem ipsum dolor sit amet."),
                SizedBox(height: 25),
                Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _emailInput(),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _passwordInput(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _isRememberMe,
                            onChanged: (value) => _toggleRememberMe(),
                            activeColor: ColorPlanet.primary,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _toggleRememberMe(),
                          child: Text("Remember me"),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => SendForgotPasswordEmail()),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPlanet.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Doesn't have an account? "),
                    TextButton(
                      onPressed: () {
                        Get.off(() => SignUp());
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: ColorPlanet.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                HorizontalDivider(text: "or continue with"),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButtonCircle(
                      icon: Image.asset('assets/google_icon.png'),
                    ),
                    SizedBox(width: 20),
                    IconButtonCircle(
                      icon: Image.asset('assets/facebook_icon.png'),
                    ),
                    SizedBox(width: 20),
                    IconButtonCircle(
                      icon: Image.asset('assets/github_icon.png'),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: "Sign In",
            onPressed: () {
              _signIn();
            },
          )
        ],
      ),
    );
  }

  TextFormField _passwordInput() {
    return TextFormField(
      controller: _passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkPassword(value),
      textAlignVertical: TextAlignVertical.center,
      obscureText: _isPasswordHidden,
      cursorColor: ColorPlanet.primary,
      cursorErrorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.black,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Color(0xff9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Color.fromARGB(101, 241, 241, 241),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black,
          ),
          onPressed: () => _togglePasswordVisibility(),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextFormField _emailInput() {
    return TextFormField(
      controller: _emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkEmail(value),
      textAlignVertical: TextAlignVertical.center,
      obscureText: false,
      cursorColor: ColorPlanet.primary,
      cursorErrorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.black,
        ),
        hintText: 'Email',
        hintStyle: TextStyle(color: Color(0xff9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Color.fromARGB(101, 241, 241, 241),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
