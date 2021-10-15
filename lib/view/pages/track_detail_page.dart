import 'package:flutter/material.dart';
import 'package:simple_music_app/model/models/track.dart';

import 'package:url_launcher/url_launcher.dart';

class TrackDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    Track _track = routeArgs['track'];

    return Scaffold(
      appBar: AppBar(title: const Text('Track detail Page'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Song: " + _track.name.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Artist: " + _track.artist.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Listeners: " + _track.listeners.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
                onPressed: () => _launchLastFMProfile(_track.url.toString()),
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
                    child: Text("Visit the Last.fm page of  " +
                        _track.name.toString(),style: TextStyle(fontSize: 12), ),
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
