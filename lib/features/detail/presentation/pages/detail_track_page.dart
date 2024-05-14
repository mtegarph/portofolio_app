import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/presentation/pages/add_item.dart';

class DetailTrackPage extends StatelessWidget {
  final RumahEntity rumah;
  const DetailTrackPage({super.key, required this.rumah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Detail Track', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddItem(rumahEntity: rumah),
                  ),
                );
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildHeader(
                rumah.gambar,
                rumah.nama,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Detail Track',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(rumah.detail, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String url, String title) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth / 2,
                  maxHeight: constraints.maxHeight,
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
