import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({
    required this.aspectRatio,
    required this.label,
    super.key,
  });

  final double aspectRatio;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aspect Ratio: $label')),
      body: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/stock_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
