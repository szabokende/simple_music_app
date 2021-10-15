import 'package:flutter/material.dart';
import 'package:simple_music_app/model/models/track.dart';
import 'package:simple_music_app/model/services/url_launcher_service.dart'
    as url_launcher_service;


class TrackDetailPage extends StatelessWidget {
  //UI for displaying song details
  @override
  Widget build(BuildContext context) {
    //using ModalRoute to access the Track object I passed in the arguments from TrackList
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    Track _track = routeArgs['track'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Song: ${_track.name.toString()}',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Artist: ${_track.artist.toString()}',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Listeners: ${_track.listeners.toString()}',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
              onPressed: () => url_launcher_service
                  .launchURL(_track.url.toString()),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(7, 7),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Visit the Last.fm page of ${_track.name.toString()}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
