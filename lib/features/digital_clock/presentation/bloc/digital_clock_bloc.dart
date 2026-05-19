import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

part 'digital_clock_event.dart';
part 'digital_clock_state.dart';

class DigitalClockBloc extends Bloc<DigitalClockEvent, DigitalClockState> {
  Timer? _timer;
  final List<String> timeZones = [
    'America/New_York',
    'Europe/London',
    'Europe/Paris',
    'Asia/Tokyo',
    'Asia/Dubai',
    'Australia/Sydney',
  ];

  DigitalClockBloc() : super(const DigitalClockInitialState()) {
    on<StartClockEvent>(_onStartClock);
    on<UpdateClockEvent>(_onUpdateClock);
    on<StopClockEvent>(_onStopClock);
  }

  Future<void> _onStartClock(
    StartClockEvent event,
    Emitter<DigitalClockState> emit,
  ) async {
    emit(const DigitalClockLoadingState());
    try {
      // Initial update
      _updateClock(emit);

      // Update every second
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(const UpdateClockEvent());
      });
    } catch (e) {
      emit(DigitalClockErrorState('Error starting clock: $e'));
    }
  }

  Future<void> _onUpdateClock(
    UpdateClockEvent event,
    Emitter<DigitalClockState> emit,
  ) async {
    _updateClock(emit);
  }

  void _updateClock(Emitter<DigitalClockState> emit) {
    final now = DateTime.now();
    final localTime = DateFormat('HH:mm:ss').format(now);
    final localDate = DateFormat('EEEE, MMMM d, yyyy').format(now);

    final List<String> times = [];
    final List<String> dates = [];

    for (String timeZoneName in timeZones) {
      try {
        final location = tz.getLocation(timeZoneName);
        final tzTime = tz.TZDateTime.from(now, location);
        times.add(DateFormat('HH:mm:ss').format(tzTime));
        dates.add(DateFormat('MMM d').format(tzTime));
      } catch (e) {
        times.add('N/A');
        dates.add('N/A');
      }
    }

    emit(
      DigitalClockLoadedState(
        localTime: localTime,
        localDate: localDate,
        timeZones: timeZones,
        times: times,
        dates: dates,
      ),
    );
  }

  Future<void> _onStopClock(
    StopClockEvent event,
    Emitter<DigitalClockState> emit,
  ) async {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
