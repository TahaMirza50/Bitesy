import 'package:flutter/material.dart';

import '../../../../widgets/header_text.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          child: Image.asset(
                            "assets/images/menu_images/manu.webp",
                            fit: BoxFit.cover,
                            height: 400.0,
                          ),
                        ),
                      )
                    ]
                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeaderText(
                      header: "Menu",
                      textStyle:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  Icon(Icons.arrow_right_alt_outlined,
                      color: Colors.black, size: 24)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
