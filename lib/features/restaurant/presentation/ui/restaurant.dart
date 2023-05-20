import 'package:flutter/material.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool _showAppBarBackground = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
    child: Column(
      children: const [
        RestaurantReview()
      ],
    ),
  );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor:
            _showAppBarBackground ? Colors.white : Colors.transparent,
        title: Text(
          'Cusines Of Nepal',
          style: TextStyle(
            color: _showAppBarBackground ? Colors.black : Colors.white,
          ),
        ),
      );
}
