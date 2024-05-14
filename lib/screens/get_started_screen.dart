import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/controllers/auth_controller.dart';
import 'package:progmob_magical_destroyers/screens/sign_in_screen.dart';
import 'package:progmob_magical_destroyers/screens/sign_up_screen.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button.dart';
import 'package:progmob_magical_destroyers/widgets/oauth_button.dart';
import 'package:progmob_magical_destroyers/widgets/text_title.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({Key? key}) : super(key: key);

  AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Image(
                      image: AssetImage("assets/logo.png"),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextTitle(title: "Let's Get Started"),
                  SizedBox(height: 10),
                  Text("Let's dive into your account"),
                  SizedBox(height: 50),
                  OauthButton(
                    iconPath: "assets/google_icon.png",
                    text: "Continue with Google",
                    onPressed: () => _authController.signInWithGoogle(),
                  ),
                  SizedBox(height: 15),
                  OauthButton(
                    iconPath: "assets/facebook_icon.png",
                    text: "Continue with Facebook",
                    onPressed: () => _authController.signInWithFacebook(),
                  ),
                  SizedBox(height: 15),
                  OauthButton(
                    iconPath: "assets/github_icon.png",
                    text: "Continue with GitHub",
                    onPressed: () => _authController.signInWithGithub(context),
                  ),
                  SizedBox(height: 50),
                  FullWidthButton(
                    type: FullWidthButtonType.primary,
                    text: "Sign Up",
                    onPressed: () => Get.to(
                      () => SignUpScreen(),
                    ),
                  ),
                  SizedBox(height: 15),
                  FullWidthButton(
                    type: FullWidthButtonType.secondary,
                    text: "Sign In",
                    onPressed: () => Get.to(
                      () => SignInScreen(),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
              Positioned(child: _termsAndPolicy(context), bottom: 20)
            ],
          ),
        ),
      ),
    );
  }

  Row _termsAndPolicy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _pricaxyPolicyContent(),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          ),
          child: Text("Privacy Policy", style: TextStyle(color: Colors.grey)),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _termOfServiceContent(),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          ),
          child: Text("Term of Service", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _termOfServiceContent() {
    return Column(
      children: [
        TextTitle(title: 'Term of Service'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }

  Widget _pricaxyPolicyContent() {
    return Column(
      children: [
        TextTitle(title: 'Privacy Policy'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }
}
