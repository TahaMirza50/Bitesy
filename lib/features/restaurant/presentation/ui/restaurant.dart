import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bitesy/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Bitesy/features/restaurant/sections/info/presentation/ui/restaurant_info.dart';
import 'package:Bitesy/features/restaurant/sections/menu/presentation/ui/restaurant_menu.dart';
import 'package:Bitesy/features/restaurant/sections/review/presentation/ui/restaurant_review.dart';
import 'package:Bitesy/features/restaurant/widgets/star.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';

class RestaurantPage extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const RestaurantPage({super.key, required this.restaurantModel});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool _showAppBarBackground = false;
  late ScrollController _scrollController;
  final RestaurantBloc restaurantBloc = RestaurantBloc();

  @override
  void initState() {
    super.initState();
    restaurantBloc.add(RestaurantInitialEvent(id: widget.restaurantModel.id));
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void shareContent() async {
    try {
      await Share.share(
          '''Check out this restaurant: ${widget.restaurantModel.name}\n'''
          '''Phone: ${widget.restaurantModel.phoneNum}\n'''
          '''Website: ${widget.restaurantModel.website}\n'''
          '''Address: ${widget.restaurantModel.address}\n''');

      print('Share completed successfully.');
    } catch (e) {
      print('Error sharing: $e');
    }
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
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        listenWhen: (previous, current) => current is RestaurantActionEvent,
        buildWhen: (previous, current) => current is! RestaurantActionEvent,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case RestaurantLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RestaurantSuccessState:
              final restaurant = (state as RestaurantSuccessState).restaurant;
              return _buildBody(restaurant: restaurant);
            case RestaurantErrorState:
              return const Center(
                child: Text('Error'),
              );
            default:
              return Container();
          }
        },
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse(
                  'google.navigation:q=${widget.restaurantModel.latitude},${widget.restaurantModel.longitude}&mode=d');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not open Google Maps';
              }
            },
            child: Text('Directions',
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView _buildBody({required RestaurantModel restaurant}) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                _buildCarousel(images: restaurant.images),
                _buildOverlayedContent(restaurant: restaurant),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(
                      icon: Icons.call_outlined,
                      label: 'Call',
                      onTap: () async {
                        final call = Uri.parse('tel:+${restaurant.phoneNum}');
                        if (await canLaunchUrl(call)) {
                          launchUrl(call);
                        } else {
                          throw 'Could not launch $call';
                        }
                      }),
                  const SizedBox(width: 8),
                  _buildIconButton(
                      icon: Icons.map_outlined,
                      label: 'Map',
                      onTap: () async {
                        final uri = Uri.parse(
                            'google.navigation:q=${restaurant.latitude},${restaurant.longitude}&mode=d');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          throw 'Could not open Google Maps';
                        }
                      }),
                  const SizedBox(width: 8),
                  _buildIconButton(
                      icon: Icons.link_outlined,
                      label: 'Web',
                      onTap: () async {
                        final Uri url = Uri.parse(restaurant.website);
                        print("Hello world");
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
                ],
              ),
            ),
            RestaurantMenu(restaurantModel: restaurant),
            RestaurantInfo(restaurantModel: restaurant),
            RestaurantReview(restaurantModel: restaurant)
          ],
        ),
      ),
    );
  }

  // build Icon button
  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required Future<void> Function() onTap,
  }) {
    // icon button with grey circular background
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.brown[200],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.grey[900], size: 24),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildOverlayedContent({required RestaurantModel restaurant}) {
    final int avgRating = double.parse(restaurant.avgRating).round();
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < avgRating; i++)
                Star(width: 25, height: 25, color: Colors.amber, starSize: 20),
              SizedBox(width: 4),
              Text(
                double.parse(restaurant.avgRating).toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '(${restaurant.numReviews} reviews)',
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

  CarouselSlider _buildCarousel({required List<String> images}) {
    print(images);
    return CarouselSlider(
      items: [
        for (final image in images)
          Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(5, 65, 196, 0.19),
                ),
              ],
            ),
          )
      ],

      //Slider Container properties
      options: CarouselOptions(
        height: 250,
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
        centerTitle: true,
        elevation: _showAppBarBackground ? 4.0 : 0.0,
        backgroundColor:
            _showAppBarBackground ? Colors.white : Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: _showAppBarBackground ? Colors.black : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: _showAppBarBackground ? Colors.black : Colors.white,
            ),
            onPressed: shareContent,
          ),
        ],
        title: _showAppBarBackground
            ? Text(
                widget.restaurantModel.name,
                style: TextStyle(
                    color: Color.fromARGB(255, 122, 102, 95),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            : null,
      );
}
