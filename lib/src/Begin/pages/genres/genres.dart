import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:phoenix/src/Begin/pages/genres/genres_inside.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/awakening.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';
import '../../utilities/page_backend/genres_back.dart';

int genreSelected;
List<SongModel> genreSongs;
List<MediaItem> genreMediaItems = [];

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (ascend) {
      return ListView.builder(
          padding: EdgeInsets.only(top: 5, bottom: 8),
          addAutomaticKeepAlives: true,
          itemExtent: orientedCar ? deviceWidth / 1.4 : deviceWidth / 2,
          physics: musicBox.get("fluidAnimation")??true
          ? BouncingScrollPhysics() 
          : ClampingScrollPhysics(),
          itemCount: musicBox.get('customScan') ?? false
              ? insideAllGenreData.length
              : allgenres.length,
          itemBuilder: (context, index) {
            return Container(
              height: orientedCar ? deviceHeight / 3 : deviceWidth / 2,
              width: orientedCar ? deviceHeight : deviceWidth,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: deviceWidth / 25),
                  ),
                 
                  Container(
                    width:
                        orientedCar ? deviceHeight / 1.4 : deviceWidth / 1.05,
                    height:
                        orientedCar ? deviceHeight / 3.3 : deviceWidth / 2.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 13.0,
                          offset: kShadowOffset,
                          
                        ),
                      ],
                
                    ),
                   
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRounded),
                    
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Material(
                         

                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(kRounded),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kRounded),
                             
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04)),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                genreSelected = index;
                                genreMediaItems = [];
                                if (musicBox.get('customScan') ?? false) {
                                  genreSongs =
                                      insideAllGenreData.values.toList()[index];
                                } else {
                                  genreSongs = await OnAudioQuery()
                                      .queryAudiosFrom(AudiosFromType.GENRE,
                                          allgenres[index].genre);
                                }
                                putinGenreInMediaItem();
                                Navigator.push(
                                  context,
                             
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<Leprovider>(
                                      create: (_) => Leprovider(),
                                      builder: (context, child) =>
                                          GenresInside(),
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: "crossfire-$index",
                                child: Center(
                                  child: Text(
                                    musicBox.get('customScan') ?? false
                                        ? insideAllGenreData.keys
                                            .toList()[index]
                                        : allgenres[index].genre,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        inherit: false,
                                        color: Colors.white,
                                        fontSize: deviceWidth / 20,
                                        fontFamily: "UrbanSB"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

    
          });
    }
    {
      return orientedCar
          ? SingleChildScrollView(child: Awakening())
          : Awakening();
    }
  }


  @override
  bool get wantKeepAlive => true;
}
