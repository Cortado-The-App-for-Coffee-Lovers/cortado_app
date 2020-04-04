import 'package:cortado_app/src/ui/widgets/latte_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style.dart';

class LoadingStateButton<LoadingState> extends StatelessWidget {
  final dynamic button;
  final Bloc bloc;

  const LoadingStateButton({Key key, this.button, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadingState) {
          return Container(
            color: AppColors.light,
            child: Center(child: LatteLoader()),
          );
        }
        return button;
      },
    );
  }
}
