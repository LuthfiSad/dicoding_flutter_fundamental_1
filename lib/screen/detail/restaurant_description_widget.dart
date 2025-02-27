import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/detail/restaurant_description_provider.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

class RestaurantDescriptionWidget extends StatelessWidget {
  final String description;

  const RestaurantDescriptionWidget({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDescriptionProvider(),
      child: Consumer<RestaurantDescriptionProvider>(
        builder: (_, provider, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: RestaurantTextStyles.bodyMedium,
                maxLines: provider.isExpanded ? 2 : 1000,
                overflow: TextOverflow.ellipsis,
              ),
              if (description.length > 100)
                GestureDetector(
                  onTap: provider.toggleExpanded,
                  child: Text(
                    provider.isExpanded ? 'Read more' : 'Read less',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
