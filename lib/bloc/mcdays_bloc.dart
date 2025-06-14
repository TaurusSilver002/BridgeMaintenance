import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../models/prediction_model.dart';
import 'mcdays_event.dart';
import 'mcdays_state.dart';

class McDaysBloc extends Bloc<McDaysEvent, McDaysState> {
  McDaysBloc() : super(McDaysInitial()) {
    on<FetchPredictions>(_onFetchPredictions);
  }

  Future<void> _onFetchPredictions(
    FetchPredictions event,
    Emitter<McDaysState> emit,
  ) async {
    try {
      emit(McDaysLoading());
        final response = await http.get(Uri.parse(AppUrls.prediction));
      
      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // Debug print
        final dynamic decodedData = json.decode(response.body);
        
        // Handle both single object and list responses
        final List<dynamic> dynamicList = decodedData is List 
            ? decodedData 
            : [decodedData];
        final List<Prediction> predictions = dynamicList
            .map((item) => Prediction.fromJson(item))
            .toList();
        emit(McDaysLoaded(predictions));
      } else {
        emit(McDaysError('Failed to fetch predictions'));
      }
    } catch (e) {
      emit(McDaysError(e.toString()));
    }
  }
}
