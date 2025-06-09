extension StringExtension on String {
  String get fixImageUrl {
    return replaceFirst('http://', 'https://')
        .replaceAll('..jpg', '.jpg');
  }
} 