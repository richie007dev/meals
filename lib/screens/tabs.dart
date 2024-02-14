import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  void _selectScreen(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _showMessage(message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _toggleMealFavorite(Meal meal) {
    var isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showMessage("Meal is no longer a favorite.", Colors.redAccent);
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showMessage("Marked as a favorite.", Colors.greenAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavorite,
    );
    var screenTitle = "Categories";
    if (_selectPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavorite,
      );
      screenTitle = "Your Favorite";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
        ],
      ),
    );
  }
}
