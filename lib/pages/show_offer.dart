// import 'package:classrooms_study/pages/update_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_table/common/common.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowOffer extends StatefulWidget {
  const ShowOffer({super.key});

  @override
  State<ShowOffer> createState() => _ShowOfferState();
}

class _ShowOfferState extends State<ShowOffer> {
  final _priceController = TextEditingController();
  bool _isLoading = false;

  final _offer_and_pricesStream = Supabase.instance.client
      .from("offer_and_prices")
      .stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff032030),
        // appBar: AppBar(
        //   title: Text("Status of offer_and_prices"),
        // ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              height: 300,
              width: 500,
              color: Colors.transparent,
              // color:Color(0xffFEEEAB) ,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/offer.png",
                ),
              ),
            ),
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
              stream: _offer_and_pricesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final offer_and_prices = snapshot.data!;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 672.5,
                  height: MediaQuery.of(context).size.height * 672.5,
                  // height: 500,
                  // width: double.infinity,
                  child: ListView.builder(
                      itemCount: offer_and_prices.length,
                      itemBuilder: (context, index) {
                        int counter = offer_and_prices[index]['price'];
                        return ListTile(
                            leading: Icon(
                              Icons.local_offer,
                              size: 30,
                              color: Colors.white,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "Offer Name :",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offer_and_prices[index]["offer_name"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "Price :",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (counter > 0)
                                          offer_and_prices[index]['price'] =
                                              counter - 1;
                                      });
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(Icons.minimize),
                                      ),
                                    )),
                                // Container(height: 50,
                                // width: 50,
                                //   child: TextField(controller: _priceController,
                                //   onChanged: (counter){
                                //     setState(() {
                                //       counter = counter;
                                //     });
                                //   },),
                                // ),
                                Text(
                                  counter.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        offer_and_prices[index]['price'] =
                                            counter + 1;
                                      });
                                    },
                                    icon: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Center(
                                          child: Icon(Icons.add),
                                        ))),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await Supabase.instance.client
                                      .from('offer_and_prices')
                                      .delete()
                                      .match({
                                    'id': offer_and_prices[index]['id']
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Offer has deleted'),
                                    backgroundColor: Colors.green,
                                  ));
                                  setState(() {});
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Your offer has not deleted'),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.red,
                              ),
                            ));
                      }),
                );
              })
        ])));
  }
}
