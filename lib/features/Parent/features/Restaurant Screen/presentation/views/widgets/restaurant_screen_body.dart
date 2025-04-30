
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/styles.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class RestaurantScreenBody extends StatefulWidget {
  const RestaurantScreenBody({super.key});

  @override
  RestaurantScreenBodyState createState() => RestaurantScreenBodyState();
}

class RestaurantScreenBodyState extends State<RestaurantScreenBody> {
  final TextEditingController _searchController = TextEditingController();

  final List<Meal> meals = [
    Meal(
      name: 'Truffle Mushroom Risotto',
      description:
          'Creamy arborio rice with wild mushrooms and black truffle essence',
      imageUrl: mealImage,
      price: 24.99,
      calories: 450,
      preparationTime: 25,
      ingredients: [
        'Arborio rice',
        'Wild mushrooms',
        'Black truffle',
        'Parmesan',
        'Herbs'
      ],
      rating: 4.8,
    ),
    Meal(
      name: 'Grilled Salmon Niçoise',
      description:
          'Fresh Atlantic salmon with olive tapenade and herb vinaigrette',
      imageUrl: mealImage,
      price: 28.50,
      calories: 380,
      preparationTime: 20,
      ingredients: [
        'Atlantic salmon',
        'Olive tapenade',
        'Mixed greens',
        'Herb vinaigrette'
      ],
      rating: 4.5,
    ),
    Meal(
      name: 'Mediterranean Vegetable Tagine',
      description:
          'Slow-cooked seasonal vegetables with saffron and aromatic spices',
      imageUrl: mealImage,
      price: 22.75,
      calories: 320,
      preparationTime: 30,
      ingredients: [
        'Seasonal vegetables',
        'Saffron',
        'Moroccan spices',
        'Couscous'
      ],
      rating: 4.7,
    ),
    Meal(
      name: 'Seafood Paella',
      description: 'Spanish-style rice with mixed seafood and saffron',
      imageUrl: mealImage,
      price: 32.50,
      calories: 520,
      preparationTime: 35,
      ingredients: ['Bomba rice', 'Shrimp', 'Mussels', 'Calamari', 'Saffron'],
      rating: 4.9,
    ),
    Meal(
      name: 'Vegan Buddha Bowl',
      description:
          'Colorful mix of roasted vegetables, quinoa, and tahini dressing',
      imageUrl: mealImage,
      price: 19.99,
      calories: 400,
      preparationTime: 20,
      ingredients: [
        'Quinoa',
        'Roasted vegetables',
        'Tahini',
        'Mixed seeds',
        'Herbs'
      ],
      rating: 4.6,
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: header(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    return MealCard(meal: meals[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container header() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ourMainColor,
            ourMainColor.withValues(alpha: 0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withValues(alpha:  0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcoming Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Discover ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withValues( alpha: 0.3),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: 'Delicious Meals',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade300,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withValues(alpha:  0.3),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Culinary masterpieces crafted with passion and precision',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha:  0.8),
            ),
          ),
          const SizedBox(height: 20),
          // Search Bar (filter functionality is disabled)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:  0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for meals...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue.shade700,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEnhancedMealDetails(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ourMainColor.withValues(alpha: 0.1),
          boxShadow: [
            BoxShadow(
              color: ourMainColor.withValues(alpha:  0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Avatar Image
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(meal.imageUrl),
                backgroundColor: Colors.blue.shade200,
              ),
              // Meal Details
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      meal.name,
                      textAlign: TextAlign.center,
                      style: mainText14 ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ourMainColor .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '\$${meal.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEnhancedMealDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                firstGradientColor,
                secondGradientColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: ListView(
            controller: controller,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 120,
                      backgroundImage: AssetImage(meal.imageUrl),
                      // backgroundColor: Colors.blue.shade200,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      meal.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      meal.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: meal.ingredients
                          .map((ingredient) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  ingredient,
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.local_fire_department,
                                  color: Colors.red, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                '${meal.calories} Cal',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha:  0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.attach_money,
                                  color: Colors.green, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                '\$${meal.price.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // New container for preparation time
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha:  0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.orange, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                '${meal.preparationTime} min',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${meal.name} to cart!'),
                            backgroundColor: Colors.blue[900],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[900],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Meal {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int calories;
  final int preparationTime;
  final List<String> ingredients;
  final double rating;

  Meal({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.calories,
    required this.preparationTime,
    required this.ingredients,
    required this.rating,
  });
}
