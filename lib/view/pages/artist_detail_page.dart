import 'package:flutter/material.dart';
import 'package:simple_music_app/model/models/artist.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    Artist _artist = routeArgs['artist'];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Artist: " + _artist.name.toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Listeners: " + _artist.listeners.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
                onPressed: () => _launchLastFMProfile(_artist.url.toString()),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Visit Last.fm profile of " +
                        _artist.name.toString(),style: TextStyle(fontSize: 12), ),
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
