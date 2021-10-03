import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:phoenix/src/beginning/pages/settings/settings_pages/glass_effect.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/widgets/artwork_background.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Interface extends StatefulWidget {
  @override
  _InterfaceState createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
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

    bool darkModeOn = true;
    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            shadowColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Interface",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth / 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Theme(
            data: themeOfApp,
            child: Stack(
              children: [
                BackArt(),
                Container(
                  padding: EdgeInsets.only(
                      top: kToolbarHeight + MediaQuery.of(context).padding.top),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          title: Text(
                            "Glass Effect",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "Adjust blur and color of glass theme.",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                maintainState: false,
                                builder: (context) =>
                                    ChangeNotifierProvider<Leprovider>(
                                        create: (_) => Leprovider(),
                                        child: GlassEffect()),
                              ),
                            );
                          },
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          title: Text(
                            "Default Artwork",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "Set custom image as default artwork.",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          leading: Card(
                            elevation: 3,
                            color: Colors.transparent,
                            child: ConstrainedBox(
                              constraints: musicBox.get("squareArt") ?? true
                                  ? kSqrConstraint
                                  : kRectConstraint,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(defaultNone),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                          ),
                          onLongPress: () async {
                            ByteData bytes =
                                await rootBundle.load('assets/res/default.jpg');
                            setState(() {
                              defaultNone = bytes.buffer.asUint8List();
                            });
                            await File(
                                    "${applicationFileDirectory.path}/artworks/null.jpeg")
                                .writeAsBytes(defaultNone,
                                    mode: FileMode.write);
                            Flushbar(
                              messageText: Text(
                                  "Default artwork has been reset",
                                  style: TextStyle(
                                      fontFamily: "Futura",
                                      color: Colors.white)),
                              icon: Icon(
                                Icons.restore_rounded,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              shouldIconPulse: true,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              duration: Duration(seconds: 3),
                              borderColor: Colors.white.withOpacity(0.04),
                              borderWidth: 1,
                              backgroundColor: glassOpacity,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              isDismissible: true,
                              barBlur: musicBox.get("glassBlur") == null
                                  ? 18
                                  : musicBox.get("glassBlur"),
                              margin: EdgeInsets.only(
                                  bottom: 20, left: 8, right: 8),
                              borderRadius: BorderRadius.circular(15),
                            )..show(context);
                            musicBox.put("dominantDefault", null);
                          },
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            Uint8List bytes = await image.readAsBytes();
                            setState(() {
                              defaultNone = bytes;
                            });
                            await File(
                                    "${applicationFileDirectory.path}/artworks/null.jpeg")
                                .writeAsBytes(bytes, mode: FileMode.write);
                            musicBox.put("dominantDefault", null);
                          },
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "A fluid bouncing animation on scrolling",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Fluid",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("fluidAnimation") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("fluidAnimation", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "Use albumart as background",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Dynamic Background",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("dynamicArtDB") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("dynamicArtDB", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "Square shaped artwork in lists",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Square Art",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("squareArt") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("squareArt", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "Position icons for driver's ease",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Left Steering",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("androidAutoLefty") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("androidAutoLefty", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "Show additional song data in now playing.",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Audiophile Data",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("audiophileData") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("audiophileData", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      // Material(
                      //   color: Colors.transparent,
                      //   child: CheckboxListTile(
                      //     activeColor: kCorrect,
                      //     checkColor:
                      //         darkModeOn ? kMaterialBlack : Colors.white,
                      //     subtitle: Text(
                      //       "Use regular mini-player design.",
                      //       style: TextStyle(
                      //         color:
                      //             darkModeOn ? Colors.white38 : Colors.black38,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       "Classix Mini-Player",
                      //       style: TextStyle(
                      //         color: darkModeOn ? Colors.white : Colors.black,
                      //       ),
                      //     ),
                      //     value: musicBox.get("classix") ?? true,
                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         musicBox.put("classix", newValue);
                      //       });
                      //     },
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //   ),
                      // ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                            subtitle: Text(
                              "Show progress in mini-player.",
                              style: TextStyle(
                                color: darkModeOn
                                    ? Colors.white38
                                    : Colors.black38,
                              ),
                            ),
                            title: Text(
                              "Mini-Player Progress",
                              style: TextStyle(
                                color: darkModeOn ? Colors.white : Colors.black,
                              ),
                            ),
                            trailing: DropdownButton<String>(
                              value:
                                  musicBox.get("miniPlayerProgress") ?? "Top",
                              icon: Icon(Icons.arrow_drop_down_rounded,
                                  color: Colors.white70),
                              elevation: 25,
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(kRounded / 2),
                              dropdownColor: kMaterialBlack.withOpacity(0.8),
                              underline: Container(
                                height: 2,
                                color: kCorrect,
                              ),
                              style: TextStyle(color: Colors.white),
                              onChanged: (String newValue) async {
                                await musicBox.put(
                                    "miniPlayerProgress", newValue);
                                setState(() {});
                              },
                              items: <String>[
                                'Top',
                                'Bottom',
                                'Hidden',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ),
                    ],
                    physics: musicBox.get("fluidAnimation") ?? true
                        ? BouncingScrollPhysics()
                        : ClampingScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
