import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:smartassistant/constants/colors.dart';
import 'package:smartassistant/constants/helper.dart';
import 'package:smartassistant/screens/emergency_details.dart';
import 'package:smartassistant/screens/patient_records.dart';
import 'package:smartassistant/services/apis.dart';
import 'package:smartassistant/services/launch_url.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.ip});
  final String ip;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isValidIP(String ipAddress) {
  final ipRegExp = RegExp(
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  return ipRegExp.hasMatch(ipAddress);
}

    Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  String wifiNamee = "";
  String wifiip = "";
  Future<String> getwifiName() async {
    final NetworkInfo info = NetworkInfo();
    var wifiName = await info.getWifiName();
    // var ip = await info.getWifiIP();
    var ip = await info.getWifiGatewayIP();
    log("ip is " + ip.toString());
    log(wifiName.toString());
    setState(() {
      wifiNamee = wifiName??"";
      wifiip = isValidIP(widget.ip)?widget.ip:"192.168.29.236";
    });
    return wifiName ?? "ERROR";
  }

  @override
  void initState() {
    getwifiName();
    super.initState();
  }

  bool statusOk = false;
  String pingstatus = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: 
      SafeArea(
        child: StreamBuilder<ConnectivityResult>(
          stream: connectivityStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == ConnectivityResult.wifi) {
             return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Helper.shra,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary),
              ),
              Text(
                "${Helper.connectedTo}\n$wifiNamee\n$wifiip",
                style:const  TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
              Column(
                children: [
                  MaterialButton(
                    height: 50,
                    minWidth: w,
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final response = await getRequest("http://$wifiip:5000/ping").timeout(Duration(seconds: 5));
                      if(response.statusCode==200){
                        setState(() {
                          statusOk = true;
                          pingstatus = "The server is up and running!";
                          isLoading=false;
                        });
                      }
                      else{
                        setState(() {
                          statusOk = false;
                          pingstatus = "Connect to wrong WiFi/Server down";
                          isLoading=false;
                        });
                      }
                      } catch (e) {
                        setState(() {
                          statusOk = false;
                          pingstatus = "Connect to wrong WiFi/Server down";
                          isLoading=false;
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.secondary,
                    child: isLoading? const CircularProgressIndicator(color: AppColors.primary,)
                    :
                    const Text(
                      Helper.ping,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    )
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(Helper.pingToCheck),
                  Text(pingstatus, style: TextStyle(color: statusOk?Colors.green:Colors.red, fontWeight: FontWeight.bold),)
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>  PatienRecords(ip: wifiip))));
                },
                child: Container(
                  width: w,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.book_outlined,
                            color: AppColors.primary,
                            size: 56,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            Helper.patientRecords,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>  EmergencyDetails(ip: wifiip,))));
                },
                child: Container(
                  width: w,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.darkblue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.primary,
                            size: 56,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            Helper.emergencyCalls,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await launchWebUrl("https://github.com/aakzsh/smart-assistant");
                },
                child: const Center(
                  child: Text(
                    Helper.aboutApp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        );
            } else {
              // Display loading indicator or other appropriate UI
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please connect to the WiFi Network\nbefore proceeding",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                  ),
                ],
              );
            }
          },
        ),
      )
      
    );
  }
}
