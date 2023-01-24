class ProductReceive {
  String img;
  String namestore;
  int quantity;
  int price;
  ProductReceive({
    required this.img,
    required this.namestore,
    required this.quantity,
    required this.price,
  });
}

List<ProductReceive> productreceive = [
  ProductReceive(img: 'img', namestore: 'namestore', quantity: 1, price: 200),
  ProductReceive(img: 'img', namestore: 'namestore', quantity: 1, price: 200),
  ProductReceive(img: 'img', namestore: 'namestore', quantity: 1, price: 200),
  ProductReceive(img: 'img', namestore: 'namestore', quantity: 1, price: 200),
];
