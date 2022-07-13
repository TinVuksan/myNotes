
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';




class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Register'),
    ),
    body: Column(
  
             children: [
              TextField(
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                ),
              ),
  
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                ),
              ),
  
               TextButton(
                onPressed: () async {        
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password,
                  );
                  print(userCredential);
                }
                on FirebaseAuthException catch(e) {
                  if(e.code == "weak-password") {
                    print("Weak password!");
                  }
                  else if(e.code == "email-already-in-use") {
                    print("This email is already in use!");
                  }
                  else if(e.code == "invalid-email") {
                    print("Invalid email - check your email input!");
                  }
                }
                
               },
               child: const Text('Register'),
               ),
               TextButton(onPressed: () => {
                Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false)
                },
                child:const Text('Already have an account? Press here to log in!'),
                ),
             ],
    ),
  );

    
  }
}