import 'package:flutter/material.dart';
import 'package:simple_music_app/model/models/album.dart';

import 'package:url_launcher/url_launcher.dart';

class AlbumDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    Album _album = routeArgs['album'];

    return Scaffold(
      appBar: AppBar(title: const Text('Album detail Page'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Album: " + _album.name.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Artist: " + _album.artist.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
                onPressed: () => _launchLastFMProfile(_album.url.toString()),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(7, 7),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Visit the Last.fm page of " +
                        _album.name.toString(),style: TextStyle(fontSize: 12), ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _launchLastFMProfile(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
