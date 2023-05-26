import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/login_and_signup/model/user.dart';
import 'package:resturant_review_app/screens/login_and_signup/repository/user_repository.dart';
import 'package:resturant_review_app/screens/search_page/bloc/search_page_bloc.dart';
import 'package:resturant_review_app/screens/search_page/ui/restaurant_tile_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool search = false;
  final TextEditingController _restaurantName = TextEditingController();
  final SearchPageBloc searchPageBloc = SearchPageBloc();

  @override
  void initState() {
    searchPageBloc.add(SearchPageInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    searchPageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchPageBloc, SearchPageState>(
        bloc: searchPageBloc,
        listenWhen: (previous, current) => current is SearchPageActionState,
        buildWhen: (previous, current) => current is! SearchPageActionState,
        listener: (context, state) {
          if (state is NavigateToRestaurantPageState) {
            final navigateState = state as NavigateToRestaurantPageState;
            print(navigateState.restaurantModel.name);
            print("pushed");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const RestPage()),
            // );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchPageLoadingState:
              final loadingState = state as SearchPageLoadingState;
              return Scaffold(
                drawer: _buildDrawer(context, loadingState),
                appBar: _buildAppBar(context),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case SearchPageSuccessState:
              final successState = state as SearchPageSuccessState;
              return Scaffold(
                drawer: _buildDrawer(context, successState),
                appBar: _buildAppBar(context),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: successState.restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantTile(
                          restaurantBloc: searchPageBloc,
                          restaurantModel: successState.restaurants[index],
                        );
                      }),
                ),
              );
            case SearchPageErrorState:
              final errorState = state as SearchPageErrorState;
              return Scaffold(
                  drawer: _buildDrawer(context, errorState),
                  appBar: _buildAppBar(context),
                  body: Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/error.png')),
                  ));

            default:
              return const SizedBox();
          }
        });
  }

  PreferredSize _buildAppBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(200.0),
      child: SafeArea(
          child: Container(
              child: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Search Restaurant',
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.brown,
                    onPressed: () {
                      if (_restaurantName.text.isNotEmpty) {
                        search = true;
                        searchPageBloc.add(
                            SearchButtonPressedEvent(_restaurantName.text));
                      }
                    },
                  )
                ],
              ),
              TextField(
                controller: _restaurantName,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.brown,
                    fontSize: 25),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (search) {
                          search = false;
                          _restaurantName.clear();
                          searchPageBloc.add(SearchPageInitialEvent());
                        }
                      },
                      icon: Icon(Icons.clear),
                    ),
                    hintText: 'Type Something...',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    focusedBorder: const UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(width: 3, color: Colors.brown),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide:
                          BorderSide(width: 3, color: Colors.brown.shade400),
                    )),
              )
            ],
          ),
        ),
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.brown,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ))),
    );
  }

  Drawer _buildDrawer(context, state) {
    if (state is SearchPageSuccessState) {
      return Drawer(
        backgroundColor: Colors.brown,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                FacebookAuth.instance.logOut();
                GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut().then((value) => {
                      search = false,
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/'),
                      )
                    });
              },
            ),
          ],
        ),
      );
    }

    return Drawer(
      backgroundColor: Colors.brown,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () async {
              FacebookAuth.instance.logOut();
              GoogleSignIn().disconnect();
              FirebaseAuth.instance.signOut().then((value) => {
                    search = false,
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/'),
                    )
                  });
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
