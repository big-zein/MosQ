import 'package:flutter/material.dart';
import 'package:mosq/libraries/validator.dart';
import 'package:mosq/models/user.dart';
import 'package:mosq/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        title: Text('Sign In to MosQ'),
        actions: [
          IconButton(
            onPressed: () => widget.toggleView(),
            icon: Icon(Icons.how_to_reg),
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
                      ..email())
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
                      ..required())
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
                        var result = await _auth.signInWithEmailAndPassword(
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
                        ? Text('Sign In')
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
