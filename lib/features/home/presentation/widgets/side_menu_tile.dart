import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';
import 'package:portofolio_app/features/home/presentation/model/rive_asset.dart';
import 'package:rive/rive.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    required this.riveAsset,
    required this.press,
    required this.riveonInit,
    required this.isActive,
    super.key,
  });
  final RiveAsset riveAsset;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            if (isActive)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                height: 56,
                width: isActive ? 288 : 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF6792FF),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )
            else
              const SizedBox(),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  riveAsset.src,
                  artboard: riveAsset.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(
                riveAsset.title,
                style: titleStyleText().copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
