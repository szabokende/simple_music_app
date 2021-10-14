import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/view_model/artist_view_model.dart';

class ArtistList extends StatelessWidget {
  Widget buildArtistListWidget(
    BuildContext context,
    ApiResponse apiResponse,
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
                      child: Text("Artists"),
                    ),
                    FaIcon(FontAwesomeIcons.user)
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
                      if (apiResponse.data[index].name != null) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/artistDetailPage', arguments: {'artist': apiResponse.data[index]} ),
                          child: ListTile(
                            title: Text(apiResponse.data[index].name),
                          ),
                        );
                      } else {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistViewModel>(
        builder: (context, artistViewModel, child) {
      return Container(
        child: buildArtistListWidget(
          context,
          artistViewModel.response,
        ),
      );
    });
  }
}
