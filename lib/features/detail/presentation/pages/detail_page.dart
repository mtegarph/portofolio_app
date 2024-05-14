import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:gap/gap.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';
import 'package:portofolio_app/features/detail/presentation/pages/3d_page.dart';
import 'package:supercharged/supercharged.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Page3D(),
                      ));
                },
                child: view3D()),
            const Gap(10),
            const DetailItem(),
          ],
        ),
      ),
    );
  }

  Container view3D() {
    return Container(
      width: 180,
      height: 45,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        color: Colors.blue,
      ),
      child: Center(
        child: Row(
          children: [
            const Icon(
              Icons.view_in_ar,
              size: 33,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              'Liat Secara 3D',
              style:
                  titleStyleText().copyWith(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rp 500.000.000',
            style: headlineStyleText().copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(4, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: 'FEC7B4'.toColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.discount,
                    color: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ada Cashback Rp 14.000.000',
                      style: titleStyleText()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ayo Pakai Promo ini Sebelum Abis !',
                      style: titleStyleText()
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const Gap(40),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.chevron_right,
                    color: Color.fromARGB(160, 0, 0, 0),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
