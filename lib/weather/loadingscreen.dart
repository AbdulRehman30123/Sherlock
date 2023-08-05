import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:sherlock/uiscreen.dart';
import 'package:sherlock/weather/location.dart';
import 'package:sherlock/weather/networking.dart';

class loadingscreen extends StatefulWidget {
  const loadingscreen({Key? key}) : super(key: key);

  @override
  State<loadingscreen> createState() => _loadingscreenState();
}

@override
class _loadingscreenState extends State<loadingscreen> {
  double? latitude, longitude;
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationdata();
  }

  Future<void> getlocationdata() async {
    Location location = Location();
    await location.getcurrentlocation();
    latitude = location.latitude;
    longitude = location.longitude;
    Networkhelper networkhelper = Networkhelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=59de6cb604c4b8814918999b5949469d&units=metric');
    var weatherdata = await networkhelper.getdata();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return uiscreen(locationweather: weatherdata);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF766FEB),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

//api key= 59de6cb604c4b8814918999b5949469d
