import 'package:cloud_firestore/cloud_firestore.dart';

class fBeer {
  //final String? id;
  final String? name;
  final int? price;
  //final double? alcoholPercentage;
  final String? image;

  fBeer(
      { //this.id,
      this.name,
      this.price,
      //this.alcoholPercentage,
      this.image});


  factory fBeer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return fBeer(
      name: data?['name'],
      price: data?['price'],
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "state": price,
      if (image != null) "country": image,
    };
  }
}
