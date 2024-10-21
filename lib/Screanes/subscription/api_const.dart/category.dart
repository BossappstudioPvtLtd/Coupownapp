class Category {
  final int id;
  final String categoriesName;

  Category({required this.id, required this.categoriesName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoriesName: json['categoriesname'],
    );
  }
}
