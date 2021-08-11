import 'package:flutter/material.dart';
import 'package:mosq/libraries/validator.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Register to MosQ'),
        actions: [
          IconButton(
            onPressed: () => widget.toggleView(),
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: User.attributeName('email'),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (Validator(
                        attributeName: User.attributeName('email'),
                        value: value)
                      ..required()
                      ..email()
                      ..maxLength(32))
                    .getError(),
                onFieldSubmitted: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                controller: passwordC,
                obscureText: !showPassword,
                decoration: InputDecoration(
                    labelText: User.attributeName('password'),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => (Validator(
                        attributeName: User.attributeName('password'),
                        value: value)
                      ..required()
                      ..minLength(8)
                      ..maxLength(32))
                    .getError(),
                onFieldSubmitted: (value) => _formKey.currentState!.validate(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (!isLoading && _formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        var result = await _auth.registerWithEmailAndPassword(
                            emailC.text, passwordC.text);

                        if (result is User) {
                          //done
                        } else if (result is String) {
                          final snackBar = SnackBar(
                            content: Text(result),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() => isLoading = false);
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Try again later.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() => isLoading = false);
                        }
                      }
                    },
                    child: !isLoading
                        ? Text('Register')
                        : SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
