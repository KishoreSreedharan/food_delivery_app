import 'package:flutter/material.dart';
import 'package:food_delivery/map.dart';
import 'colors.dart';
import 'kIcons.dart';
import 'drawerMenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> bannerCards = [
    "https://images.pexels.com/photos/2228559/pexels-photo-2228559.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3756498/pexels-photo-3756498.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3186654/pexels-photo-3186654.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ];

  double translateX = 0.0;
  double translateY = 0;
  double scale = 1;
  late AnimationController _animationController;

  bool toggle = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DrawerMenu(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(translateX, translateY, 0)
            ..scale(scale),
          child: ClipRRect(
            borderRadius:
                (toggle) ? BorderRadius.circular(20) : BorderRadius.circular(0),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_arrow,
                    progress: _animationController,
                    color: Colors.black,
                  ),
                  // icon: const Icon(Icons.menu, color: Colors.black,),
                  onPressed: () {
                    toggle = !toggle;
                    if (toggle) {
                      translateX = 200;
                      translateY = 80;
                      scale = 0.8;
                      _animationController.forward();
                    } else {
                      translateX = 0.0;
                      translateY = 0;
                      scale = 1;
                      _animationController.reverse();
                    }
                    setState(() {});
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivering to",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.black45),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MapLocation()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Current Location",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: primaryColor,
                            size: 30,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        SEARCH_ICON,
                                        height: 20,
                                        width: 20,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Search Foods",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              FILTER_ICON,
                              height: 25,
                              width: 25,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textStyle(context, "Category"),
                      Container(
                        height: 115,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: listCards.length,
                          itemBuilder: (context, index) => CategoryCard(
                            cardModel: listCards[index],
                          ),
                        ),
                      ),
                      textStyle(context, "Popular"),
                      for (int i = 0; i < bannerCards.length; i++) ...{
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(bannerCards[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Food Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: primaryColor,
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text("(125 ratings)"),
                                    Spacer(),
                                    Text("New Hotel"),
                                    Text("-\$5"),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      }
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget textStyle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.subtitle1?.copyWith(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
  );
}

class CategoryCard extends StatelessWidget {
  final CardModel cardModel;
  CategoryCard({
    required this.cardModel,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 5, bottom: 2, left: 8, right: 5),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(cardModel.imageUrl),
        ),
        Text(
          cardModel.title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        )
      ],
    );
  }
}

class CardModel {
  String imageUrl, title;
  CardModel({required this.imageUrl, required this.title});
}

List<CardModel> listCards = [
  CardModel(imageUrl: "assets/icons/price-tag.png", title: "Offers"),
  CardModel(imageUrl: "assets/icons/burger.png", title: "Burger"),
  CardModel(imageUrl: "assets/icons/drink.png", title: "Drink"),
  CardModel(imageUrl: "assets/icons/pizza.png", title: "Pizza"),
  CardModel(imageUrl: "assets/icons/ramen.png", title: "Noodle"),
];

class PopularCard {
  String hotelName;
  String foodName;
  double rating;
  int ratingCount;
  double amount;
  String imageUrl;
  PopularCard(this.hotelName, this.foodName, this.rating, this.ratingCount,
      this.amount, this.imageUrl);
}
