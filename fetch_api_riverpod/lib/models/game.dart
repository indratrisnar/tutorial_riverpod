class Game {
  final int? id;
  final String? title;
  final String? thumbnail;
  final String? shortDescription;
  final String? gameUrl;
  final String? genre;
  final String? platform;
  final String? publisher;
  final String? developer;
  final DateTime? releaseDate;
  final String? freetogameProfileUrl;
  final bool isSaved;

  Game({
    this.id,
    this.title,
    this.thumbnail,
    this.shortDescription,
    this.gameUrl,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.releaseDate,
    this.freetogameProfileUrl,
    this.isSaved = false,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
      };

  Game copyWith({
    int? id,
    String? title,
    String? thumbnail,
    String? shortDescription,
    String? gameUrl,
    String? genre,
    String? platform,
    String? publisher,
    String? developer,
    DateTime? releaseDate,
    String? freetogameProfileUrl,
    bool? isSaved,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      shortDescription: shortDescription ?? this.shortDescription,
      gameUrl: gameUrl ?? this.gameUrl,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      publisher: publisher ?? this.publisher,
      developer: developer ?? this.developer,
      releaseDate: releaseDate ?? this.releaseDate,
      freetogameProfileUrl: freetogameProfileUrl ?? this.freetogameProfileUrl,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
