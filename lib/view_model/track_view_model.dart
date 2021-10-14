import 'package:flutter/cupertino.dart';
import 'package:simple_music_app/model/apis/api_response.dart';
import 'package:simple_music_app/model/models/track.dart';
import 'package:simple_music_app/model/repositories/track_repository.dart';

class TrackViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('initial state');

  Track? _track;

  ApiResponse get response {
    return _apiResponse;
  }

  Track? get track {
    return _track;
  }

  /// Call the  service and gets the data of requested track
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