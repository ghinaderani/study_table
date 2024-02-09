import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_table/common/common.dart';
import 'package:study_table/pages/add_table.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Orientation currentOrentation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraits) {
        if (constraits.maxWidth < 720) {
          return Form(
            key: _formkey,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/splash.jpg")),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 67),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                          height: 187,
                          width: 173,
                          child: Image.asset("assets/windos.jpg")),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Container(
                        height: 178,
                        width: 48.78,
                        child: Image.asset("assets/longlamp.jpg")),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                    child: Container(
                        height: 124,
                        width: 33.98,
                        child: Image.asset("assets/longlamp.jpg")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 161),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 85),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 282),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 64,
                            width: 272,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 212, 209),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  hintText: "email",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 64,
                          width: 272,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 157, 212, 209),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (_passwordController.text.length < 8) {
                                return 'Enter more than 8 later';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                hintText: "password",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                    _signUpLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
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
                                      content: Text(
                                          'Success , Confirm your account'),
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
                                  height: 64,
                                  width: 272,
                                  decoration: BoxDecoration(
                                      color: Color(0xff5AB8B3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 300,
                          child: Center(
                            child: Row(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "already have an account?",
                                      style: TextStyle(
                                          color: Color(0xff69B0B4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Color(0xffDD6A39),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                          width: 152.11,
                          height: 95.59,
                          child: Image.asset("assets/book.jpg")),
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                          width: 127.09,
                          height: 191.91,
                          child: Image.asset("assets/tree.png")),
                    )),
              ],
            ),
          );
        } else if (constraits.maxWidth >= 720 && constraits.maxWidth < 1024) {
          return Center(
            child: Text("Tablet"),
          );
        } else {
          return const Center(
            child: Text("Desktop"),
          );
        }
      }),
    );
  }
}
