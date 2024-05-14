import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/dependency_injection.dart';
import 'package:portofolio_app/features/home/presentation/bloc/homepage_bloc.dart';
import 'package:portofolio_app/features/home/presentation/bloc/set_rumah_bloc/set_rumah_bloc.dart';
import 'package:portofolio_app/features/home/presentation/pages/home_page.dart';
import 'package:portofolio_app/features/login/presentation/bloc/get_login_bloc/get_login_bloc.dart';
import 'package:portofolio_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:portofolio_app/features/login/presentation/pages/login_page.dart';
import 'package:portofolio_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<SetRumahBlocBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<HomepageBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<GetLoginBloc>(
          create: (context) => sl()..add(const GetLogin()),
        ),
        BlocProvider<HomepageDataBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocConsumer<GetLoginBloc, GetLoginState>(
          listener: (context, state) {
            if (state is GetLoginSuccess) {
              state.isLogin == true
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    )
                  : null;
            }
          },
          builder: (context, state) {
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
