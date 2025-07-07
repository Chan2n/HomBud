import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double getTotalAmount() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void addToCart(double price, String serviceTitle) {
    _cartItems.add(CartItem(price: price, serviceTitle: serviceTitle));
    notifyListeners(); // This line notifies listeners about changes
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners(); // Notify listeners after removing an item
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // Notify listeners after clearing the cart
  }
}

class CartItem {
  final double price;
  final String serviceTitle;

  CartItem({required this.price, required this.serviceTitle});

  get index => null;
}

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Display the contents of the cart
              for (var item in cart.cartItems)
                _buildCartItem(context, cart, cart.cartItems.indexOf(item)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartModel cartModel, int index) {
    final item = cartModel.cartItems[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${index + 1}: ${item.serviceTitle} (₱${item.price.toStringAsFixed(2)})',
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                // Decrease the quantity of the item
                cartModel.removeFromCart(index);
              },
            ),
            Text(
              '${_getItemCount(item.serviceTitle, cartModel.cartItems)}',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Increase the quantity of the item
                cartModel.addToCart(item.price, item.serviceTitle);
              },
            ),
          ],
        ),
      ],
    );
  }

  int _getItemCount(String serviceTitle, List<CartItem> cartItems) {
    return cartItems.where((item) => item.serviceTitle == serviceTitle).length;
  }
}
