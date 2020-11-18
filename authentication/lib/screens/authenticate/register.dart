import 'package:authentication/service/auth.dart';
import 'package:authentication/shared/loading.dart';
import 'package:flutter/material.dart';
// import 'package:my_company/services/auth.dart';
// import 'package:my_company/shared/constants.dart';
// import 'package:my_company/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '', password = '', error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red[100],
            appBar: AppBar(
              backgroundColor: Colors.red[600],
              title: Text('Register as an Intern'),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Email ID'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a valid email ID' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Password must contain minimum 6 characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 23),
                      RaisedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.register(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Invalid email or password.';
                              });
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red[600],
                      ),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )),
            ),
          );
  }
}
