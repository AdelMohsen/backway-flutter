import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Utility class for handling network media operations (images and videos)
class NetworkImageHelper {
  static final Dio _dio = Dio();

  /// Converts a list of network image URLs to a list of local File objects
  /// Downloads images to temporary directory and returns File objects
  static Future<List<File>?> convertUrlsToFiles(List<String> imageUrls) async {
    try {
      if (imageUrls.isEmpty) return null;

      final List<File> files = [];
      final Directory tempDir = await getTemporaryDirectory();
      
      // Create a subdirectory for downloaded images
      final Directory imageDir = Directory('${tempDir.path}/downloaded_images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      for (int i = 0; i < imageUrls.length; i++) {
        final String url = imageUrls[i];
        if (url.isEmpty) continue;

        try {
          // Download the image
          final Response<Uint8List> response = await _dio.get<Uint8List>(
            url,
            options: Options(
              responseType: ResponseType.bytes,
              followRedirects: true,
              validateStatus: (status) => status != null && status < 500,
            ),
          );

          if (response.data != null) {
            // Generate a unique filename
            final String extension = _getFileExtension(url);
            final String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}_$i$extension';
            final String filePath = path.join(imageDir.path, fileName);

            // Save the image to local file
            final File file = File(filePath);
            await file.writeAsBytes(response.data!);
            files.add(file);
          }
        } catch (e) {
          print('Error downloading image from $url: $e');
          // Continue with other images even if one fails
          continue;
        }
      }

      return files.isNotEmpty ? files : null;
    } catch (e) {
      print('Error converting URLs to files: $e');
      return null;
    }
  }

  /// Downloads a single network image URL to a local File object
  static Future<File?> convertUrlToFile(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) return null;

      final Directory tempDir = await getTemporaryDirectory();
      final Directory imageDir = Directory('${tempDir.path}/downloaded_images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      // Download the image
      final Response<Uint8List> response = await _dio.get<Uint8List>(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.data != null) {
        // Generate a unique filename
        final String extension = _getFileExtension(imageUrl);
        final String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}$extension';
        final String filePath = path.join(imageDir.path, fileName);

        // Save the image to local file
        final File file = File(filePath);
        await file.writeAsBytes(response.data!);
        return file;
      }

      return null;
    } catch (e) {
      print('Error converting URL to file: $e');
      return null;
    }
  }

  /// Extracts file extension from URL, defaults to .jpg if not found
  static String _getFileExtension(String url) {
    try {
      final Uri uri = Uri.parse(url);
      final String pathSegment = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
      
      if (pathSegment.contains('.')) {
        final String extension = path.extension(pathSegment);
        if (extension.isNotEmpty) {
          return extension;
        }
      }
      
      // Default to .jpg if no extension found
      return '.jpg';
    } catch (e) {
      return '.jpg';
    }
  }

  /// Cleans up downloaded images from temporary directory
  static Future<void> cleanupDownloadedImages() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final Directory imageDir = Directory('${tempDir.path}/downloaded_images');
      
      if (await imageDir.exists()) {
        await imageDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error cleaning up downloaded images: $e');
    }
  }

  /// Downloads a single network video URL to a local File object
  static Future<File?> convertVideoUrlToFile(String videoUrl) async {
    try {
      if (videoUrl.isEmpty) return null;

      final Directory tempDir = await getTemporaryDirectory();
      final Directory videoDir = Directory('${tempDir.path}/downloaded_videos');
      if (!await videoDir.exists()) {
        await videoDir.create(recursive: true);
      }

      // Download the video
      final Response<Uint8List> response = await _dio.get<Uint8List>(
        videoUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.data != null) {
        // Generate a unique filename for video
        final String extension = _getVideoFileExtension(videoUrl);
        final String fileName = 'video_${DateTime.now().millisecondsSinceEpoch}$extension';
        final String filePath = path.join(videoDir.path, fileName);

        // Save the video to local file
        final File file = File(filePath);
        await file.writeAsBytes(response.data!);
        return file;
      }

      return null;
    } catch (e) {
      print('Error converting video URL to file: $e');
      return null;
    }
  }

  /// Extracts video file extension from URL, defaults to .mp4 if not found
  static String _getVideoFileExtension(String url) {
    try {
      final Uri uri = Uri.parse(url);
      final String pathSegment = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
      
      if (pathSegment.contains('.')) {
        final String extension = path.extension(pathSegment);
        if (extension.isNotEmpty && _isVideoExtension(extension)) {
          return extension;
        }
      }
      
      // Default to .mp4 if no extension found
      return '.mp4';
    } catch (e) {
      return '.mp4';
    }
  }

  /// Checks if the extension is a valid video extension
  static bool _isVideoExtension(String extension) {
    const videoExtensions = ['.mp4', '.avi', '.mov', '.wmv', '.flv', '.webm', '.mkv', '.m4v'];
    return videoExtensions.contains(extension.toLowerCase());
  }

  /// Cleans up downloaded videos from temporary directory
  static Future<void> cleanupDownloadedVideos() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final Directory videoDir = Directory('${tempDir.path}/downloaded_videos');
      
      if (await videoDir.exists()) {
        await videoDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error cleaning up downloaded videos: $e');
    }
  }

  /// Cleans up all downloaded media (images and videos) from temporary directory
  static Future<void> cleanupAllDownloadedMedia() async {
    await cleanupDownloadedImages();
    await cleanupDownloadedVideos();
  }

  /// Checks if a URL is a valid image URL
  static bool isValidImageUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      return uri.hasScheme && 
             (uri.scheme == 'http' || uri.scheme == 'https') &&
             uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Checks if a URL is a valid video URL
  static bool isValidVideoUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      return uri.hasScheme && 
             (uri.scheme == 'http' || uri.scheme == 'https') &&
             uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
