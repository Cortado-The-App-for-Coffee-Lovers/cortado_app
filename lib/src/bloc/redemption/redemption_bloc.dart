import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/redemption/bloc.dart';




class RedemptionBloc extends Bloc<RedemptionEvent, RedemptionState> {
  @override
  RedemptionState get initialState => RedemptionInitial();

  @override
  Stream<RedemptionState> mapEventToState(
    RedemptionEvent event,
  ) async* {
    if (event is RedeemPressed){
      yield RedemptionLoadingState();
    }
  }
}
