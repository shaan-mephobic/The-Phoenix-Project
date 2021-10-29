import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import '../utilities/page_backend/artists_back.dart';

Widget? artistCollage(
    int? index, List listOfArtists, double cornerRadius, double size) {
  if (musicBox.get("mapOfArtists") == null
      ? false
      : musicBox.get("mapOfArtists")[listOfArtists[index!]] != null) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        image: DecorationImage(
          image: FileImage(
            File(
              "${applicationFileDirectory.path}/artists/${listOfArtists[index]}.jpg",
            ),
          ),
        ),
      ),
    );
  } else {
    if (artistsAlbums[listOfArtists[index!]].length == 0) {
      return null;
    } else if (artistsAlbums[listOfArtists[index]].length == 1) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(
                albumsArts[artistsAlbums[listOfArtists[index]][0]] ??
                    defaultNone!),
          ),
        ),
      );
    } else if (artistsAlbums[listOfArtists[index]].length == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(cornerRadius),
                  topRight: Radius.circular(cornerRadius)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                    albumsArts[artistsAlbums[listOfArtists[index]][0]] ??
                        defaultNone!),
              ),
            ),
          ),
          Container(
            width: size,
            height: size / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(cornerRadius),
                  bottomRight: Radius.circular(cornerRadius)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                    albumsArts[artistsAlbums[listOfArtists[index]][1]] ??
                        defaultNone!),
              ),
            ),
          ),
        ],
      );
    } else if (artistsAlbums[listOfArtists[index]].length == 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][0]] ??
                            defaultNone!),
                  ),
                ),
              ),
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][1]] ??
                            defaultNone!),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size,
            height: size / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(cornerRadius),
                bottomLeft: Radius.circular(cornerRadius),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                    albumsArts[artistsAlbums[listOfArtists[index]][2]] ??
                        defaultNone!),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][0]] ??
                            defaultNone!),
                  ),
                ),
              ),
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][1]] ??
                            defaultNone!),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][2]] ??
                            defaultNone!),
                  ),
                ),
              ),
              Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(cornerRadius),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[listOfArtists[index]][3]] ??
                            defaultNone!),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
