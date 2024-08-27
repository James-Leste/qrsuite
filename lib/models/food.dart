class Food {
  final String id;
  final String name;
  final double price;
  final String imagePath;

  Food(
      {required this.id,
      required this.name,
      required this.price,
      required this.imagePath});

  factory Food.fromFirestore(Map<String, dynamic> data) {
    return Food(
      id: data['food'],
      name: data['quantity'],
      price: data['price'],
      imagePath: data['imagePath'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }
}
