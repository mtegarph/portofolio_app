import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:portofolio_app/config/theme/app_theme.dart';
import 'package:portofolio_app/config/theme/app_widget.dart';
import 'package:portofolio_app/core/parameter/parameter.dart';
import 'package:portofolio_app/features/home/presentation/pages/home_page.dart';
import 'package:portofolio_app/features/login/presentation/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Center(
                  child: Text(
                    'Selamat Datang Di Salma',
                    style: headlineStyleText()
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(5),
                Center(
                  child: Text(
                    'Nikmati kemudahan Mencari Produk Sesuai Keinginan Kamu',
                    style: headlineStyleText().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(50),
                Text(
                  'Username',
                  style: titleStyleText(),
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 45,
                  child:
                      CustomTextField(hintText: 'Username', controller: email),
                ),
                const Gap(10),
                Text(
                  'Password',
                  style: titleStyleText(),
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 45,
                  child: CustomTextField(
                    hintText: 'Password',
                    controller: password,
                    obscureText: true,
                  ),
                ),
                const Gap(50),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     backgroundColor: Colors.black,
                      //     content: Text(state.message),
                      //   ),
                      // );
                    } else if (state is LoginFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: CustomButton(
                        function: () {
                          Parameter parameterUpdate = Parameter(
                            email: email.text,
                            password: password.text,
                          );
                          context
                              .read<LoginBloc>()
                              .add(PostLogin(parameter: parameterUpdate));
                        },
                        child: (state is LoginPostLoading)
                            ? const CupertinoActivityIndicator()
                            : Text(
                                'Login',
                                style: titleStyleText()
                                    .copyWith(color: Colors.white),
                              ),
                      ),
                    );
                  },
                ),
                Gap(
                  MediaQuery.of(context).size.height / 25,
                ),
                Center(
                  child: Wrap(
                    children: [
                      Text(
                        'Tidak Punya Akun?',
                        style: titleStyleText(),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const ,),);
                        },
                        child: Text(
                          'Daftar Disini',
                          style: titleStyleText()
                              .copyWith(color: ColorStyle.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
