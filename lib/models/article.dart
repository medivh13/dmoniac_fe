// File: lib/models/article.dart
class Article {
  final int id;
  final int userId;
  final String userName;
  final int stadium;
  final String createdAt;

  Article({
    required this.id,
    required this.userId,
    required this.userName,
    required this.stadium,
    required this.createdAt,
  });
}
