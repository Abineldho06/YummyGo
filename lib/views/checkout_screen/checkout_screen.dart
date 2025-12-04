import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yummygo/controllers/cart_controller.dart';
import 'package:yummygo/models/dish_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.red, fontWeight: .bold),
        ),
      ),

      body: _body(context),
    );
  }

  void _showSuccessDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Order Placed!",
          style: GoogleFonts.montserrat(color: Colors.black, fontWeight: .w600),
        ),
        content: Lottie.asset(
          'assets/images/Successful check.json',
          fit: BoxFit.fill,
          repeat: false,
        ),
        actions: [
          TextButton(
            onPressed: () {
              cart.clearCart();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _body(context) {
    final cart = Provider.of<CartProvider>(context);
    if (cart.cartItems == null || cart.cartItems.isEmpty) {
      return Center(
        child: Lottie.asset(
          'assets/images/Empty box by partho.json',
          width: 300,
          height: 300,
          fit: BoxFit.fill,
          repeat: false,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.cartItems.values.map((DishModel dish) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
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
                                    '₹ ${dish.price} x ${dish.quantity}',
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
                                            border: Border.all(
                                              color: Colors.green,
                                            ),
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
                                            border: Border.all(
                                              color: Colors.redAccent,
                                            ),
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
                                      color: const Color.fromARGB(
                                        255,
                                        196,
                                        13,
                                        0,
                                      ),
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
                                          onPressed: () =>
                                              cart.removeFromCart(dish),
                                        ),

                                        Text(
                                          dish.quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),

                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
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
              }).toList(),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, -1),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Total: INR ${cart.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    _showSuccessDialog(context, cart);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 170, 12, 1),
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
