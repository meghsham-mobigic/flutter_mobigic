import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;
  static const Color white = Colors.white;
}

class MaterialIconsAppRoot extends StatefulWidget {
  const MaterialIconsAppRoot({super.key});

  @override
  State<MaterialIconsAppRoot> createState() => _MaterialIconsAppRootState();
}

class _MaterialIconsAppRootState extends State<MaterialIconsAppRoot> {
  String selectedIcon = 'Home';
  String selectedColor = 'Colors 1 : Black';

  final Map<String, Color> colorsMap = {
    'Colors 1 : Black': AppColors.black,
    'Colors 2 : Red': AppColors.red,
    'Colors 3 : Blue': AppColors.blue,
    'Colors 4 : Green': AppColors.green,
    'Colors 5 : White': AppColors.white,
  };

  final Map<String, IconData> iconMap = {
    'Home': Icons.home,
    'Search': Icons.search,
    'Favorite': Icons.favorite,
    'Star': Icons.star,
    'Shopping Cart': Icons.shopping_cart,
    'Menu': Icons.menu,
    'Arrow Back': Icons.arrow_back,
    'Settings': Icons.settings,
    'Notifications': Icons.notifications,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Icon and Color')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedIcon,
              items: iconMap.keys
                  .map(
                    (icon) => DropdownMenuItem(value: icon, child: Text(icon)),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Icon',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedIcon = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedColor,
              items: colorsMap.keys
                  .map(
                    (color) =>
                        DropdownMenuItem(value: color, child: Text(color)),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Show Icon'),
            ),
            const SizedBox(height: 20),

            Icon(
              iconMap[selectedIcon],
              color: colorsMap[selectedColor],
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
