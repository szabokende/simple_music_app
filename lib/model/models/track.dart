class Track {
  final String? name;
  final String? listeners;
  final String? artist;
  final String? url;

  Track({
    this.name,
    this.listeners,
    this.artist,
    this.url,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'] as String?,
      listeners: json['listeners'] as String?,
      artist: json['artist'] as String?,
      url: json['url'] as String?,
    );
  }
}