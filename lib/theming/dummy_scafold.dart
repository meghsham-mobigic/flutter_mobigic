// import 'package:flutter/material.dart';

// // class MyApp extends StatefulWidget {
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   bool isDarkMode = false;
// //
// //   void toggleTheme() {
// //     setState(() {
// //       isDarkMode = !isDarkMode;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Theme Practice',
// //       theme: ThemeConfig.lightTheme,
// //       darkTheme: ThemeConfig.darkTheme,
// //       themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
// //       home: ThemePracticePage(onToggleTheme: toggleTheme),
// //     );
// //   }
// // }

// class ThemePracticePage extends StatelessWidget {
//   const ThemePracticePage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Theme Playground'),
//         actions: [
//           IconButton(icon: const Icon(Icons.brightness_6), onPressed: () {}),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Headline Text',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'This is some body text to test text theming.',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Elevated Button'),
//               ),
//             ),
//             TextButton(onPressed: () {}, child: const Text('Text Button')),
//             Center(
//               child: OutlinedButton(
//                 onPressed: () {},
//                 child:const  Text('Outlined Button'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Text Field',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SwitchListTile(
//               value: true,
//               onChanged: (_) {},
//               title: const Text('Switch Example'),
//             ),
//             CheckboxListTile(
//               value: false,
//               onChanged: (_) {},
//               title: const Text('Checkbox Example'),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 5,
//               itemBuilder: (_, index) => ListTile(
//                 leading: const Icon(Icons.star),
//                 title: Text('List Item ${index + 1}'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
