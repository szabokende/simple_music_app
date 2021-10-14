import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/artist.dart';
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
/*
  Widget getArtistListWidget(
    BuildContext context,
    ApiResponse apiResponse,
    String listTitle,
    FaIcon icon,
  ) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
      case Status.COMPLETED:
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(listTitle),
                    ),
                    icon
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                Expanded(
                  child: ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: apiResponse.data.length,
                    itemBuilder: (context, index) {
                      if (apiResponse.data[index].name != null)
                        return ListTile(
                          title: Text(apiResponse.data[index].name),
                        );
                      else {
                        return Text("No Artist");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      case Status.ERROR:
        return Center(
          child: Text('Please try again later!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the song by Artist'),
        );
    }
  }

 */

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

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    // ApiResponse apiResponse = Provider.of<ArtistViewModel>(context).response;
    // List<Artist> artistList = apiResponse.data as List<Artist>;
    double width = MediaQuery.of(context).size.width;
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
                          fontSize: 15.0,
                          color: Colors.grey,
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
                              'Enter Artist Name', //TODO switch for hint text
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: DropdownButton<String>(
                      value: _searchType,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
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
}
