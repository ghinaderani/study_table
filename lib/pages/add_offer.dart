import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:study_table/notification/notification_service.dart';
import 'package:study_table/pages/update_show_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({super.key});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

bool dropDownValue = false;

class _AddOfferState extends State<AddOffer> {
  bool _isLoading = false;
  final _offerNameController = TextEditingController();
  final _priceController = TextEditingController();
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
                        "Add Offer",
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
                          controller: _offerNameController,
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
                              "Offer Name",
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
                      width: 530,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _priceController,
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
                              "price",
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
                                        .from('offer_and_prices')
                                        .insert({
                                      "offer_name": _offerNameController.text,
                                      "price": int.parse(
                                        _priceController.text,
                                      ),
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Success'),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowUpdateTable()));
                                    // NotificationService().simpleNotificationShow();
                                    NotificationService.showNotification(
                                        title: "Title of the notification",
                                        body: "Body of the notification",
                                        summary: "Small Summary",
                                        notificationLayout:
                                            NotificationLayout.Inbox);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Your offer has not added'),
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
                                        Color(0xffE76f51),
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

//Cw)BMHKh([Oo781P
//>$c&)QAjkJ:?S61&