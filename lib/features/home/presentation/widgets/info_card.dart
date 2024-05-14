import 'package:flutter/material.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.name,
    required this.profession,
    super.key,
  });
  final String name;
  final String profession;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      // ignore: lines_longer_than_80_chars
      title: Text(name, style: headlineStyleText().copyWith(color: Colors.white)),
      // ignore: lines_longer_than_80_chars
      subtitle: Text(profession, style: titleStyleText().copyWith(color: Colors.white)),
      // trailing: const Icon(
      //   Icons.cancel,
      //   color: Colors.white,
      //   size: 30,
      // ),
    );
  }
}
