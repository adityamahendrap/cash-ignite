import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/controller/auth_controller.dart';
import 'package:progmob_magical_destroyers/screens/sign_in_screen.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button_bottom_bar.dart';
import 'package:progmob_magical_destroyers/widgets/horizontal_divider.dart';
import 'package:progmob_magical_destroyers/widgets/icon_button_circ;e.dart';
import 'package:progmob_magical_destroyers/widgets/input/password_input.dart';
import 'package:progmob_magical_destroyers/widgets/input/text_input.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isAgree = false;

  AuthController _authController = AuthController();

  bool _validateInput() {
    return _checkEmail(_emailController.text) == null &&
        _checkPassword(_passwordController.text) == null &&
        _checkConfirmPassword(_confirmPasswordController.text) == null &&
        _checkName(_nameController.text) == null &&
        _isAgree;
  }

  void _clearInput() {
    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _isAgree = false;
    });
  }

  void _signUp() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed",
          "Please fill the form correctly and agree terms & conditions");
      return;
    }
    await _authController.signUp(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void _toggleAgree() {
    setState(() {
      _isAgree = !_isAgree;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    });
  }

  String? _checkName(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field must be filled';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
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

  String? _checkConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value != _passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  String? _checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(title: "Join APP_NAME Today!✨"),
                SizedBox(height: 10),
                Text(
                    "Create an account to lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                SizedBox(height: 25),
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        title: 'Name',
                        hintText: 'Name',
                        prefixIcon: Icons.person_outline,
                        controller: _nameController,
                        validator: _checkName,
                      ),
                      SizedBox(height: 20),
                      TextInput(
                        title: 'Email',
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        validator: _checkEmail,
                      ),
                      SizedBox(height: 20),
                      PasswordInput(
                        title: 'Password',
                        hintText: 'Password',
                        isObscure: _isPasswordHidden,
                        toggleObscure: _togglePasswordVisibility,
                        controller: _passwordController,
                        validator: _checkPassword,
                      ),
                      SizedBox(height: 20),
                      PasswordInput(
                        title: 'Confirm Password',
                        hintText: 'Confirm Password',
                        isObscure: _isConfirmPasswordHidden,
                        toggleObscure: _toggleConfirmPasswordVisibility,
                        controller: _confirmPasswordController,
                        validator: _checkConfirmPassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _agreement(context),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Get.off(() => SignIn()),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: ColorPlanet.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                HorizontalDivider(text: "or continue with"),
                SizedBox(height: 25),
                _oauthButtons(),
                _paddingBottomWithViewInsets()
              ],
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: "Sign Up",
            onPressed: () {
              _signUp();
            },
          ),
        ],
      ),
    );
  }

  SizedBox _paddingBottomWithViewInsets() {
    return MediaQuery.of(context).viewInsets.bottom == 0
        ? SizedBox(height: 100)
        : SizedBox(height: MediaQuery.of(context).viewInsets.bottom);
  }

  Row _oauthButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonCircle(
          icon: Image.asset('assets/google_icon.png'),
          onPressed: () => _authController.signInWithGoogle(),
        ),
        SizedBox(width: 20),
        IconButtonCircle(
          icon: Image.asset('assets/facebook_icon.png'),
          onPressed: () => _authController.signInWithFacebook(),
        ),
        SizedBox(width: 20),
        IconButtonCircle(
          icon: Image.asset('assets/github_icon.png'),
          onPressed: () => _authController.signInWithGithub(),
        ),
      ],
    );
  }

  Row _agreement(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _isAgree,
            onChanged: (value) => _toggleAgree(),
            activeColor: ColorPlanet.primary,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => _toggleAgree(),
          child: Text("I agree to APP_NAME "),
        ),
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _termsAndConditionsContent(),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            "Terms & Conditions.",
            style: TextStyle(
              color: ColorPlanet.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _termsAndConditionsContent() {
    return Column(
      children: [
        TextTitle(title: 'Terms & Conditions'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }
}
