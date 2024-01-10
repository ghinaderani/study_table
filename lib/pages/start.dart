
import 'package:flutter/material.dart';
import 'package:study_table/common/common.dart';
import 'package:study_table/pages/signup.dart';
import 'package:study_table/pages/try.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  User? _user;
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = client.auth.currentUser;
    });
    client.auth.onAuthStateChange.listen((event) {
      setState(() {
        _user = event.session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user == null? tryPage() : SignUpPage(),
    );
  }
}
