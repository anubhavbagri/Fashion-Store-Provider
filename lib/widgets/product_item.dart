import 'package:fashion_store/model/product.dart';
import 'package:fashion_store/provider/core/cart_provider.dart';
import 'package:fashion_store/provider/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// individual product item that is present on the home screen
class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('product_title');
    await prefs.clear();
  }

  @override
  void initState() {
    clearPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (prefs.getString('product_title') !=
                                  product.title) {
                                productFunctions.addProduct(
                                  product.id,
                                  1,
                                  product.title,
                                  product.price,
                                  product.description,
                                  product.image,
                                );
                                productFunctions.addTotalPrice(product.price);
                              } else {
                                var snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Row(
                                      children: [
                                        const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.safeHorizontal! * .02,
                                        ),
                                        const Text(
                                            'Product is already added to cart!'),
                                      ],
                                    ),
                                    duration: Duration(seconds: 2));
                                if (!mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              prefs.setString('product_title', product.title);
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
