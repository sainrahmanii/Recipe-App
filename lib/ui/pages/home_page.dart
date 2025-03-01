import 'package:flutter/material.dart';
import 'package:receipt_app/services/remote/remote_service.dart';
import 'package:receipt_app/ui/pages/detail_page.dart';
import 'package:receipt_app/ui/widgets/item_meal_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 0 ? 'List Seafood' : 'List Dessert',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_rounded),
            color: Colors.red,
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: RemoteService()
              .getMealsByCategory(currentIndex == 0 ? 'Seafood' : 'Dessert'),
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
            final listMeal = snapshot.data!.meals;
            return ListView.builder(
              itemCount: listMeal.length,
              itemBuilder: (BuildContext context, int index) {
                final itemMeal = listMeal[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: itemMeal.idMeal),
                      ),
                    );
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
