class PostModel{
  String? category;
  String? language;
  String? genre;
  String? sort;
  PostModel({
    this.category,
    this.language,
    this.genre,
    this.sort,
  });
  Map<String,dynamic> toJson(){
    return {
      'category':category,
      'language':language,
      'genre':genre,
      'sort':sort,
    };
  }
}