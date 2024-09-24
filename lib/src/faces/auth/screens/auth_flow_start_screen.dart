import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lyricfy/constants/errors.dart';
import 'package:lyricfy/generated/l10n.dart';
import 'package:lyricfy/src/faces/auth/screens/new_user_screen.dart';
import 'package:lyricfy/src/faces/auth/widgets/poster_text_widget.dart';
import 'package:lyricfy/src/faces/public/buttons/custom_on_press_button.dart';
import 'package:lyricfy/src/faces/public/popups/fail_type_popup.dart';
import 'package:lyricfy/src/faces/public/popups/ok_type_popup.dart';
import 'package:lyricfy/src/faces/styles/public/design_consts.dart';
import 'package:lyricfy/src/internal/auth/supa_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as dev;

class LoginScreen extends StatelessWidget {
  @override
  const LoginScreen({super.key});
  void _handleLoginStates(context) async {
    SupabaseClient sc = GetIt.I<SupabaseClient>();
    final a = SupaAuth(sc);
    var mux = await a.signInOrSignUpWithSpotify();
    switch (mux) {
      case CustomErrors.AUTH_COULDNT_CONNECT_AUTH_PROVIDER:
        {
          failPopBuilder(context, "SOMETHING WENT WRONG",
              "Unfortunatly we couldn't connect to the auth provider");
          break;
        }
      case CustomErrors.AUTH_NO_USER_AFTER_OAuth:
        {
          failPopBuilder(context, "SOMETHING WENT WRONG",
              "Unfortunatly we couldn't connect to the auth provider");
          break;
        }
      case CustomErrors.NO_ERR:
        {
          var ie = await a.isUserAlsoExistsInDB();
          if (ie == CustomErrors.DB_MUX_USER_EXISTS) {
            okPopBuilder(context, "ok", "ok");
          } else if (ie == CustomErrors.DB_MUX_USER_DOES_NOT_EXIST) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewUserScreen()));
          } else {
            dev.log("STH_SRSLY_WRONG err:atfssx41");
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginButtonWidget = CustomOnPressButton(
        onPressed: () => _handleLoginStates(context),
        text: S.of(context).loginButton);
    List<String> posterText = [
      "merhaba",
      "hello",
      "hola",
      "bonjour",
      "ciao",
      "こんにちは",
      "안녕하세요",
      "你好",
      "olá",
      "Привет",
      "مرحبا",
      "chào bạn",
      "สวัสดี",
      "halo",
      "saluton",
      "hej",
      "hallo",
      "hoi",
      "hei"
    ];
    final posterTextWidget = PosterTextWidget(posterText: posterText);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [posterTextWidget],
              ),
            ),
            Positioned(
              bottom: DesignConsts.buttomButtonPosition,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [loginButtonWidget],
              ),
            ),
          ],
        ),
      ),
    );
  }
}