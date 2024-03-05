import 'package:flutter/material.dart';
import 'package:livre/Home1.dart';
import 'package:livre/Login.dart';
import 'package:http/http.dart' as http;
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent
                    ),
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Image.asset('assets/Frame1.png'),
                          ),
                          Text('LIVRÉ', style: TextStyle(
                              fontSize: 50, color: Colors.white),),
                          Text('On Demand Platform',
                            style: TextStyle(color: Colors.white),)
                        ]
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 30, left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an account', style: TextStyle(fontSize: 25),),
                      Text(
                          'Provide specific information to complete the\n registration process.'),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Name'),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your name'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Email'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Phone number'),
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your phone'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Password'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '********'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Re enter password'),
                      ),
                      TextField(
                        controller: repasswordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '********'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 50,
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.red
                          ),
                          child: Center(child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Home1()),
                              // );
                              register();
                            },
                            child: Text('Sign up', style: TextStyle(
                                color: Colors.white),),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40, left: 60),
                          child: Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Already have an account? '

                                    ),
                                    TextSpan(
                                        text: 'Log in',
                                        style: TextStyle(color: Colors.red)
                                    )
                                  ]
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ]
          ),
        )


    );
  }

  Future<void> register() async {
    if (passwordController.text.isNotEmpty && nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://dev.codemeg.com/livre/api/register"),

          body: ({
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'password': passwordController.text,
            'language': 'en'
          }));
      if (response.statusCode == 200) {
        print("Correct");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home1()));
      } else {
        print("Wronggooooooooooooooooooooooooooo");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank field is not allowed")));
    }
  }
}

