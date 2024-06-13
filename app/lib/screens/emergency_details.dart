import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartassistant/constants/colors.dart';
import 'package:smartassistant/constants/helper.dart';
import 'package:smartassistant/services/apis.dart';

class EmergencyDetails extends StatefulWidget {
  const EmergencyDetails({super.key, required this.ip});
  final String ip;
  @override
  State<EmergencyDetails> createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {
    List<dynamic> data = [];
  getEmergencyCalls()async{
    final res = await getRequest( "http://${widget.ip}:5000/emergencycalls");
    // print(res.body);
    setState(() {
      data = jsonDecode(res.body)["sos"];
    });
  }

  @override
  void initState(){
    super.initState();
    getEmergencyCalls();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  size: 36,
                  color: AppColors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Helper.emergencyCalls,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.red),
                )
              ],
            ),
            Image.asset("assets/heart-right.png"),
            Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) => InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 90,
                              width: w - 40,
                              decoration: BoxDecoration(
                                  color: AppColors.lightred,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding:  EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index]["patientName"]),
                                          Text(
                                            "Timestamp: ${data[index]["timestamp"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Ward Number: ${data[index]["wardnum"]}"),
                                        ],
                                      ),

                                      IconButton(onPressed: ()async{
                                        await getRequest("http://"+ widget.ip+ ":5000/deletealert/"+data[index]["id"]);
                                        getEmergencyCalls();
                                      }, icon: const Icon(Icons.delete_outline, color: Colors.redAccent,))
                                      
                                    ],
                                  )),
                            ),
                          ),
                        )))),
            const SizedBox(
              height: 10,
            ),
            // MaterialButton(
            //   height: 50,
            //   minWidth: w,
            //   onPressed: () {},
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10)),
            //   color: AppColors.secondary,
            //   child: const Text(
            //     Helper.clearAll,
            //     style: TextStyle(
            //         color: AppColors.primary,
            //         fontStyle: FontStyle.italic,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18.0),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}
