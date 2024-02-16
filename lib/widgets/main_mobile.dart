import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      height: screenHeight,
      constraints: const BoxConstraints(
        minHeight: 600,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Avatar_img
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(colors: [
                CustomColor.scaffoldBg.withOpacity(0.6),
                CustomColor.scaffoldBg.withOpacity(0.6),
              ]).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              "assets/Untitled 2.png",
              width: screenWidth,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //intro message
          const Text(
            "Hello,\nI'm Caroline Ha\nAn iOS Developer",
            style: TextStyle(
              fontSize: 24,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          const SizedBox(height: 15),
          //contact btn
          SizedBox(
            width: 190,
            child: ElevatedButton(
              onPressed: () {
                // For simplicity, I'm using a placeholder URL here
                String resumeUrl =
                    'https://docs.google.com/document/d/1hQVuqa2BjCXL6UvfIfUallCC0C2Ua0oH5atKlKVp5AY/edit#heading=h.y7d3xdxnr44m.pdf';

                if (kIsWeb) {
                  // Trigger the download action
                  html.AnchorElement anchorElement =
                      html.AnchorElement(href: resumeUrl)
                        ..setAttribute("download", "resume.pdf");
                  anchorElement.click();
                } else {
                  downloadResume(resumeUrl);
                }
              },
              child: const Text("Download Resume"),
            ),
          )
        ],
      ),
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
