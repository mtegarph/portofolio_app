import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
class MenuButton extends StatelessWidget {
  const MenuButton({
    required this.press,
    required this.riveonInit,
    super.key,
  });
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: riveonInit,
          ),
        ),
      ),
    );
  }
}
