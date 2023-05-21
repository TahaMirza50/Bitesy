import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resturant_review_app/screens/search_page/bloc/search_page_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    searchPageBloc.add(SearchPageInitialEvent());
    super.initState();
  }

  final SearchPageBloc searchPageBloc = SearchPageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchPageBloc, SearchPageState>(
      bloc: searchPageBloc,
      listenWhen: (previous, current) => current is SearchPageActionState,
      buildWhen: (previous, current) => current is! SearchPageActionState,
      listener: (context, state) {
        if (state is NavigateToRestaurantPageState) {
          // Navigator.pushNamed(context, '/restaurant_page');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchPageLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SearchPageSuccessState:
            return Scaffold(
              drawer: Drawer(
                backgroundColor: Colors.brown,
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      child: Text('Drawer Header'),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      title: Text('Log Out'),
                      onTap: () async {
                              FacebookAuth.instance.logOut();
                              GoogleSignIn().disconnect();
                              FirebaseAuth.instance.signOut().then((value) => {
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              )
                              });
                            },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(200.0),
                child: SafeArea(
                    child: Container(
                        child: AppBar(
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Search Restaurant',
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.search, color: Colors.brown)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.brown,
                              fontSize: 25),
                          decoration: InputDecoration(
                              hintText: 'Type Something...',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              focusedBorder: const UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(width: 3, color: Colors.brown),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 3, color: Colors.brown.shade400),
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
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Search Page',
                    ),
                  ],
                ),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
