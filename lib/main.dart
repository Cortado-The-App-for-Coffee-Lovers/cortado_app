import 'package:cortado_app/src/app.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/bloc/sign_up/bloc.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<SignUpBloc>(create: (_) => SignUpBloc()),
      ],
      child: ChangeNotifierProvider(
          create: (BuildContext context) => UserModel(), child: App())));
}
