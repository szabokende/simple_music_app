class Artist {
  final String? name;
  final String? listeners;
  final String? url;

  Artist({
    this.name,
    this.listeners,
    this.url,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'] as String?,
      listeners: json['listeners'] as String?,
      url: json['url'] as String?,
    );
  }
}
