import 'package:authentication/service/auth.dart';
import 'package:authentication/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text('Interns Log In'),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label:
                      Text('Register', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a valid email' : null,
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
                            ? 'Password should contain a minimum of 6 characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          print('valid');
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.signIn(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Couldnot Sign In';
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red[600],
                      ),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red[50],
                          fontSize: 14,
                        ),
                      )
                    ],
                  )),
            ),
          );
  }
}
