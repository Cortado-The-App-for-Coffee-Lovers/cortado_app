import 'package:cortado_app/src/app.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: ChangeNotifierProvider(
          create: (BuildContext context) => UserModel(), child: App())));
}
