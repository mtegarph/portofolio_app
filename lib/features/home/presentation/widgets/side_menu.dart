import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';
import 'package:portofolio_app/core/utils/rive_utils.dart';
import 'package:portofolio_app/features/detail/presentation/pages/detail_page.dart';
import 'package:portofolio_app/features/home/presentation/model/rive_asset.dart';
import 'package:portofolio_app/features/home/presentation/pages/add_item.dart';
import 'package:portofolio_app/features/home/presentation/pages/home_page.dart';
import 'package:portofolio_app/features/home/presentation/pages/show_item.dart';
import 'package:portofolio_app/features/home/presentation/widgets/info_card.dart';
import 'package:portofolio_app/features/home/presentation/widgets/side_menu_tile.dart';
import 'package:rive/rive.dart';

class SudeMenu extends StatefulWidget {
  const SudeMenu({required this.updateWidget, super.key});
  final void Function(Widget) updateWidget;

  @override
  State<SudeMenu> createState() => _SudeMenuState();
}

class _SudeMenuState extends State<SudeMenu> {
  List<Widget> pages = [
    ShowItem(),
    DetailPage(),
  ];
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 35,
              // ),
              const InfoCard(
                name: 'tegar',
                profession: 'Flutter Developer',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 16, top: 25),
                child: Text(
                  'Browse'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sideMenus.length,
                itemBuilder: (context, index) {
                  final e = sideMenus[index];
                  return SideMenuTile(
                    riveAsset: e,
                    isActive: selectedMenu == e,
                    riveonInit: (artboard) {
                      //method to get the animation if user is click
                      StateMachineController controller =
                          RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: e.stateMachineName,
                      );
                      // ignore: cast_nullable_to_non_nullable
                      e.input = controller.findSMI('active') as SMIBool;
                    },
                    press: () {
                      e.input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        e.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = e;
                        widget.updateWidget(pages[index]);
                      });
                    },
                  );
                },
              ),
              // ...sideMenus.map(
              //   (e) => SideMenuTile(
              //     riveAsset: e,
              //     isActive: selectedMenu == e,
              //     riveonInit: (artboard) {
              //       //method to get the animation if user is click
              //       StateMachineController controller =
              //           RiveUtils.getRiveController(
              //         artboard,
              //         stateMachineName: e.stateMachineName,
              //       );
              //       // ignore: cast_nullable_to_non_nullable
              //       e.input = controller.findSMI('active') as SMIBool;
              //     },
              //     press: () {
              //       e.input!.change(true);
              //       Future.delayed(const Duration(seconds: 1), () {
              //         e.input!.change(false);
              //       });
              //       setState(() {
              //         selectedMenu = e;
              //         widget.updateWidget(pages[0]);
              //       });
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 16, top: 25),
                child: Text(
                  'History'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenu2.map(
                (menu) => SideMenuTile(
                  riveAsset: menu,
                  isActive: selectedMenu == menu,
                  riveonInit: (artboard) {
                    //method to get the animation if user is click
                    StateMachineController controller =
                        RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: menu.stateMachineName,
                    );
                    // ignore: cast_nullable_to_non_nullable
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                      widget.updateWidget(pages[1]);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
