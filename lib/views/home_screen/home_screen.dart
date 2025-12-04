import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:yummygo/controllers/authentication_controller.dart';
import 'package:yummygo/controllers/cart_controller.dart';
import 'package:yummygo/controllers/menu_controller.dart';
import 'package:yummygo/models/dish_model.dart';
import 'package:yummygo/views/authentication_screen/authentication_screen.dart';
import 'package:yummygo/views/checkout_screen/checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentpage = 0;
  List imageUrl = [
    'assets/images/banner1.png',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<MenuControllerprovider>(context, listen: false).fetchMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationController>(context);
    final menu = Provider.of<MenuControllerprovider>(context);
    final cart = Provider.of<CartProvider>(context);

    return DefaultTabController(
      length: menu.categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: _buildDrawer(auth),
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logotext.png',
            width: 130,
            height: 130,
          ),
          backgroundColor: Colors.white,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (_, animation, _) => FadeTransition(
                          opacity: animation,
                          child: CheckoutScreen(),
                        ),
                      ),
                    );
                  },
                ),
                if (cart.totalItems > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.totalItems.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10),
          ],

          //TabBar section
          bottom: menu.isLoading
              ? null
              : TabBar(
                  indicatorColor: Colors.redAccent,
                  labelStyle: TextStyle(color: Colors.black),
                  unselectedLabelColor: Colors.black54,
                  isScrollable: true,
                  tabs: menu.categories
                      .map((cat) => Tab(text: cat.name))
                      .toList(),
                ),
        ),

        body: menu.isLoading
            ? const Center(child: CircularProgressIndicator())
            : menu.error != null
            ? Center(
                child: Text(
                  menu.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : Column(
                children: [
                  SizedBox(height: 10),
                  //CarouselSlider
                  carouselSlider(),
                  SizedBox(height: 10),
                  //Disehs
                  Expanded(
                    child: TabBarView(
                      children: List.generate(menu.categories.length, (index) {
                        final dishes = menu.getDishesByCategory(index);

                        return ListView.builder(
                          itemCount: dishes.length,
                          itemBuilder: (context, i) {
                            return DishTile(dish: dishes[i]);
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: BottomCartBar(cart, context),
      ),
    );
  }

  Widget carouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 189,
        // aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          currentpage = index;
          setState(() {});
        },
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(
        imageUrl.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(AuthenticationController auth) {
    final user = auth.user;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/userbar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(user?.displayName ?? "User"),
            accountEmail: Text(user?.email ?? "No email"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('${user?.photoUrl}'),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: Text("UID: ${user?.id ?? ""}"),
          ),

          Center(
            child: ListTile(
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ),
              ),
              onTap: () async => auth.logout().then(
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticationScreen(),
                  ),
                  (route) => true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DishTile extends StatelessWidget {
  final DishModel dish;

  const DishTile({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final quantity = cart.cartItems[dish.id]?.quantity ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              spreadRadius: .1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(dish.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 10,
                children: [
                  Text(
                    dish.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '₹ ${dish.price}',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: .bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      dish.isVeg
                          ? Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: .circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.green),
                              ),
                              child: Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 13,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: .circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.redAccent),
                              ),
                              child: Icon(
                                Icons.circle,
                                color: Colors.redAccent,
                                size: 13,
                              ),
                            ),
                    ],
                  ),
                  Text(
                    dish.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: .normal,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Calories: ${dish.calories} cal",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: .w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      dish.customizationsAvailable
                          ? Text(
                              "Customization Available",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: .w600,
                                color: Colors.redAccent,
                              ),
                            )
                          : SizedBox(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () => cart.removeFromCart(dish),
                            ),

                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () => cart.addToCart(dish),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BottomCartBar(CartProvider cart, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, animation, _) =>
              FadeTransition(opacity: animation, child: CheckoutScreen()),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/userbar.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Go to Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 20,
              ),
            ),

            Text(
              "₹ ${cart.totalPrice}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
