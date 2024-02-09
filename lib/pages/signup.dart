import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_table/common/common.dart';
import 'package:study_table/pages/add_table.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPressed = true;
  bool _signUpLoading = false;
  bool _signInLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            child: Drawer(
              backgroundColor: Color(0xff032030),
              child: ListTile(
                leading: IconButton(
                    onPressed: () async {
                      await client.auth.signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
                title: Text(
                  "Log out",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff032030),
      ),
      backgroundColor: Color(0xff032030),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xffF8853E),
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xffF8853E),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xffF8853E),
                              ),
                              label: Text(
                                "email",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              )),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: 200,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (_passwordController.text.length < 8) {
                            return 'Enter more than 8 later';
                          } else {
                            return null;
                          }
                        },
                        obscureText: isPressed,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color(0xffF8853E),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_rounded,
                            color: Color(0xffF8853E),
                          ),
                          label: Text(
                            "password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                            },
                            icon: isPressed == true
                                ? const Icon(
                                    Icons.visibility,
                                    color: Color(0xffF8853E),
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _signInLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: InkWell(
                              onTap: () async {
                                final isValid =
                                    _formkey.currentState?.validate();
                                if (isValid != true) {
                                  return;
                                }
                                setState(() {
                                  _signInLoading = true;
                                });
                                try {
                                  await client.auth.signInWithPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Success'),
                                    backgroundColor: Colors.green,
                                  ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTable()));
                                  context.go('/addtable');
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Log In faild'),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    _signInLoading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xffE76f51),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    tileMode: TileMode.clamp,
                                    colors: [
                                      Color(0xffE76f51),
                                      Color(0xffF8853E),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                  _signUpLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: InkWell(
                              onTap: () async {
                                final isValid =
                                    _formkey.currentState?.validate();
                                if (isValid != true) {
                                  return;
                                }
                                setState(() {
                                  _signUpLoading = true;
                                });
                                try {
                                  await client.auth.signUp(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Success , Confirm your account'),
                                    backgroundColor: Colors.green,
                                  ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTable()));
                                  context.go('/addtable');
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('sign up faild'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xffE76f51),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    tileMode: TileMode.clamp,
                                    colors: [
                                      Color(0xffE76f51),
                                      Color(0xffF8853E),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sign UP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                ],
              )),
        ),
      ),
      // appBar: AppBar(
      //   title: Text('SignUp'),
      // ),
      // body: ListView(
      //   children: [
      //     Padding(padding: EdgeInsets.all(12)),
      //     TextFormField(
      //       controller: _usernameController,
      //       decoration: InputDecoration(label: Text('Username')),
      //     ),
      //     SizedBox(
      //       height: 12,
      //     ),
      //     TextFormField(
      //       controller: _emailController,
      //       decoration: InputDecoration(label: Text('Email')),
      //     ),
      //     ElevatedButton(onPressed: () async {
      //       final username = _usernameController.text.trim();
      //       final email = _emailController.text.trim();
      //       final userId = supabase.auth.currentUser!.id;

      //       await supabase.from('users').update({
      //         'username': username,
      //         'email': email,
      //       }).eq('id', userId);
      //     }, child: Text('Save'))
      //   ],
      // ),
    );
  }
}
