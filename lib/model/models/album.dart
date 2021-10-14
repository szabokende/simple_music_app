class Album {
  final String? name;
  final String? artist;
  final String? url;

  Album({
    this.name,
    this.artist,
    this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'] as String?,
      artist: json['artist'] as String?,
      url: json['url'] as String?,
    );
  }
}