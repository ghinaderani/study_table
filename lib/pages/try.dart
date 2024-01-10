
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class tryPage extends StatefulWidget {
  const tryPage({super.key});

  @override
  State<tryPage> createState() => _tryPageState();
}

class _tryPageState extends State<tryPage> {
  bool _isLoading = false;
  // TextEditingController categoryController = TextEditingController();
  // TextEditingController open_timeController = TextEditingController();
  final _notesStream =
      Supabase.instance.client.from("notes").stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Column(
        children: [
          StreamBuilder<List<Map<String, dynamic>>>(
              stream: _notesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final notes = snapshot.data!;
                return SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
          
                        return ListTile(
                          title: Text(notes[index]['body']),
                          // subtitle: Text(notes[index]['open_time']),
                          subtitle: IconButton(onPressed: ()async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    //async {
                                    // await Supabase.instance.client.from("roomss").insert({"body": value});
                                    // },
                                    await Supabase.instance.client
                                       
  .from('notes')
  .delete()
  .match({ 'id': notes[index]['id'] });

                                    //  client.auth.signUp(
                                    //     email: _emailController.text,
                                    //     password: _passwordController.text);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Success'),
                                      backgroundColor: Colors.green,
                                    ));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ShowTable()));
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
                                }, icon: Icon(Icons.delete)),
                        );
                      }),
                );
              }),
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return SimpleDialog(
                title: Text("Add table"),
                contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                children: [
                  TextFormField(
                    onFieldSubmitted: (value) async {
                      await Supabase.instance.client.from("notes").insert({"body": value});
                    },
                  ),
                ],
              );
            }));
      },
      child: Icon(Icons.add),),
    );
  }
}