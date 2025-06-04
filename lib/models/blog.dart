class Blogs {
  final int municipalityId;
  final String category;
  final String title;
  final String content;
  final int? moneyneeded;
  final int? volunteersneeded;
  final String? date;
  final String? time;
  final String? location;

  Blogs({
    required this.municipalityId,
    required this.category,
    required this.title,
    required this.content,
    this.moneyneeded,
    this.volunteersneeded,
    this.date,
    this.time,
    this.location,
  });

}