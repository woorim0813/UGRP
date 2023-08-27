import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class initialmap extends StatefulWidget {
  const initialmap({Key? key}) : super(key: key);

  @override
  State<initialmap> createState() => initialmapstate();
}

class initialmapstate extends State<initialmap> with TickerProviderStateMixin {
  late GoogleMapController _controller;
  late AnimationController bottomcontroller;
  late Position position;
  late LatLng initiallocation = LatLng(36.012151, 129.323573);

  Future<void> waitforposition() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    initiallocation = await LatLng(position.latitude, position.longitude);
    print(initiallocation);
    setState(() {});
  }

  final _markers = <Marker>{};

  List delivery = [
    {"name": '지곡회관', "latitude": 36.015771, "longitude": 129.322423,},
    {"name": '체인지업 그라운드', "latitude": 36.012151, "longitude": 129.323573,},
  ];

  @override
  void initState() {
    waitforposition().then((value){});
    
    _markers.addAll(
      delivery.map(
        (e) => Marker(
          markerId: MarkerId(e["name"] as String),
          infoWindow: InfoWindow(title: e["name"] as String, snippet: '으악!'),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
          onTap:() {
            _controller.animateCamera(CameraUpdate.newLatLng(LatLng(e['latitude'] as double, e['longitude'] as double)));
            showModalBottomSheet(
              context: context,
              transitionAnimationController: bottomcontroller,
              builder: (BuildContext context) {
                return Container(
                  height: 250, // 모달 높이 크기
                  decoration: const BoxDecoration(
                    color: Colors.white, // 모달 배경색
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0), // 모달 좌상단 라운딩 처리
                      topRight: Radius.circular(0), // 모달 우상단 라운딩 처리
                    ),
                  ),
                  child: Text(e["name"].toString()), // 모달 내부 디자인 영역
                );
              },
            );
          },
        ),
      )
    );
    bottomcontroller = BottomSheet.createAnimationController(this);
    bottomcontroller.duration = Duration(milliseconds: 1700);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('지도로 보기'),
        ),

      body: Column(
        children: [
          initiallocation == LatLng(36.012151, 129.323573) 
          ? Expanded(
              child: Center(
                child: Text('로딩 중이다 인간!',
                  style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  ),
                ),
              ),
            )
          : Expanded(
            child: GoogleMap(
                initialCameraPosition: CameraPosition(target: initiallocation, zoom:17),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                markers: _markers,
                onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                  }
                );
              },
            ),
          ),
        ],
      )
      );
    }
}