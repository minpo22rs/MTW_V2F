class ProductDelivery {
  String img;
  String namestore;
  int quantity;
  int price;
  ProductDelivery({
    required this.img,
    required this.namestore,
    required this.quantity,
    required this.price,
  });
}

List<ProductDelivery> productdelivery = [
  ProductDelivery(img: 'img', namestore: 'namestore', quantity: 1, price: 100),
  ProductDelivery(img: 'img', namestore: 'namestore', quantity: 1, price: 100),
  ProductDelivery(img: 'img', namestore: 'namestore', quantity: 1, price: 100),
  ProductDelivery(img: 'img', namestore: 'namestore', quantity: 1, price: 100),
];
