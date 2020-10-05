import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Pages/ItemPage.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    Future<List<QueryDocumentSnapshot>> _getDocs() async {
      var snap = (await FirebaseFirestore.instance
              .collection("products")
              .where(
                'title',
                isGreaterThanOrEqualTo: query,
                isLessThanOrEqualTo: query.substring(0, query.length - 1) +
                    String.fromCharCode(
                        query.codeUnitAt(query.length.toInt() - 1) + 1),
              )
              .get())
          .docs;
      print(snap);
      return snap;
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using

    return SafeArea(
      child: FutureBuilder(
        future: _getDocs(),
        builder:
            (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (!snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                "No Results Found.",
              ),
            );
          } else {
            var results = snapshot.data;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var product = Product.fromSnapshot(results[index]);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(
                          product: product,
                          isAdmin: true,
                        ),
                      ),
                    );
                  },
                  title: Text(product.title),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
