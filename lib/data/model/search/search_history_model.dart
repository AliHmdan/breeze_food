class SearchHistoryModel {
  final int id;
  final int userId;
  final String query;
  final String searchedAt;
  final String? deletedAt;

  SearchHistoryModel({
    required this.id,
    required this.userId,
    required this.query,
    required this.searchedAt,
    this.deletedAt,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'],
      userId: json['user_id'],
      query: json['query'],
      searchedAt: json['searched_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "query": query,
    "searched_at": searchedAt,
    "deleted_at": deletedAt,
  };
}