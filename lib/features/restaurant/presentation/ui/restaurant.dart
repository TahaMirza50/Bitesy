import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:resturant_review_app/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';
import 'package:resturant_review_app/features/restaurant/widgets/star.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool _showAppBarBackground = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _showAppBarBackground = _scrollController.offset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: _buildBody());
  }

  ListView _buildBody() {
    return ListView(
      controller: _scrollController,
      children: [
        Stack(
          children: [
            _buildCarousel(),
            _buildOverlayedContent(),
          ],
        ),
        const RestaurantReview()
      ],
    );
  }

  Container _buildOverlayedContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cusines Of Nepal',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Star(width: 25, height: 25, color: Colors.amber, starSize: 20),
              SizedBox(width: 4),
              Text(
                '3.9',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '(2,394 reviews)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }

  CarouselSlider _buildCarousel() {
    return CarouselSlider(
      items: [
        //1st Image of Slider
        Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset('assets/images/resturantpage.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                color: Color.fromRGBO(5, 65, 196, 0.19),
              ),
            ],
          ),
        ),
        //2nd Image of Slider
        Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset('assets/images/resturantpage.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                color: Color.fromRGBO(5, 65, 196, 0.19),
              ),
            ],
          ),
        ),
        //3rd Image of Slider
        Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset('assets/images/resturantpage.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                color: Color.fromRGBO(5, 65, 196, 0.19),
              ),
            ],
          ),
        ),
      ],

      //Slider Container properties
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        enlargeCenterPage: true,
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        elevation: _showAppBarBackground ? 4.0 : 0,
        backgroundColor:
            _showAppBarBackground ? Colors.white : Color(0x44000000),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: _showAppBarBackground ? Colors.black : Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: _showAppBarBackground ? Colors.black : Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: _showAppBarBackground ? Colors.black : Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        title: _showAppBarBackground
            ? Text(
                'Cusines Of Nepal',
                style: TextStyle(color: Colors.black),
              )
            : null,
      );
}
