class Category {
  String title;
  int id;

  Category(this.title, this.id);
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json["name"], json["id"]);
  }
}
