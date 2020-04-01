import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        }
        return button;
      },
    );
  }
}