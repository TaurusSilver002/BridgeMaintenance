import 'package:equatable/equatable.dart';
import '../models/prediction_model.dart';

abstract class McDaysState extends Equatable {
  const McDaysState();

  @override
  List<Object> get props => [];
}

class McDaysInitial extends McDaysState {}

class McDaysLoading extends McDaysState {}

class McDaysLoaded extends McDaysState {
  final List<Prediction> predictions;

  const McDaysLoaded(this.predictions);

  @override
  List<Object> get props => [predictions];
}

class McDaysError extends McDaysState {
  final String message;

  const McDaysError(this.message);

  @override
  List<Object> get props => [message];
}
