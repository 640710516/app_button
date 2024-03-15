// POJO (Plain Old Java Object)
class Cartoons {
  final String? title;
  final int? year;
  final List<dynamic>? creator;
  final String? rateting;
  final List<dynamic>? genre;
  final int? runtime_in_minutes;
  final int? episodes;
  final String? image;
  final int? id;

  Cartoons({
    required this.title,
    required this.year,
    required this.creator,
    required this.rateting,
    required this.genre,
    required this.runtime_in_minutes,
    required this.episodes,
    required this.image,
    required this.id,
  });

  factory Cartoons.fromJson(Map<String, dynamic> json) {
    return Cartoons(
      title: json['title'],
      year: json['year'],
      creator: json['creator'],
      rateting: json['rateting'],
      genre: json['genre'],
      runtime_in_minutes: json['runtime_in_minutes'],
      episodes: json['episodes'],
      image: json['image'],
      id: json['id'],
    );
  }
}