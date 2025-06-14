import 'package:equatable/equatable.dart';

abstract class McDaysEvent extends Equatable {
  const McDaysEvent();

  @override
  List<Object> get props => [];
}

class FetchPredictions extends McDaysEvent {}
