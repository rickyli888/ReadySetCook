class Ingredient {
  String id;
  String name;
  String quantity;
  String unit;
  DateTime startDate;
  int shelfLife;
  String imageUrl;

  Ingredient(
      {this.id,
      this.name,
      this.quantity,
      this.unit,
      this.startDate,
      this.shelfLife,
      this.imageUrl});
}
