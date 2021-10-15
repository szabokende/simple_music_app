
import 'package:simple_music_app/model/models/album.dart';
import 'package:simple_music_app/model/services/service.dart';
// ignore: library_prefixes
import 'package:simple_music_app/utils/constants.dart' as Constants;

// This class makes a request to the last.fm API using the service class and then converts the API response json into an album list
class AlbumRepository {
  final Service _service = Service();

  Future<List<Album>> fetchAlbumList(String keyWord) async {
    Uri uri = Uri.http(
      Constants.API_AUTHORITY,
      "/2.0/",
      {
        "method": "album.search",
        "album": keyWord,
        "api_key": Constants.API_KEY,
        "format": "json"
      },
    );
    dynamic response = await _service.get(uri);
    final jsonData = response['results']['albummatches']['album'] as List;
    List<Album> albumList = jsonData.map((tagJson) => Album.fromJson(tagJson)).toList();
    return albumList;
  }
}