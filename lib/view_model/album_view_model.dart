import 'package:flutter/cupertino.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/album.dart';

import 'package:simple_music_app/model/repositories/album_repository.dart';

class AlbumViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('initial state');

  Album? _album;

  ApiResponse get response {
    return _apiResponse;
  }

  Album? get album {
    return _album;
  }

  /// Call the  service and gets the data of requested album data of
  /// an album.
  Future<void> fetchAlbumData(String keyWord) async {
    try {
      List<Album> albumList = await AlbumRepository().fetchAlbumList(keyWord);
      _apiResponse = ApiResponse.completed(albumList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}