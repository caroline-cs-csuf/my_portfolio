import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';
import 'package:my_portfolio/styles/style.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({
    super.key,
    required this.onNavMenuTap,
  });
  final Function(int) onNavMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.maxFinite,
      decoration: kHeaderDectoration,
      child: Row(
        children: [
          SiteLogo(
            onTap: () {},
          ),
          const Spacer(),
          for (int i = 0; i < navTitles.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: () {
                  onNavMenuTap(i);
                },
                child: Text(
                  navTitles[i],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.whitePrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
