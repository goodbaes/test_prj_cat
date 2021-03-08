import 'dart:async';
import 'dart:typed_data';
import 'bloc.dart';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:test_prj_cat/repositories/repositories.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc() : super(CatInitial());

  @override
  Stream<CatState> mapEventToState(
    CatEvent event,
  ) async* {
    if (event is CatRefreshReq) {
      yield CatLoadInProgress();
      final cat = await new CatApiClient().getImgUrl();

      yield CatLoadSuccess(catUrl: cat);
    }
    if (event is CatRequested) {
      yield CatLoadInProgress();
      try {
        final cat = await new CatApiClient().getImgUrl();

        yield CatLoadSuccess(catUrl: cat);
      } catch (e) {
        yield CatLoadFailure();
      }
    }
  }
}
