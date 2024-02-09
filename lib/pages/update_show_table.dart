// import 'package:classrooms_study/pages/update_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_table/common/common.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowUpdateTable extends StatefulWidget {
  const ShowUpdateTable({super.key});

  @override
  State<ShowUpdateTable> createState() => _ShowUpdateTableState();
}

class _ShowUpdateTableState extends State<ShowUpdateTable> {
  bool _isLoading = false;

  final _tablesStream =
      Supabase.instance.client.from("tables").stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff032030),
      // appBar: AppBar(
      //   title: Text("Status of tables"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 350,
                color: Colors.transparent,
                // color:Color(0xffFEEEAB) ,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/persone.png",
                  ),
                ),
              ),
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
                stream: _tablesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final tables = snapshot.data!;
                  return SizedBox(
                    height: 1000,
                    width: double.infinity,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                        itemCount: tables.length,
                        itemBuilder: (context, index) {
                          int people = tables[index]['table_capacity'];
                          int counter =
                              tables[index]['number_of_people_at_this_table'];
                          bool available = tables[index]['available'];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Column(
                                children: [
                                  Container(
                                    width: 310,
                                    height: 350,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF8853E),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: Offset(4, 4)),
                                          BoxShadow(
                                              color: Color(0xffF8853E),
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: Offset(-4, -4)),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.table_bar_outlined,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                              ),
                                              Text(
                                                "Table Number :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                tables[index]["id"].toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.place,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                              ),
                                              Text(
                                                "Category :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                tables[index]['category'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.chair_alt,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                  ),
                                                  Text(
                                                    "table Capacity :",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (people > 0)
                                                            tables[index][
                                                                    'table_capacity'] =
                                                                people - 1;
                                                        });
                                                      },
                                                      icon: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white),
                                                        child: Center(
                                                          child: Icon(
                                                              Icons.minimize),
                                                        ),
                                                      )),
                                                  Text(
                                                    people.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tables[index][
                                                                  'table_capacity'] =
                                                              people + 1;
                                                        });
                                                      },
                                                      icon: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                          child: Center(
                                                            child:
                                                                Icon(Icons.add),
                                                          ))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                  ),
                                                  Text(
                                                    "Number of people at ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "this table : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (counter > 0)
                                                            tables[index][
                                                                    'number_of_people_at_this_table'] =
                                                                counter - 1;
                                                        });
                                                      },
                                                      icon: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                          child: Center(
                                                            child: Icon(
                                                                Icons.minimize),
                                                          ))),
                                                  Text(
                                                    counter.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        tables[index][
                                                                'number_of_people_at_this_table'] =
                                                            counter + 1;
                                                      });
                                                    },
                                                    icon: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white),
                                                        child: Center(
                                                          child:
                                                              Icon(Icons.add),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Icon(
                                                Icons.event_available,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                            ),
                                            Text(
                                              "Is available :",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              tables[index]['available']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Switch(
                                                  // focusColor: Color(0xff022842),
                                                  activeColor: Colors.white,
                                                  // focusColor: Colors.amber,
                                                  inactiveThumbColor:
                                                      Colors.grey,
                                                  hoverColor: Colors.white,
                                                  value: available,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tables[index]
                                                          ['available'] = value;
                                                    });
                                                  }),
                                            )
                                          ],
                                        ),
                                        _isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        _isLoading = true;
                                                      });
                                                      try {
                                                        await client
                                                            .from('tables')
                                                            .update({
                                                          "available": true,
                                                          "table_capacity":
                                                              int.parse(people
                                                                  .toString()),
                                                          "number_of_people_at_this_table":
                                                              int.parse(counter
                                                                  .toString()),
                                                        }).match({
                                                          "id": tables[index]
                                                              ['id'],
                                                        });

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content:
                                                              Text('Success'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ));
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ShowUpdateTable()));
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'Your table has not added'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ));
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.white,
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          tileMode:
                                                              TileMode.clamp,
                                                          colors: [
                                                            Color(0xff004D74),
                                                            Color(0xff003554),
                                                          ],
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Save',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
