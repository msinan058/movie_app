import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';

class PhotoUploadArea extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;
  final bool isLoading;

  const PhotoUploadArea({
    super.key,
    this.selectedImage,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSurface.withAlpha((0.1 * 255).round()),
            width: 2,
          ),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              )
            : selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 48,
                        color: theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        localizations.translate('tapToSelectPhoto'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'JPG, PNG or GIF',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha((0.5 * 255).round()),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
} 