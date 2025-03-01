import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:receipt_app/models/meal.dart';
import 'package:receipt_app/models/response_meals.dart';
import 'package:receipt_app/services/remote/remote_service.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = false;
  late Meal meal;
  bool _isFavorited = false;

  void _getMeal() async {
    setState(() {
      _isLoading = true;
    });

    final response = await RemoteService().getDetailsMeal(widget.id);
    meal = response.meals.first;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorited = !_isFavorited;
              });
            },
            icon: Icon(
              _isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: InteractiveViewer(
                        panEnabled: false,
                        child: Center(
                          child: Hero(
                            tag: meal.idMeal,
                            child: Material(
                              child: CachedNetworkImage(
                                imageUrl: meal.strMealThumb,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(meal.strMeal),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text('Instruction'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text('${meal.strInstructions}'),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
