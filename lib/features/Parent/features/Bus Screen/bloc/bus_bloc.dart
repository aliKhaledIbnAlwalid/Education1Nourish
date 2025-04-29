// lib/bloc/bus_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/api_service.dart';

import 'bus_event.dart';
import 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  final ApiService apiService;

  BusBloc({required this.apiService}) : super(BusInitial()) {
    on<FetchBuses>(_onFetchBuses);
  }

  Future<void> _onFetchBuses(
      FetchBuses event, Emitter<BusState> emit) async {
    emit(BusLoading());
    try {
      final buses = await apiService.fetchBuses(endPoint: 'buses');
      emit(BusLoaded(buses));
    } catch (e) {
      emit(BusError(e.toString()));
    }
  }
}
