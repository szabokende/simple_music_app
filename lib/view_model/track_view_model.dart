import 'package:flutter/cupertino.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/track.dart';
import 'package:simple_music_app/model/repositories/track_repository.dart';

class TrackViewModel with ChangeNotifier {
  //This class exposes the response from the API as an Track list
  ApiResponse _apiResponse = ApiResponse.initial('initial state');

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> fetchTrackData(String keyWord) async {
    try {
      List<Track> trackList = await TrackRepository().fetchTrackList(keyWord);
      _apiResponse = ApiResponse.completed(trackList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}