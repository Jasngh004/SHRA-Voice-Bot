import 'package:flutter/material.dart';
import 'package:smartassistant/constants/colors.dart';

class IndividualDetails extends StatefulWidget {
  const IndividualDetails({super.key, required this.data});
  final dynamic data;

  @override
  State<IndividualDetails> createState() => _IndividualDetailsState();
}

class _IndividualDetailsState extends State<IndividualDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.account_circle_outlined, size: 36, color: AppColors.secondary,),
              SizedBox(width: 10,),
              Text("${widget.data["name"]["first"]} ${widget.data["name"]["last"]}" , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: AppColors.secondary),)
            ],),
            Image.asset("assets/heart-right.png"),
            ...generateData(widget.data)
          ],
        ),
      )),
    );
  }
}

List<Widget> generateData(data){
  List<Widget> widgets = [];
  data.keys.forEach((key) {
    widgets.add(Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Text("$key : ${data[key].toString()}"),
    ));
  });
  return widgets;
}