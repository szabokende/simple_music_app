
import 'package:simple_music_app/model/models/artist.dart';
import 'package:simple_music_app/model/services/service.dart';
// ignore: library_prefixes
import 'package:simple_music_app/utils/constants.dart' as Constants;

// This class makes a request to the last.fm API using the service class and then converts the API response json into an artist list
class ArtistRepository {
  final Service _service = Service();

  Future<List<Artist>> fetchArtistList(String keyWord) async {
    Uri uri = Uri.http(
      Constants.API_AUTHORITY,
      "/2.0/",
      {
        "method": "artist.search",
        "artist": keyWord,
        "api_key": Constants.API_KEY,
        "format": "json"
      },
    );
    dynamic response = await _service.get(uri);
    final jsonData = response['results']['artistmatches']['artist'] as List;
    List<Artist> artistList = jsonData.map((tagJson) => Artist.fromJson(tagJson)).toList();
    return artistList;
  }
}