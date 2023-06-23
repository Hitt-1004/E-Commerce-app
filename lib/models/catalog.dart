import 'dart:convert';

class Item {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String color;
  final String image;

  Item(this.id, this.name, this.desc, this.price, this.color, this.image);

  Item copyWith({
    int? id,
    String? name,
    String? desc,
    int? price,
    String? color,
    String? image,
  }) {
    return Item(
      id ?? this.id,
      name ?? this.name,
      desc ?? this.desc,
      price ?? this.price,
      color ?? this.color,
      image ?? this.image,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      map["id"],
      map['name'],
      map['desc'],
      map["price"],
      map['color'],
      map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(dynamic source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.price == price &&
        other.color == color &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    desc.hashCode ^
    price.hashCode ^
    color.hashCode ^
    image.hashCode;
  }
}

class CatalogModel{
  // static final catalogModel = CatalogModel._internal();
  // CatalogModel._internal();
  // factory CatalogModel() => catalogModel;

  static List<Item>? products;
  //Get Item by ID
  Item getById(int id) =>
      products!.firstWhere((element) => element.id == id, orElse: null);

  //Get Item by Position
  Item getByPosition(int pos) => products![pos];
 //  = [Item(
 //    id: 1,
 //    name: "Iphone 12",
 //    desc: "Apple Iphone 12th generation",
 //    price: 62990,
 //    color: "#33505a",
 //    image: "https://static.toiimg.com/thumb/resizemode-4,msid-71446518,imgsize-200,width-1200/71446518.jpg",
 // )];
}