import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_screen.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  TextEditingController _searchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();

  int _PolygonIdCounder = 1;

  static final CameraPosition _kCameraPlex =
      const CameraPosition(target: LatLng(8.175332, 77.437855), zoom: 15);

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygon = Set<Polygon>();
  List<LatLng> polygonLatLan = <LatLng>[];

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    _setMarker(LatLng(lat, lng));
  }

  @override
  void initState() {
    super.initState();
    _setMarker(const LatLng(8.175332, 77.437855));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'Polygon_$_PolygonIdCounder';
    _PolygonIdCounder++;

    _polygon.add(
      Polygon(
          polygonId: PolygonId(polygonIdVal),
          points: polygonLatLan,
          strokeWidth: 2,
          fillColor: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onTap: (point) {
                      setState(() {
                        polygonLatLan.add(point);
                        _setPolygon();
                      });
                    },
                    markers: _markers,
                    polygons: _polygon,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationButtonEnabled: true,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(8.175332, 77.437855), zoom: 15),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (values) {
                          print(values);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Your Location",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var place = await LocationService()
                                  .getPlace(_searchController.text);
                              _goToPlace(place);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                            right: 10,
                            top: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top:700, left: 25 ),
            child: FloatingActionButton(onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
            },backgroundColor: Colors.green,child: const Icon(Icons.keyboard_return),),
          )
        ],
      ),
    );
  }
}
