class ProductsModel {
  final category;
  final description;
  final id;
  final image;
  final price;
  final title;


  ProductsModel(
      {this.category,
        this.description,
        this.id,
        this.image,
        this.price,
        this.title});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['title'] = title;
    return data;
  }
}