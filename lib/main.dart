import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_app/model/repositories/artist_repository.dart';
import 'package:simple_music_app/view/pages/album_detail_page.dart';
import 'package:simple_music_app/view/pages/artist_detail_page.dart';
import 'package:simple_music_app/view/pages/search_page.dart';
import 'package:simple_music_app/view/pages/track_detail_page.dart';
import 'package:simple_music_app/view_model/album_view_model.dart';
import 'package:simple_music_app/view_model/artist_view_model.dart';
import 'package:simple_music_app/view_model/track_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ArtistViewModel()),
        ChangeNotifierProvider.value(value: AlbumViewModel()),
        ChangeNotifierProvider.value(value: TrackViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 40, color: Colors.teal),
              headline3: TextStyle(fontSize: 25, color: Colors.black),
              headline6: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            )),
        initialRoute: "/searchPage",
        routes: {
          "/searchPage": (context) => SearchPage(),
          "/artistDetailPage": (context) => ArtistDetailPage(),
          "/albumDetailPage": (context) => AlbumDetailPage(),
          "/trackDetailPage": (context) => TrackDetailPage(),

        },
      ),
    );
  }
}
