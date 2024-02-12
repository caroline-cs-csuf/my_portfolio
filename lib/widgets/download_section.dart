import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'dart:html' as html;
import 'package:universal_html/html.dart' as html;

//import 'package:universal_html/html.dart';

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

        if (kIsWeb) {
          // Trigger the download action
          html.AnchorElement anchorElement = html.AnchorElement(href: resumeUrl)
            ..setAttribute("download", "resume.pdf");
          anchorElement.click();
        } else {
          downloadResume(resumeUrl);
        }
      },
      child: Text('Download Resume'),
    );
  }

  Future<void> downloadResume(String downloadUrl) async {
    try {
      // Send HTTP GET request to download the file
      var response = await http.get(Uri.parse(downloadUrl));

      // Get the directory for saving the downloaded file
      String? directoryPath = await FilePicker.platform.getDirectoryPath();

      // Ensure that the directory path is not null
      if (directoryPath != null) {
        // Create a new file object in the selected directory path
        io.File file = io.File('$directoryPath/resume.pdf');

        // Write the response body to the file
        await file.writeAsBytes(response.bodyBytes);

        print('File downloaded successfully to: $directoryPath');
      } else {
        print('No valid save path selected');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
}
