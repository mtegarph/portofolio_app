import 'dart:io';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_resume/need_resume.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/core/utils/rive_utils.dart';
import 'package:portofolio_app/features/detail/presentation/pages/detail_page.dart';
import 'package:portofolio_app/features/home/presentation/bloc/homepage_bloc.dart';
import 'package:portofolio_app/features/home/presentation/bloc/set_rumah_bloc/set_rumah_bloc.dart';
import 'package:portofolio_app/features/home/presentation/pages/add_item.dart';
import 'package:portofolio_app/features/home/presentation/pages/show_item.dart';
import 'package:portofolio_app/features/home/presentation/widgets/menu_button.dart';
import 'package:portofolio_app/features/home/presentation/widgets/side_menu.dart';
import 'package:rive/rive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResumableState<HomePage>
    with SingleTickerProviderStateMixin {
  late SMIBool isSideBarClose;
  bool isSideMenuClosed = true;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  Widget pages = const ShowItem();
  void updateWidget(Widget paget) {
    setState(() {
      pages = paget;
    });
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
  }

  @override
  void onPause() {
    super.onPause();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 266),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    context.read<HomepageBloc>().add(GetDataHomeEvent());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17203A),
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: 0,
              height: MediaQuery.of(context).size.height,
              child: SudeMenu(
                updateWidget: updateWidget,
              ),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    //Animated Swicher is for animated a widget or a variable
                    //when its change from old to new
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: pages,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 16,
              child: MenuButton(
                press: () {
                  isSideBarClose.value = !isSideBarClose.value;
                  if (isSideMenuClosed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = isSideBarClose.value;
                  });
                },
                riveonInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: 'State Machine',
                  );
                  isSideBarClose = controller.findSMI('isOpen') as SMIBool;
                  isSideBarClose.value = true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class Dashboard extends StatelessWidget {
//   const Dashboard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: Colors.white,
//       child: Column(
//         children: [
//           const SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search address, or near you',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       // ignore: inference_failure_on_instance_creation
//                       MaterialPageRoute(
//                         builder: (context) => const DetailPage(),
//                       ),);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text('House'),
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text('Apartment'),
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text('Hotel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text('Villa'),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Near from you'),
//                 Text('See more'),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Card(
//                 child: Column(
//                   children: [
//                     // Image.asset('assets/images/house1.jpg'),
//                     Image.network(
//                       'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//                       height: 100,
//                       width: 200,
//                     ),
//                     const Text('Dreamsville House'),
//                     const Text('Jl. Sultan Iskandar Muda'),
//                   ],
//                 ),
//               ),
//               Card(
//                 child: Column(
//                   children: [
//                     // Image.asset('assets/images/house2.jpg'),
//                     Image.network(
//                       'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//                       height: 100,
//                       width: 200,
//                     ),
//                     const Text('Ascot House'),
//                     const Text('Jl. Clandak Tengah'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Best for you'),
//                 Text('See more'),
//               ],
//             ),
//           ),
//           ListView(
//             shrinkWrap:
//                 true, // This line ensures the ListView only takes up the space it needs
//             children: [
//               Card(
//                 child: Row(
//                   children: [
//                     Image.network(
//                       'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//                       fit: BoxFit.cover,
//                       height: 100,
//                       width: 200,
//                     ),
//                     const Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Orchard House',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text('Rp. 2,500,000,000 / Year'),
//                             Row(
//                               children: [
//                                 Icon(Icons.bed),
//                                 Text('6 Bedroom'),
//                                 SizedBox(width: 16),
//                                 Icon(Icons.bathtub),
//                                 Text('4 Bathroom'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Card(
//                 child: Row(
//                   children: [
//                     Image.network(
//                       'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//                       fit: BoxFit.cover,
//                       height: 100,
//                       width: 200,
//                     ),
//                     const Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'The Hollies House',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text('Rp. 2,000,000,000 / Year'),
//                             Row(
//                               children: [
//                                 Icon(Icons.bed),
//                                 Text('5 Bedroom'),
//                                 SizedBox(width: 16),
//                                 Icon(Icons.bathtub),
//                                 Text('2 Bathroom'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
