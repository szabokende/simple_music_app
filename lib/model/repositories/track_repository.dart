
import 'package:simple_music_app/model/models/track.dart';
import 'package:simple_music_app/model/services/service.dart';
// ignore: library_prefixes
import 'package:simple_music_app/utils/constants.dart' as Constants;

// This class makes a request to the last.fm API using the service class and then converts the API response json into a track list
class TrackRepository {
  final Service _service = Service();

  Future<List<Track>> fetchTrackList(String keyWord) async {
    Uri uri = Uri.http(
      Constants.API_AUTHORITY,
      "/2.0/",
      {
        "method": "track.search",
        "track": keyWord,
        "api_key": Constants.API_KEY,
        "format": "json"
      },
    );
    dynamic response = await _service.get(uri);
    final jsonData = response['results']['trackmatches']['track'] as List;
    List<Track> trackList = jsonData.map((tagJson) => Track.fromJson(tagJson)).toList();
    return trackList;
  }
}