import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/main/index_nav_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/favorite/favorite_screen.dart';
import 'package:restaurant_flutter_dicoding/screen/home/home_screen.dart';
import 'package:restaurant_flutter_dicoding/screen/setting/setting_screen.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const FavoriteScreen(),
            _ => const SettingScreen()
          };
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Material(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.2),
          color: RestaurantColors.primary.color,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: RestaurantColors.surface.color,
            selectedItemColor: RestaurantColors.secondary.color,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
            onTap: (index) {
              context.read<IndexNavProvider>().setIndextBottomNavBar = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                tooltip: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
                tooltip: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
                tooltip: "Setting",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
