import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../../begin.dart';
import 'directories.dart';
import '../../../utilities/page_backend/file_exporer.dart';

Map folderData = {};

class Miscellaneous extends StatefulWidget {
  @override
  _MiscellaneousState createState() => _MiscellaneousState();
}

class _MiscellaneousState extends State<Miscellaneous> {
  bool darkModeOn = true;

  @override
  void initState() {
    rootCrossfadeState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }

    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          backgroundColor: kMaterialBlack,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: darkModeOn ? Colors.white : kMaterialBlack,
            ),
            shadowColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Miscellaneous",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth / 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Urban",
              ),
            ),
          ),
          body: Theme(
            data: themeOfApp,
            child: Stack(
              children: [
                BackArt(),
                ListView(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Don't show music below 30 seconds",
                          style: TextStyle(
                            fontFamily: 'Urban',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "30 Seconds Rule",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "Urban"),
                        ),
                        value: musicBox.get("clutterFree") ?? false,
                        onChanged: (newValue) {
                          refresh = true;
                          setState(() {
                            musicBox.put("clutterFree", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Don't show '<Unknown>' as an Artist",
                          style: TextStyle(
                            fontFamily: 'Urban',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Unknown Artist",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "Urban"),
                        ),
                        value: musicBox.get("stopUnknown") ?? false,
                        onChanged: (newValue) {
                          refresh = true;
                          setState(() {
                            musicBox.put("stopUnknown", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Choose custom directories to scan for music",
                          style: TextStyle(
                            fontFamily: 'Urban',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "Custom Scan",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "Urban"),
                        ),
                        secondary: Visibility(
                          visible: musicBox.get("customScan") ?? false,
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                                icon: Icon(Icons.edit_rounded),
                                color: darkModeOn
                                    ? Colors.white
                                    : Colors.grey[700],
                                onPressed: () async {
                                  selectedFolders =
                                      musicBox.get("customLocations") ?? [];
                                  await iterationManager(topLevelDir);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Directories(),
                                    ),
                                  );
                                  setState(() {});
                                }),
                          ),
                        ),
                        value: musicBox.get("customScan") ?? false,
                        onChanged: (newValue) {
                          refresh = true;
                          setState(() {
                            musicBox.put("customScan", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Artwork is set as lockscreen wallpaper",
                          style: TextStyle(
                            fontFamily: 'Urban',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "WallPx (BETA)",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "Urban"),
                        ),
                        value: musicBox.get("wallpx") ?? false,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("wallpx", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
