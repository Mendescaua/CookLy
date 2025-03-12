class Food {
  String name;
  String image;
  double cal;
  double time;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen ",
    image: "assets/images/ramen-noodles.jpg",
    cal: 120,
    time: 15,
    isLiked: false,
  ),
  Food(
    name: "Beef Steak",
    image: "assets/images/beaf-steak.jpg",
    cal: 140,
    time: 25,
    isLiked: true,
  ),
  Food(
    name: "Butter Chicken",
    image: "assets/images/butter-chicken.jpg",
    cal: 130,
    time: 18,
    isLiked: false,
  ),
  Food(
    name: "French Toast",
    image: "assets/images/french-toast.jpg",
    cal: 110,
    time: 16,
    isLiked: true,
  ),
  Food(
    name: "Dumplings",
    image: "assets/images/dumplings.jpg",
    cal: 150,
    time: 30,
    isLiked: false,
  ),
  Food(
    name: "Mexican Pizza",
    image: "assets/images/mexican-pizza.jpg",
    cal: 140,
    time: 25,
    isLiked: false,
  ),
];