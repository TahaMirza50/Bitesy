import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Bitesy/screens/search_page/model/restaurant_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Bitesy/features/restaurant/widgets/header_text.dart';

class RestaurantInfo extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const RestaurantInfo({super.key, required this.restaurantModel});

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  late final LatLng restaurantLocation = LatLng(
      double.parse(widget.restaurantModel.latitude),
      double.parse(widget.restaurantModel.longitude));

  GoogleMapController? _mapController;

  void openGoogleMaps() async {
    var uri = Uri.parse(
        'google.navigation:q=${restaurantLocation.latitude},${restaurantLocation.longitude}&mode=d');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            const HeaderText(
                header: "Info",
                textStyle:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            _buildInfoTab(
                header: "Website",
                subheader: widget.restaurantModel.website,
                icon: Icons.link_outlined),
            const SizedBox(height: 24),
            _buildInfoTab(
                header: "Call",
                subheader: '${widget.restaurantModel.phoneNum}',
                icon: Icons.call_outlined),
            const SizedBox(height: 24),
            _buildGoogleMaps(),
            const SizedBox(height: 24),
            _buildAddressInfo(),
            const SizedBox(height: 24),
            _buildGetDirectionsButton()
          ],
        ),
      ),
    );
  }

  Row _buildInfoTab({
    required String header,
    required String subheader,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
                header: header,
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            HeaderText(
                header: subheader,
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          ],
        ),
        // website icon link
        Icon(icon, color: Colors.black, size: 22),
      ],
    );
  }

  Expanded _buildGoogleMaps() {
    return Expanded(
      child: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition:
            CameraPosition(target: restaurantLocation, zoom: 15),
        markers: {
          Marker(
            markerId: MarkerId('restaurant'),
            position: restaurantLocation,
          ),
        },
      ),
    );
  }

  InkWell _buildGetDirectionsButton() {
    return InkWell(
      onTap: () {
        openGoogleMaps();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(
                  header: "Get Directions",
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          Icon(Icons.directions_outlined, color: Colors.black, size: 22),
        ],
      ),
    );
  }

  Column _buildAddressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(
            header: widget.restaurantModel.address,
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        // HeaderText(
        //     header: "Space 164",
        //     textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        // const SizedBox(height: 2),
        // HeaderText(
        //     header: "Stonestown",
        //     textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        // const SizedBox(height: 2),
        // HeaderText(
        //     header: "San Fransisco, CA",
        //     textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
      ],
    );
  }
}
