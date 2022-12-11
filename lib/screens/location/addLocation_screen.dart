import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ninan1/components/app_repo/location_state.dart';

import 'package:ninan1/components/buttons//custom_button.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/screens/home/home_screen.dart';

import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/utils/app_colors.dart';

class AddLocationScreen extends StatefulWidget {

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {



  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = Set();
  LocationState _locationState;
  Marker _marker;
  double _height = 0, _width = 0;
  BitmapDescriptor pinLocationIcon;


  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/pin.png')
        .then((value) => pinLocationIcon = value);
  }

  @override
  Widget build(BuildContext context) {


    _locationState = Provider.of<LocationState>(context);


    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    _marker = Marker(

      // optimized: false,
        zIndex: 5,
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        icon: pinLocationIcon,
        onDragEnd: ((value) async {
          print('ismail');
          print(value.latitude);
          print(value.longitude);
          _locationState.setLocationLatitude(value.latitude);
          _locationState.setLocationlongitude(value.longitude);
          //              final coordinates = new Coordinates(
          //                _locationState.locationLatitude, _locationState
          //  .locationlongitude);
          List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
              _locationState.locationLatitude, _locationState
              .locationlongitude);
          _locationState.setCurrentAddress(placemark[0].name);

          //   var addresses = await Geocoder.local.findAddressesFromCoordinates(
          //     coordinates);
          //   var first = addresses.first;
          // _locationState.setCurrentAddress(first.addressLine);
          // print(_locationState.address);
        }),
        markerId: MarkerId('my marker'),
        // infoWindow: InfoWindow(title: widget.address),
        position: LatLng(_locationState.locationLatitude,
            _locationState.locationlongitude),
        flat: true,
    );
    _markers.add( _marker);




    return  PageContainer(


      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Image.asset("assets/images/back.png",color: cPrimaryColor,),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("إختيار موقع التوصيل",style: TextStyle(color: cText,fontSize: 17),),
            centerTitle: true,
          ),
          body:  Container(
            height: _height,
            color: cPrimaryColor,
            child: LayoutBuilder(builder: (context,constraints){
              return Container(


                height: _height-(_height*.07),
                decoration: new BoxDecoration(

                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Colors.white,

                ),


                child: SingleChildScrollView(
                    child:  Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[


                        Container(

                          height: _height-(_height*.3),
                          child:  GoogleMap(
                            markers: _markers,
                            mapType: MapType.normal,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            mapToolbarEnabled: true,

                            // myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(

                                target: LatLng(_locationState.locationLatitude,
                                    _locationState.locationlongitude),
                                zoom: 15,
                            ),
                            onMapCreated: (GoogleMapController controller) async{

                              _locationState.setLocationLatitude(_locationState.locationLatitude);
                              _locationState.setLocationlongitude(_locationState.locationlongitude);

                              List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
                                  _locationState.locationLatitude,_locationState.locationlongitude);
                              _locationState.setCurrentAddress(placemark[0].name + '  ' + placemark[0].administrativeArea + ' '
                                  + placemark[0].country);

                              controller.setMapStyle(MapStyle.style);
                              _mapController.complete(controller);

                              controller.animateCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(_locationState.locationLatitude,_locationState.locationlongitude),
                                      zoom: 15.0)));


                            },

                            onCameraMove: ((_position) => _updatePosition(_position)),

                          ),
                        ),

                        Container(
                          height: _height*.1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft:  Radius.circular(6.00),
                                topRight:  Radius.circular(6.00),
                                bottomRight:  Radius.circular(6.00),
                                bottomLeft:  Radius.circular(6.00),
                              ),
                              border: Border.all(color: cPrimaryColor)),

                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),

                          width: _width*.9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("assets/images/pin.png",color: cText,),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(_locationState.address!=null?_locationState.address:"",style: TextStyle(
                                  height: 1.5,
                                  color: cText,fontSize: 18,fontWeight: FontWeight.w400
                              ),
                                maxLines: 2,
                                softWrap: true,

                              )
                            ],
                          ),
                        ),
                        Container(

                             height: 50,
                            width: _width*.99,
                            child: CustomButton(
                                btnLbl: "اختيار الموقع الحالي",
                                onPressedFunction: () async {

                                  if(_locationState.locationLatitude==null || _locationState.locationlongitude==null){
                                   // Commons.showError(context, _homeProvider.currentLang=="ar"?"عفوا يجب تحديد اللوكيشن":"Sorry, you must specify the location");
                                    showErrorDialog("عفوا يجب تحديد اللوكيشن", context);
                                  }else {
                                    Navigator.pushNamed(context, '/navigation');
                                  }

                                }))

                      ],
                    )),
              );
            }),
          )),
    );
  }

  Future<void> _updatePosition(CameraPosition _position) async {
    print(
        'inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    // Marker marker = _markers.firstWhere(
    //     (p) => p.markerId == MarkerId('marker_2'),
    //     orElse: () => null);

    _markers.remove(_marker);
    _markers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: false,
        icon: pinLocationIcon



      ),
    );
    print(_position.target.latitude);
    print(_position.target.longitude);
    _locationState.setLocationLatitude(_position.target.latitude);
    _locationState.setLocationlongitude(_position.target.longitude);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        _locationState.locationLatitude, _locationState
        .locationlongitude);
    _locationState.setCurrentAddress(placemark[0].name + '  ' + placemark[0].administrativeArea + ' '
        + placemark[0].country);
    //              final coordinates = new Coordinates(
    //                _locationState.locationLatitude, _locationState
    //  .locationlongitude);
    //       var addresses = await Geocoder.local.findAddressesFromCoordinates(
    //         coordinates);
    //       var first = addresses.first;
    //     _locationState.setCurrentAddress(first.addressLine);
    print(_locationState.address);
    if (!mounted) return;
    setState(() {});
  }



}
















class MapStyle {
  static String style = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
}
