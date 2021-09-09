import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/begin.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:provider/provider.dart';

class Changelogs extends StatefulWidget {
  const Changelogs({Key key}) : super(key: key);
  @override
  _ChangelogsState createState() => _ChangelogsState();
}

class _ChangelogsState extends State<Changelogs> {
  @override
  void initState() {
    rootCrossfadeState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);
    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: kMaterialBlack,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Changelogs",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Urban",
                fontWeight: FontWeight.w600,
                fontSize: deviceWidth / 18,
              ),
            ),
          ),
          body: Theme(
            data: themeOfApp,
            child: Container(
              child: Stack(
                children: [
                  BackArt(),
                  Container(
                    padding: EdgeInsets.only(top: kToolbarHeight + 20),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          for (int i = 0; i < changelogs.length; i++)
                            Column(
                              children: [
                                ListTile(
                                  title: Text(changelogs.keys.toList()[i],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Urban")),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Text(
                                  changelogs.values.toList()[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Urban",
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          Divider(
                            color: Colors.white54,
                            indent: 50,
                            thickness: 0.2,
                            endIndent: 50,
                            height: 110,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
