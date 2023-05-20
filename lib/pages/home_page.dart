import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quoter/widgets/quote_widget.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var apiURL = "https://type.fit/api/quotes";
  PageController controller = PageController();

  Future<List<dynamic>> getPost() async {
    final response = await http.get(Uri.parse('$apiURL'));
    return postFromJson(response.body);
  }

  List<dynamic> postFromJson(String str) {
    List<dynamic> jsonData = json.decode(str);
    jsonData.shuffle();
    return jsonData;
  }

  RandomColor _randomColor = RandomColor();

  // void onShareClick(String text) {
  //   String url = 'https://example.com/share?text=$text'; // Replace with your sharing URL
  //   launch(url);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error as Object); // Cast to Object
            }
            // Other code for handling the snapshot when there is no error

            return Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var model = snapshot.data[index];
                    return QuoteWidget(
                      quote: model["text"].toString(),
                      author: model["author"].toString(),
                      onPrClick: () {},
                      onNextClick: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeIn);
                      },
                      bgColor: _randomColor.randomColor(
                        colorHue: ColorHue.multiple(
                          colorHues: [ColorHue.red, ColorHue.blue],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (kIsWeb)
                        InkWell(
                          onTap: () {
                            controller.previousPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeOut);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      if (kIsWeb)
                        InkWell(
                          onTap: () {
                            controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
