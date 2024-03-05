import 'package:flutter/material.dart';
import 'package:livre/Home.dart';
import 'package:livre/Home1.dart';
import 'package:livre/forgetpass.dart';
import 'package:livre/signup.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
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
                 Text('LIVRÉ',style: TextStyle(fontSize: 50,color: Colors.white),),
                 Text('On Demand Platform',style: TextStyle(color: Colors.white),)

               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(right: 140,top: 40),
             child: Text('Welcome Back',style: TextStyle(fontSize: 30),),
           ),
           Padding(
             padding: const EdgeInsets.only(right: 210),
             child: Text('Sign in to continue'),
           ),
           Padding(
             padding: const EdgeInsets.only(right: 290,top: 40),
             child: Text('Email'),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 35,right: 25),
             child: TextField(
               controller: emailController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 hintText: 'Enter your email',
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(right: 260,top: 20),
             child: Text('Password'),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 35,right: 25),
             child: TextField(
               obscureText: passwordVisible,
               controller: passwordController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 hintText: '********',
                 helperText:"Password must contain special character",
                 helperStyle:TextStyle(color:Colors.deepOrangeAccent),
                 suffixIcon: IconButton(
                   icon: Icon(passwordVisible
                       ? Icons.visibility
                       : Icons.visibility_off),
                   onPressed: () {
                     setState(
                           () {
                         passwordVisible = !passwordVisible;
                       },
                     );
                   },
                 ),
                 alignLabelWithHint: false,
                 filled: true,
               ),
               keyboardType: TextInputType.visiblePassword,
               textInputAction: TextInputAction.done,
             ),
           ),
           InkWell(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const forgetpass()),
               );
             },
          child: Padding(
             padding: const EdgeInsets.only(left: 220,top: 20),
             child: Text('Forgot Password?',style: TextStyle(color: Colors.red),),
           ),
           ),
           InkWell(
             onTap: (){
              /* Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const Home1()),*/
               //);

               login();
             },
           child:Padding(
             padding: const EdgeInsets.only(top: 40),
             child: Container(
               height: 50,
               width: 340,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 color: Colors.red
               ),

               child: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
             ),
           ),
           ),
           InkWell(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const signup()),
               );
             },
             child: Padding(
               padding: const EdgeInsets.only(top: 40),
               child: Text.rich(
                 TextSpan(
                   children: [
                     TextSpan(
                         text: 'Don’t have an account? '

                     ),
                     TextSpan(
                       text: 'Sign up',style: TextStyle(color: Colors.red)
                     )
                   ]
                 )
               ),
             ),
           )
         ],
       ),
       )

      ),
    );
  }



  Future<void> login() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://dev.codemeg.com/livre/api/login_new"),
          body: ({
            'email': emailController.text,
            'password': passwordController.text,
            'longitude': "82.365478",
            'device_token': 'Fcmtoken',
            'device_type': "android",
            'language': 'en'
          }));
      if (response.statusCode == 200) {
        print("Correct");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home1()));
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




  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
