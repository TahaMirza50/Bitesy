import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resturant_review_app/features/restaurant/presentation/ui/restaurant.dart';
import 'package:resturant_review_app/constants/constants.dart';
import 'package:resturant_review_app/screens/admin_page/ui/add_page.dart';
import 'package:resturant_review_app/screens/login_and_signup/model/user.dart';
import 'package:resturant_review_app/screens/login_and_signup/repository/user_repository.dart';
import 'package:resturant_review_app/screens/search_page/bloc/search_page_bloc.dart';
import 'package:resturant_review_app/screens/search_page/model/restaurant_model.dart';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestaurantPage(restaurantModel: navigateState.restaurantModel,)),
                );
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _restaurantName.clear();
                      search = false;
                      searchPageBloc.add(SearchPageInitialEvent());},
                    child: ListView.builder(
                        itemCount: successState.restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantTile(
                            restaurantBloc: searchPageBloc,
                            restaurantModel: successState.restaurants[index],
                          );
                        }),
                  ),
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
                      onPressed: _restaurantName.clear,
                      icon: const Icon(Icons.clear),
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
      final UserModel userModel = state.userModel;
      if (userModel.role == 'admin') {
        return Drawer(
          backgroundColor: Colors.brown,
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: 100,
                        child: Image.network(
                            userModel.avatar,
                          fit: BoxFit.cover,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${userModel.firstName} ${userModel.lastName}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userModel.email,
                        style: const TextStyle(color: Colors.brown),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text('Add Restaurant',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddRestaurantPage()));
                },
              ),
              const Spacer(),
              const Divider(color: Colors.white, thickness: 1),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.white),
                title: const Text('Log Out',
                    style: TextStyle(color: Colors.white)),
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
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }
      return Drawer(
        backgroundColor: Colors.brown,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: 100,
                        child: Image.network(
                            userModel.avatar,
                          fit: BoxFit.cover,),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${userModel.firstName} ${userModel.lastName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userModel.email,
                      style: const TextStyle(color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Divider(color: Colors.white, thickness: 1),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title:
                  const Text('Log Out', style: TextStyle(color: Colors.white)),
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }

    return Drawer(
      backgroundColor: Colors.brown,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "No Email",
                    style: TextStyle(color: Colors.brown),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Divider(color: Colors.white, thickness: 1),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
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
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
