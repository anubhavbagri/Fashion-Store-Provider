import 'package:fashion_store/model/product.dart';
import 'package:fashion_store/provider/core/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final productFunctions = Provider.of<CartProvider>(context, listen: false);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.brown[50],
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Image.network(
                  product.image,
                  colorBlendMode: BlendMode.multiply,
                  color: Colors.brown[50],
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category!,
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 12),
                ),
                Text(
                  product.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${product.price}",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                    Consumer<Product>(
                      builder: ((context, value, child) => GestureDetector(
                            onTap: () {
                              print("~~~~~~~~ ${product.title}");
                              productFunctions.addTotalPrice(product.price);
                              productFunctions.addCounter();
                              productFunctions.addProduct(
                                product.id,
                                product.title,
                                product.price,
                                product.description,
                                product.image,
                              );
                            },
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 22,
                              color: Colors.grey[400],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
