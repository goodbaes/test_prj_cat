import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

class CatInitial extends CatState {}

class CatLoadInProgress extends CatState {}

class CatLoadSuccess extends CatState {
  final catUrl;

  const CatLoadSuccess({@required this.catUrl}) : assert(catUrl != null);

  @override
  List<Object> get props => [catUrl];
}

class CatLoadFailure extends CatState {}
