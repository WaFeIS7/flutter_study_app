import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/constants.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user.dart';

const _emailField = 'Email';
const _passwordField = 'Password';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isChecked = false;
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/login_icon.png'),
              const SizedBox(height: 20),
              const Text('Давай, заходь!', style: TextStyle(fontSize: 16)),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: _formWidget(_nameController, _emailField, User.name),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: _formWidget(
                    _passwordController, _passwordField, User.password),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(25, 0, 40, 20),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.greenAccent,
                        value: _isChecked,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red.shade400),
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      const Text('Запамʼятати', style: TextStyle(fontSize: 16)),
                    ],
                  )),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Далі'),
                  onPressed: () {
                    if (_formGlobalKey.currentState!.validate()) {
                       if (_isChecked) {
                        _setLocalStorage(_isChecked);
                      }
                      _formGlobalKey.currentState!.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const WelcomeScreen())));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}

void _setLocalStorage(bool remember) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setBool(Constants.rememberMe, remember);
  });
}

Widget _formWidget(TextEditingController textEditingController,
    String fieldName, String userCredials) {
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: fieldName,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return '$fieldName is Empty. Enter $fieldName';
      } else if ((value != userCredials)) {
        return "$fieldName is incorrect";
      }
      return null;
    },
  );
}
