import 'package:flutter/material.dart';
import 'package:receipt_app/services/local/local_service.dart';
import 'package:receipt_app/ui/pages/detail_page.dart';
import 'package:receipt_app/ui/widgets/item_meal_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 0 ? "Your Favorite Seafood" : "Your Favorite Dessert",
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: LocalService()
              .getAllFavByCategory(currentIndex == 0 ? 'Seafood' : 'Dessert'),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            // Error
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            // Success
            final listMeal = snapshot.data!;
            return ListView.builder(
              itemCount: listMeal.length,
              itemBuilder: (BuildContext context, int index) {
                final itemMeal = listMeal[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: itemMeal.idMeal),
                      ),
                    );
                    setState(() {});
                  },
                  child: ItemMealWidgets(meal: itemMeal),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Seafood'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Dessert'),
        ],
      ),
    );
  }
}
