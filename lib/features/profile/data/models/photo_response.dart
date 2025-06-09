import 'package:equatable/equatable.dart';

class PhotoUploadResponse extends Equatable {
  final String photoUrl;

  const PhotoUploadResponse({
    required this.photoUrl,
  });

  factory PhotoUploadResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null || data['photoUrl'] == null) {
      throw Exception('photoUrl is missing in the response');
    }

    return PhotoUploadResponse(
      photoUrl: data['photoUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object?> get props => [photoUrl];
} 