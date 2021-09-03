import 'package:phoenix/src/Begin/begin.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';

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
    return Consumer<Leprovider>(builder: (context, taste, _) {
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
          title: Hero(
            tag: "crossfire-",
            child: Text(
              "Interface",
              style: TextStyle(
                color: darkModeOn ? Colors.white : Colors.black,
                inherit: false,
                fontSize: deviceWidth / 18,
                fontFamily: "UrbanSB",
              ),
            ),
          ),
        ),
        body: Theme(
    
        data: themeOfApp,

                  
          child: Container(
            height: deviceHeight,
    
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
                          "A fluid animation on scrolling",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "FLUID",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("fluidAnimation") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("fluidAnimation", newValue);

                            // checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Use albumart as background",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "DYNAMIC BACKGROUND",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("dynamicArtDB") ?? true,
                        onChanged: (newValue) {
                          musicBox.put("dynamicArtDB", newValue);

                          setState(() {
                            // checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Position icons for driver's ease",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "LEFT-HAND STEERING",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("androidAutoLefty") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("androidAutoLefty", newValue);
                            // checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
             
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Show additional song data in now-playing.",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "AUDIOPHILE DATA",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("audiophileData") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("audiophileData", newValue);

                            // checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        subtitle: Text(
                          "Use regular mini-player design.",
                          style: TextStyle(
                            fontFamily: 'UrbanR',
                            color: darkModeOn ? Colors.white38 : Colors.black38,
                          ),
                        ),
                        title: Text(
                          "CLASSIC MINI-PLAYER",
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        value: musicBox.get("classix") ?? true,
                        onChanged: (newValue) {
                          setState(() {
                            musicBox.put("classix", newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                 
                  ],
                  physics: musicBox.get("fluidAnimation") ?? true
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
