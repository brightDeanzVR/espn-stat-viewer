import 'package:betviewapp/colors.dart';
import 'package:betviewapp/strings.dart';
import 'package:betviewapp/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String nonce = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: buildLogin()),
    );
  }

  Widget buildLogin() {
    return Form(
      key: _formKey,
      child: Container(
        height: 200.0,
        width: 300.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: greyShadow,
                spreadRadius: 2.0,
                blurRadius: 7,
                offset: Offset(3, 3)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  hideText: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 8.0),
                    child: Icon(Icons.key_rounded),
                  ),
                  label: const Text(nonceLabel),
                  onSaved: (String? value) {
                    nonce = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.save();

                      if (nonce == dotenv.env['NONCE']) {
                        print('correct!');
                      }
                    },
                    child: const Text(
                      'Enter',
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
