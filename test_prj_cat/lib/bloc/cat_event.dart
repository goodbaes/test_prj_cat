import 'package:flutter/foundation.dart';

abstract class CatEvent {
  const CatEvent();
}

class CatRequested extends CatEvent {}

class CatRefreshReq extends CatEvent {}
