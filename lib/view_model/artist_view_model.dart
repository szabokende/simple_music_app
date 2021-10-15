import 'package:flutter/cupertino.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/artist.dart';
import 'package:simple_music_app/model/repositories/artist_repository.dart';

class ArtistViewModel with ChangeNotifier {
  //This class exposes the response from the API as an Artist list
  ApiResponse _apiResponse = ApiResponse.initial('initial state');

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> fetchArtistData(String keyWord) async {
    try {
      List<Artist> artistList = await ArtistRepository().fetchArtistList(keyWord);
      _apiResponse = ApiResponse.completed(artistList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}