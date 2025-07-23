import 'package:flutter/material.dart';
import 'package:flutter_mobigic/images_in_ratio/image_preview_page.dart';
class AspectRatioInputPage extends StatefulWidget {
  const AspectRatioInputPage({super.key});

  @override
  State<AspectRatioInputPage> createState() => _AspectRatioInputPageState();
}

class _AspectRatioInputPageState extends State<AspectRatioInputPage> {
  String selectedRatio = '9:16';

  final Map<String, double> aspectRatioMap = {
    '9:16': 9 / 16,
    '1:1': 1.0,
    '16:9': 16 / 9,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Aspect Ratio')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedRatio,
              items: aspectRatioMap.keys
                  .map(
                    (ratio) =>
                        DropdownMenuItem(value: ratio, child: Text(ratio)),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Aspect Ratio',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedRatio = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => ImagePreviewPage(
                      aspectRatio: aspectRatioMap[selectedRatio]!,
                      label: selectedRatio,
                    ),
                  ),
                );
              },
              child: const Text('Show Image'),
            ),
          ],
        ),
      ),
    );
  }
}
