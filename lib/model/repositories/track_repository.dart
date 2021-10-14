import 'package:simple_music_app/model/models/artist.dart';
import 'package:simple_music_app/model/models/track.dart';
import 'package:simple_music_app/model/services/service.dart';
import 'package:simple_music_app/utils/constants.dart' as Constants;

class TrackRepository {
  Service _service = Service();

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