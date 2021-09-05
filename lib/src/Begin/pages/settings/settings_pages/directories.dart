import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../begin.dart';
import '../../../utilities/page_backend/file_exporer.dart';

class Directories extends StatefulWidget {
  @override
  _DirectoriesState createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  ScrollController _scrollBarController;

  @override
  void dispose() {
    saveLocations();
    backArtStateChange = true;
    refresh = true;
    super.dispose();
  }

  @override
  void initState() {
    _scrollBarController = ScrollController();
    backArtStateChange = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.check_rounded, color: Colors.black),
          label: Text("DONE",
              style: TextStyle(
                  inherit: false,
                  color: Colors.black,
                  fontSize: deviceWidth / 25,
                  fontFamily: 'UrbanSB')),
          backgroundColor: Color(0xFF1DB954),
          elevation: 8.0,
          onPressed: () async {
            saveLocations();
            Navigator.pop(context);
          }),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: darkModeOn ? Colors.white : kMaterialBlack,
        ),
        titleSpacing: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "PICK YOUR FOLDERS",
          style: TextStyle(
            color: darkModeOn ? Colors.white : Colors.black,
            inherit: false,
            fontSize: deviceWidth / 18,
            fontFamily: "UrbanSB",
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 50,
              width: orientedCar ? deviceHeight : deviceWidth,
              child: InkWell(
                onTap: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_upward_rounded),
                          color: darkModeOn ? Colors.white60 : Colors.black87,
                          splashColor: Color(0xFF05464f),
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            if (currentTopDir != topLevelDir) {
                              currentTopDir = previousDir(currentTopDir);
                              await iterationManager(currentTopDir);
                              setState(() {});
                            }
                          }),
                      Container(
                        width: orientedCar
                            ? deviceHeight / 1.5
                            : deviceWidth / 1.5,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            currentTopDir.replaceAll(topLevelDir, "..."),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'UrbanR',
                              fontSize: 20,
                              color:
                                  darkModeOn ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.more_vert_rounded),
                          color: darkModeOn ? Colors.white60 : Colors.black87,
                          splashColor: Color(0xFF05464f),
                          onPressed: () {}),
                    ]),
              ),
            ),
          ),
        ),
      ),
      body: Theme(
        data: themeOfApp,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            color: darkModeOn ? kMaterialBlack : Colors.white,
            padding: EdgeInsets.only(top: kToolbarHeight + kToolbarHeight + 50),
            height: deviceHeight,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Scrollbar(
                controller: _scrollBarController,
                child: ListView.builder(
                  controller: _scrollBarController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 5, bottom: 8),
                  addAutomaticKeepAlives: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: fileExplorer.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        activeColor: kCorrect,
                        checkColor: darkModeOn ? kMaterialBlack : Colors.white,
                        title: Text(
                          fileExplorer.keys
                              .toList()[index]
                              .toString()
                              .replaceAll(currentTopDir, ""),
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontFamily: "UrbanR"),
                        ),
                        secondary: Material(
                          color: Colors.transparent,
                          child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios_rounded),
                              color:
                                  darkModeOn ? Colors.white : Colors.grey[700],
                              onPressed: () async {
                                HapticFeedback.lightImpact();
                                await iterationManager(
                                    fileExplorer.keys.toList()[index]);
                                setState(() {});
                              }),
                        ),
                        value: isTicked(fileExplorer.keys.toList()[index]),
                        onChanged: (newValue) {
                          fileExplorer.values.toList()[index][0] = newValue;
                          if (newValue) {
                            selectedFolders
                                .add(fileExplorer.keys.toList()[index]);
                          } else {
                            unTick(fileExplorer.keys.toList()[index]);
                          }
                          print(selectedFolders);
                          setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (currentTopDir == topLevelDir) {
      Navigator.pop(context);
    } else {
      HapticFeedback.lightImpact();

      currentTopDir = previousDir(currentTopDir);
      await iterationManager(currentTopDir);
      setState(() {});
    }
    return false;
  }
}
