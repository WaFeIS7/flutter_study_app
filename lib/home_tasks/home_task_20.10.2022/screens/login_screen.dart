import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/welcome_screen.dart';

import '../user.dart';

const _emailField = 'Email';
const _passwordField = 'Password';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var isChecked = false;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.network(
                  // 'https://cdn2.iconfinder.com/data/icons/users-6/100/USER2-64.png'),
              Image.asset('assets/images/login_icon.png'),
              const SizedBox(height: 20),
              const Text('Давай, заходь!',
                  style: TextStyle(fontSize: 16)),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: _formWidget(nameController, _emailField, User.name),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                child:
                    _formWidget(passwordController, _passwordField, User.password),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(25, 0, 40, 20),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.greenAccent,
                        value: isChecked,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red.shade400),
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
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
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
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
