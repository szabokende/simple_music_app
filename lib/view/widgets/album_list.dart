import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/view_model/album_view_model.dart';
import 'package:simple_music_app/view_model/artist_view_model.dart';

class AlbumList extends StatelessWidget {
  Widget buildAlbumListWidget(
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
                      child: Text("Albums" ,style: Theme.of(context).textTheme.headline6,),
                    ),
                    FaIcon(FontAwesomeIcons.compactDisc)
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
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, '/albumDetailPage',
                              arguments: {'album': apiResponse.data[index]}),
                          child: ListTile(
                            title: Text(apiResponse.data[index].name),
                          ),
                        );
                      else {
                        return Text("No Albums");
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
          child: Text('Search album'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumViewModel>(builder: (context, albumViewModel, child) {
      return Container(
        child: buildAlbumListWidget(
          context,
          albumViewModel.response,
        ),
      );
    });
  }
}
