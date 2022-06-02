import 'package:fashion_store/provider/core/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    Key? key,
    required this.index,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  }) : super(key: key);
  final int index;
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    int count = Provider.of<CartProvider>(context).getCounter();
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
                    child: Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
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
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Size:  ",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    const Text(
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 0.3, color: Colors.black)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (count > 1) {
                                          count--;
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .subtractCounter();
                                        }
                                        if (count == 1) {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .del(widget.index);
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
                                    Container(
                                      width: 30,
                                      child: Center(
                                        child: Text(
                                          '',
                                          // "${widget.quantity}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        count++;
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .addCounter();
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
                            ),
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
