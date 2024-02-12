import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Download Resume Section
        ElevatedButton(
      onPressed: () {
        // Replace 'your_resume_url.pdf' with the actual URL or file path of your resume
        // For simplicity, I'm using a placeholder URL here
        String resumeUrl =
            'https://docs.google.com/document/d/1hQVuqa2BjCXL6UvfIfUallCC0C2Ua0oH5atKlKVp5AY/edit#heading=h.y7d3xdxnr44m.pdf';

        // Trigger the download action
        downloadResume(resumeUrl);
      },
      child: Text('Download Resume'),
    );
  }

  Future<void> downloadResume(String downloadUrl) async {
    try {
      // Send HTTP GET request to download the file
      var response = await http.get(Uri.parse(downloadUrl));

      // Get the directory for saving the downloaded file
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/resume.pdf';

      // Write the response body to the file
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('File downloaded successfully to: $filePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
}
