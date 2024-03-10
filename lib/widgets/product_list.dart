import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/widgets/product_cart.dart';
import 'package:shopping_app/pages/producto_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Vans'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetailsPage(product: product);
                      },
                    ),
                  );
                },
                child: ProductCart(
                  title: product['title'] as String,
                  price: product['price'] as double,
                  image: product['imageUrl'] as String,
                  backgroundColor: index.isEven
                      ? const Color.fromRGBO(216, 240, 253, 1)
                      : const Color.fromRGBO(245, 247, 249, 1),
                ),
              );
            },
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: products.length,
          //     itemBuilder: ((context, index) {
          //       final product = products[index];
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return ProductDetailsPage(product: product);
          //               },
          //             ),
          //           );
          //         },
          //         child: ProductCart(
          //           title: product['title'] as String,
          //           price: product['price'] as double,
          //           image: product['imageUrl'] as String,
          //           backgroundColor: index.isEven
          //               ? const Color.fromRGBO(216, 240, 253, 1)
          //               : const Color.fromRGBO(245, 247, 249, 1),
          //         ),
          //       );
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}