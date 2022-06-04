import 'package:fashion_store/provider/core/cart_provider.dart';
import 'package:fashion_store/provider/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// individual card item that's present on the cart screen
class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    Key? key,
    required this.index,
    required this.id,
    required this.quantity,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  }) : super(key: key);
  final int index;
  final int id;
  final int quantity;
  final String title;
  final double price;
  final String description;
  final String image;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int quantity = widget.quantity;
    final productFunctions = Provider.of<CartProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    color: Colors.brown[50],
                    margin: const EdgeInsets.only(right: 18),
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      widget.image,
                      color: Colors.brown[50],
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text(
                                  widget.title,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12.4,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6),
                                ),
                              ),
                              Text(
                                "\$ ${widget.price}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Size:  ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    'S',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Color:  ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 0.3, color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (quantity > 1) {
                                        quantity--;
                                        productFunctions
                                            .subtractQuantity(widget.index);
                                        productFunctions
                                            .subtractTotalPrice(widget.price);
                                      } else if (quantity == 1) {
                                        return dialogBox(context, widget.index,
                                            widget.price);
                                      }
                                    },
                                    child: Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(1)),
                                      child: const Center(child: Text("-")),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: Center(
                                      child: Text(
                                        '$quantity',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      quantity++;
                                      productFunctions
                                          .addQuantity(widget.index);
                                      productFunctions
                                          .addTotalPrice(widget.price);
                                    },
                                    child: Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(1)),
                                      child: const Center(child: Text("+")),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.4,
          color: Colors.grey[400],
        )
      ],
    );
  }
}

Future<void> dialogBox(BuildContext context, int index, double price) {
  return showDialog(
    barrierColor: Colors.black54,
    context: context,
    builder: (ctx) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      content: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Delete from Cart",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Are you sure you want to remove this item from cart?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .delete(index);
                      Provider.of<CartProvider>(context, listen: false)
                          .subtractTotalPrice(price);
                      Provider.of<CartProvider>(context, listen: false)
                          .subtractCounter();
                      Navigator.of(ctx).pop(true);
                    },
                    child: Container(
                      width: (double.infinity / 2),
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: const Center(
                        child: Text(
                          "REMOVE",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: Container(
                      width: (double.infinity / 2),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 9),
                      child: const Center(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
