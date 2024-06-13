import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartassistant/constants/colors.dart';
import 'package:smartassistant/constants/helper.dart';
import 'package:smartassistant/screens/individual_details.dart';
import 'package:smartassistant/services/apis.dart';

class PatienRecords extends StatefulWidget {
  const PatienRecords({super.key, required this.ip});
  final String ip;

  @override
  State<PatienRecords> createState() => _PatienRecordsState();
}

class _PatienRecordsState extends State<PatienRecords> {
  List<dynamic> data = [];
  getPatientData()async{
    final res = await getRequest( "http://${widget.ip}:5000/patientrecords");
    // print(res.body);
    setState(() {
      data = jsonDecode(res.body)["data"];
    });
  }

  @override
  void initState(){
    super.initState();
    getPatientData();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
          const  Row(children: [
              Icon(Icons.book_outlined, size: 36, color: AppColors.secondary,),
              SizedBox(width: 10,),
              Text(Helper.patientRecords, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: AppColors.secondary),)
            ],),
            Image.asset("assets/heart-right.png"),
            Expanded(child: ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) => InkWell(child: Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Container(
                  height: 60,
                  width: w-40,
                  decoration: BoxDecoration(color: AppColors.lightblue, borderRadius: BorderRadius.circular(10)),
                  child: Padding(padding: const EdgeInsets.all(10.0), 
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${data[index]["name"]["first"]} ${data[index]["name"]["last"]}"), Text("${data[index]["gender"].toString()}", style: TextStyle(fontWeight: FontWeight.bold),)],),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> IndividualDetails(data: data[index])));
                    }, icon: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  )
                  ),
                ),
              ),)
              )))
          ],
        ),
      )),
    );
  }
}