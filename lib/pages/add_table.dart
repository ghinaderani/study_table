import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_table/pages/show_table.dart';
import 'package:study_table/pages/update_show_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTable extends StatefulWidget {
  const AddTable({super.key});

  @override
  State<AddTable> createState() => _AddTableState();
}

bool dropDownValue = false;

class _AddTableState extends State<AddTable> {
  bool _isLoading = false;
  final _idController = TextEditingController();
  final _categoryController = TextEditingController();
  final _availableController = TextEditingController();
  final _tableCapacityController = TextEditingController();
  final _numberOfPeopleAtThisTableController = TextEditingController();
  final _addkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xff032030),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
                key: _addkey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Text(
                        "Add Table",
                        style: TextStyle(
                            color: Color(0xffF8853E),
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 500,
                        child: TextFormField(
                          controller: _idController,
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
                            label: Text(
                              "Table Number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 500,
                        child: TextFormField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color(0xffF8853E),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            label: Text(
                              "category",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 500,
                        child: DropdownButton(
                          underline: Container(),
                          borderRadius: BorderRadius.circular(30),
                          dropdownColor: Color(0xff004D74),
                          isExpanded: true,
                          autofocus: true,
                          value: dropDownValue,
                          items: const [
                            DropdownMenuItem<bool>(
                              value: false,
                              child: Text("False"),
                            ),
                            DropdownMenuItem<bool>(
                              value: true,
                              child: Text("True"),
                            ),
                            // DropdownMenuItem<String>(
                            //   value: "KIA",
                            //   child: Text("KIA"),
                            // ),
                          ],
                          onChanged: (value) {
                            setState(
                              () {
                                dropDownValue = value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _tableCapacityController,
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
                            label: Text(
                              "Table capacity",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _numberOfPeopleAtThisTableController,
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
                            label: Text(
                              "number of people at this table",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    //async {
                                    // await Supabase.instance.client.from("roomss").insert({"body": value});
                                    // },
                                    await Supabase.instance.client
                                        .from('tables')
                                        .insert({
                                      "id": int.parse(
                                        _idController.text,
                                      ),
                                      "category": _categoryController.text,
                                      "available": dropDownValue,
                                      "table_capacity": int.parse(
                                        _tableCapacityController.text,
                                      ),
                                      "number_of_people_at_this_table": int.parse(
                                          _numberOfPeopleAtThisTableController
                                              .text),
                                    });
        
                                    //  client.auth.signUp(
                                    //     email: _emailController.text,
                                    //     password: _passwordController.text);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Success'),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowUpdateTable()));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Your table has not added'),
                                      backgroundColor: Colors.red,
                                    ));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 333,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xffF8853E),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xffF8853E),
                                        Color(0xffF8853E),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add',
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
        ));
  }
}
