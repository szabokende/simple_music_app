import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_app/view/widgets/album_list.dart';
import 'package:simple_music_app/view/widgets/artist_list.dart';
import 'package:simple_music_app/view/widgets/track_list.dart';
import 'package:simple_music_app/view_model/album_view_model.dart';
import 'package:simple_music_app/view_model/artist_view_model.dart';
import 'package:simple_music_app/view_model/track_view_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchType = "ARTIST";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    return Consumer<ArtistViewModel>(
        builder: (context, artistViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Search page'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withAlpha(50),
                       borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal,
                        ),
                        controller: _inputController,
                        onSubmitted: (keyWord) {
                          if (keyWord.isNotEmpty) {
                            callAPI(keyWord);
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText:
                              'Enter keyword',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: DropdownButton<String>(
                      value: _searchType,
                      elevation: 16,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _searchType = newValue!;
                        });
                      },
                      items: <String>['ARTIST', 'ALBUM', 'TRACK']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            switchResultList(),
          ],
        ),
      );
    });
  }

  void callAPI(String keyWord) {
    switch (_searchType) {
      case 'ARTIST':
        {
          Provider.of<ArtistViewModel>(context, listen: false)
              .fetchArtistData(keyWord);
        }
        break;
      case 'ALBUM':
        {
          Provider.of<AlbumViewModel>(context, listen: false)
              .fetchAlbumData(keyWord);
        }
        break;
      case 'TRACK':
        {
          Provider.of<TrackViewModel>(context, listen: false)
              .fetchTrackData(keyWord);
        }
        break;
    }
  }

  Widget switchResultList() {
    switch (_searchType) {
      case 'ARTIST':
        {
          return ArtistList();
        }
      case 'ALBUM':
        {
          return AlbumList();
        }
      case 'TRACK':
        {
          return TrackList();
        }
    }
    return const Text('Search for something');
  }
}
