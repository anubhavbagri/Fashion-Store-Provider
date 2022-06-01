import 'package:badges/badges.dart';
import 'package:fashion_store/services/products.dart';
import 'package:fashion_store/services/size_config.dart';
import 'package:fashion_store/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeHorizontal! * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.safeVertical! * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: SizeConfig.safeVertical! * 0.003,
                              width: SizeConfig.safeHorizontal! * 0.05,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: SizeConfig.safeVertical! * 0.008,
                            ),
                            Container(
                              height: SizeConfig.safeVertical! * 0.003,
                              width: SizeConfig.safeHorizontal! * 0.025,
                              color: Colors.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.search,
                          size: 25,
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeVertical! * 0.04,
                    ),
                    Text(
                      "New Arrivals",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeVertical! * 0.02,
                    ),
                    const Expanded(
                      child: ProductsGrid(),
                    ),
                  ],
                ),
              ),
              BottomNavBar(width: SizeConfig.safeHorizontal!)
            ],
          ),
        ));
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: width,
      height: SizeConfig.safeVertical! * 0.14,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 110,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.home_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Home")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, CartScreen.routeName);
                },
                child: Container(
                  height: 45,
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Badge(
                          badgeContent: Text(
                            '0',
                            style: TextStyle(color: Colors.white),
                          ),
                          badgeColor: Colors.black,
                          animationType: BadgeAnimationType.fade,
                          animationDuration: Duration(milliseconds: 300),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future _productsFuture;
  @override
  void initState() {
    _productsFuture =
        Provider.of<Products>(context, listen: false).fetchAndSaveProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productsFuture,
      builder: (ctx, snapshotData) {
        if (snapshotData.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else {
          if (snapshotData.error != null) {
            return const Center(
              child: Text("An error occured!"),
            );
          } else {
            final productsData = Provider.of<Products>(context);
            final products = productsData.items;
            return Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.safeHorizontal! * 0.28,
              ),
              child: GridView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.only(bottom: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1.6),
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: products[index],
                    child: const ProductItem(),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
