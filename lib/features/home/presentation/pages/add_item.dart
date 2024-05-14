import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/presentation/bloc/set_rumah_bloc/set_rumah_bloc.dart';
import 'package:portofolio_app/features/home/presentation/pages/home_page.dart';
import 'package:portofolio_app/features/home/presentation/pages/show_item.dart';
import 'package:uuid/uuid.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, this.rumahEntity});
  final RumahEntity? rumahEntity;

  @override
  // ignore: library_private_types_in_public_api
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  XFile? _image;
  String _imageUrl = '';
  String _name = '';
  String _detail = '';
  TextEditingController nama = TextEditingController();
  TextEditingController detail = TextEditingController();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = pickedFile;
      try {
        // Contoh upload gambar ke Appwrite
        final result = await Storage(AppwriteConfig.client).createFile(
          bucketId: '660b07632c998b9c24b3', // Ganti dengan ID bucket kamu
          fileId: const Uuid().v4(), // Appwrite akan menggenerate ID unik
          file: InputFile.fromPath(path: _image!.path),
        );
        // Simpan URL gambar yang diupload untuk digunakan saat insert data
        final imageUrl =
            '${AppwriteConfig.client.endPoint}/storage/buckets/660b07632c998b9c24b3/files/${result.$id}/view?project=660518f69d2bf201279b';
        setState(() {
          _image = pickedFile;
          // Misalnya, simpan URL ke variabel untuk digunakan nanti
          _imageUrl = imageUrl;
        });
      } catch (e) {
        print('Upload failed with error: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.rumahEntity != null) {
      nama.text = widget.rumahEntity!.nama;
      detail.text = widget.rumahEntity!.detail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name, Image, and Detail Form'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                controller: detail,
                decoration: const InputDecoration(labelText: 'Detail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some details';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _detail = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              if (_image != null)
                Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                  height: 200,
                ),
              if (widget.rumahEntity != null && _image == null)
                Image.network(
                  widget.rumahEntity?.gambar ?? '',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              BlocConsumer<SetRumahBlocBloc, SetRumahBlocState>(
                listener: (context, state) {
                  if (state is SetRumahLoaded) {
                    // Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content: Text(state.message),
                      ),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: Colors.black,
                    //     content: Text(state.message),
                    //   ),
                    // );
                  } else if (state is SetRumahFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CreateParam param = CreateParam(
                          nama: nama.text,
                          gambar: _imageUrl,
                          detail: detail.text,
                        );
                        if (widget.rumahEntity == null) {
                          context
                              .read<SetRumahBlocBloc>()
                              .add(PostRumah(params: param));
                        } else {
                          RumahEntity rumahEntity = RumahEntity(
                            nama: _name,
                            gambar: _image != null
                                ? _imageUrl
                                : widget.rumahEntity!.gambar,
                            detail: _detail,
                            id: widget.rumahEntity!.id,
                          );

                          context
                              .read<SetRumahBlocBloc>()
                              .add(UpdateRumah(params: rumahEntity));
                        }
                      }
                    },
                    child: (state is SetRumahLoading)
                        ? const CupertinoActivityIndicator()
                        : Text(
                            widget.rumahEntity == null ? 'Submit' : 'Update'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
