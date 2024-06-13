import 'package:flutter/material.dart';
import 'package:smartassistant/constants/colors.dart';
import 'package:smartassistant/constants/helper.dart';
import 'package:smartassistant/screens/home.dart';
class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Helper.shra,
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary),
                ),
                Text(
                  Helper.shraFull,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Image.asset(
            "assets/heart-center.png",
            width: w,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Text(
                    Helper.degreeFulfill,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    Helper.btechEce,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(width: w,
                  child: TextField(decoration: InputDecoration(hintText: "Enter Server IP"),
                  controller: controller,
                  ),
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: w,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(ip: controller.text)));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.secondary,
                    child: const Text(
                      Helper.getStarted,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "\n${Helper.developedBy}\n1: ${Helper.jatin}\n2: ${Helper.aakash}\n",
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                  Image.asset(
                    "assets/ipu.png",
                    scale: 4,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
