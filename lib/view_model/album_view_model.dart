import 'package:flutter/cupertino.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/album.dart';
import 'package:simple_music_app/model/repositories/album_repository.dart';

class AlbumViewModel with ChangeNotifier {
  //This class exposes the response from the API as an Album list
  ApiResponse _apiResponse = ApiResponse.initial('initial state');

  ApiResponse get response {
    return _apiResponse;
  }

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