class Beer {
  //final String? id;
  final String? name;
  final String? breweryName;
  //final double? alcoholPercentage;
  final String? image;

  Beer(
      { //this.id,
      this.name,
      this.breweryName,
      //this.alcoholPercentage,
      this.image});


  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      //id: json['id'] as String?,
      name: json['name'] as String?,
      breweryName: json['breweryName'] as String?,
      //alcoholPercentage: json['alcoholPercentage'] as double?,
      image: json['image'] as String?,
    );
  }
}
