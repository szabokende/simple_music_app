import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/view_model/track_view_model.dart';

class TrackList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackViewModel>(builder: (context, trackViewModel, child) {
      return Container(
        child: buildTrackListWidget(
          context,
          trackViewModel.response,
        ),
      );
    });
  }

  Widget buildTrackListWidget(
    BuildContext context,
    ApiResponse apiResponse,
  ) {
    //Displays UI based on the apiResponse.status (CircularProgressIndicator/Content/Error message/ Initial welcome text)
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(
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
                      child: Text(
                        "Tracks",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const FaIcon(FontAwesomeIcons.music)
                  ],
                ),
                const Divider(
                  thickness: 3,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: apiResponse.data.length,
                    itemBuilder: (context, index) {
                      if (apiResponse.data[index].name != null) {
                        return GestureDetector(
                          //passing chosen Track object to TrackDetailPage
                          onTap: () => Navigator.pushNamed(
                              context, '/trackDetailPage',
                              arguments: {'track': apiResponse.data[index]}),
                          child: ListTile(
                            title: Text(apiResponse.data[index].name),
                          ),
                        );
                      } else {
                        return const Text("No tracks");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again later!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search a song by name'),
        );
    }
  }


}
