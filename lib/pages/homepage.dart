import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/Sns_links.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/custom_text_filed.dart';
import 'package:my_portfolio/widgets/download_section.dart';
import 'package:my_portfolio/widgets/drawer_mobile.dart';
import 'package:my_portfolio/widgets/footer.dart';
import 'package:my_portfolio/widgets/header_desktop.dart';
import 'package:my_portfolio/widgets/header_mobile.dart';
import 'package:my_portfolio/widgets/main_desktop.dart';
import 'package:my_portfolio/widgets/main_mobile.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/widgets/projects_section.dart';
import 'package:my_portfolio/widgets/skills_desktop.dart';
import 'package:my_portfolio/widgets/skills_mobile.dart';
//import 'dart:js' as js;
//import 'package:js/js.dart' as js; // not sure whether correct or not.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    //final screenHeight = screenSize.height;

    return LayoutBuilder(builder: (context, Constraints) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColor.scaffoldBg,
        endDrawer: Constraints.minWidth >= kMinDesktopWidth
            ? null
            : DrawerMobile(onNavItemTap: (int navIndex) {
                //call
                scaffoldKey.currentState?.closeEndDrawer();
                scrollToSection(navIndex);
              }),
        body: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                key: navBarKeys.first,
              ),
              // Main
              if (Constraints.maxWidth >= kMinDesktopWidth)
                HeaderDesktop(
                  onNavMenuTap: (int navIndex) {
                    //call func
                    scrollToSection(navIndex);
                  },
                )
              else
                HeaderMobile(
                  onLogoTap: () {},
                  onMenuTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

              if (Constraints.maxWidth >= kMinDesktopWidth)
                const MainDesktop()
              else
                const MainMobile(),

              // SKILLS
              Container(
                key: navBarKeys[1],
                height: 500,
                width: screenWidth,
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
                color: CustomColor.bgLight1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //title
                    const Text(
                      "What I can do",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // platforms and skills
                    if (Constraints.maxWidth >= kMedDesktopWidth)
                      const SkillsDesktop()
                    else
                      const SkillsMobile()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // Projects
              ProjectsSection(
                key: navBarKeys[2],
              ),

              const SizedBox(
                height: 30,
              ),

              // Contact
              ContactSection(
                key: navBarKeys[3],
              ),
              const SizedBox(height: 30),

              // Download Resume Section
              DownloadSection(),
              const SizedBox(height: 20),

              // Footer
              const Footer(),
            ],
          ),
        ),
      );
    });
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open a blog page
      //js.context.callMethod('open', [SnsLinks.blog]);

      return;
    }

    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
