import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Function to download and open the resume URL
  void downloadResume(String resumeUrl) async {
    if (await canLaunch(resumeUrl)) {
      await launch(resumeUrl);
    } else {
      // Handle the error if the URL can't be launched
      print('Could not launch $resumeUrl');
    }
  }
//   void downloadResume(String resumeUrl) async {
// if (await canLaunch(resumeUrl)) {
//       await launch(resumeUrl);
//     } else {
//       // Handle the error if the URL can't be launched
//       print('Could not launch $resumeUrl');
//     }
//   }

  // Placeholder function for launch
  // void launch(String url) {
  //   // You can use the url_launcher package or any other method to handle the download
  //   // For simplicity, I'm printing the URL here
  //   print('Launching URL: $url');
  // }
}
