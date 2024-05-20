import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:practica_2/model/product_model.dart';
import 'package:practica_2/service/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialValues();
  }

  _getInitialValues() async {
    products = await ProductService().getMyProductList();
    setState(() {
      products;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CupertinoSearchTextField(),
        actions: const [
          IconAppBar(icon: Icons.notifications),
          IconAppBar(icon: Icons.shopping_bag_rounded)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const BannerWidget(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Shop by Category",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, ind) {
                    return const BrandWidget();
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Midnight sales",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            products.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product preview = products[index];
                        return ItemWidget(item: preview);
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width * 0.5,
                          childAspectRatio: 1.5 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.item,
  });
  final Product item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.25,
      width: size.width * 0.425,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.1))),
      child: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              Image.network(
                item.image,
                fit: BoxFit.fitWidth,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  item.discount
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red.withOpacity(0.2)),
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            "-30%",
                            style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          )),
          Container(
            height: size.height * 0.08,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.brand,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name),
                    Text(
                      "S/.${item.price}",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BrandWidget extends StatelessWidget {
  const BrandWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Image.asset("assets/brand.jpg"),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(
            "assets/banner.jpg",
            height: size.height * 0.2,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: size.height * 0.2,
            width: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
          const Positioned(
              top: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New summer collection \n23 collections",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "Find the brand new collection",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
          Positioned(
              bottom: 5,
              left: 10,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Comprar ahora")))
        ],
      ),
    );
  }
}

class IconAppBar extends StatelessWidget {
  const IconAppBar({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.grey.withOpacity(0.5)),
      child: Icon(icon),
    );
  }
}
