import 'package:flutter/material.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

class DetailAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Restaurant Detail",
        style: RestaurantTextStyles.headlineSmall.copyWith(
          color: RestaurantColors.onPrimary.color,
        ),
      ),
    );
  }
}
