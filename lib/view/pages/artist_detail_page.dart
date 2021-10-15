import 'package:flutter/material.dart';
import 'package:simple_music_app/model/models/artist.dart';
import 'package:simple_music_app/model/services/url_launcher_service.dart'
    as url_launcher_service;

class ArtistDetailPage extends StatelessWidget {
  //UI for displaying artist details
  @override
  Widget build(BuildContext context) {
    //using ModalRoute to access the Artist object I passed in the arguments from ArtistList
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    Artist _artist = routeArgs['artist'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Artist: ${_artist.name.toString()}',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Listeners: ${_artist.listeners.toString()}',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextButton(
              onPressed: () => url_launcher_service
                  .launchURL(_artist.url.toString()),
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
                    'Visit Last.fm profile of ${_artist.name.toString()}',
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
