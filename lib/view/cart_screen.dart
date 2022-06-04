import 'package:fashion_store/provider/core/cart_provider.dart';
import 'package:fashion_store/widgets/cart_item.dart';
import 'package:fashion_store/widgets/payment_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                const Text(
                  "Your Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ],
            ),
            Provider.of<CartProvider>(context).getCounter() > 0
                ? Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          child: CartItemsList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "\$${Provider.of<CartProvider>(context).getTotalPrice().round()}",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const PaymentButton(),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage('images/empty_cart.png'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Your cart is empty!',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Start shopping now!',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400],
                                  ),
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

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Consumer<CartProvider>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: screenSize.height,
            width: double.infinity,
            child: ListView.builder(
              itemCount: value.list.length,
              itemBuilder: ((context, index) => CartItemWidget(
                    index: index,
                    id: value.list[index].id,
                    quantity: value.list[index].quantity,
                    title: value.list[index].title,
                    price: value.list[index].price,
                    image: value.list[index].image,
                    description: value.list[index].description,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
