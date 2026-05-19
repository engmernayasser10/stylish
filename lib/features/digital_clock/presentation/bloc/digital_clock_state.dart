part of 'digital_clock_bloc.dart';

abstract class DigitalClockState extends Equatable {
  const DigitalClockState();

  @override
  List<Object> get props => [];
}

class DigitalClockInitialState extends DigitalClockState {
  const DigitalClockInitialState();
}

class DigitalClockLoadingState extends DigitalClockState {
  const DigitalClockLoadingState();
}

class DigitalClockLoadedState extends DigitalClockState {
  final String localTime;
  final String localDate;
  final List<String> timeZones;
  final List<String> times;
  final List<String> dates;

  const DigitalClockLoadedState({
    required this.localTime,
    required this.localDate,
    required this.timeZones,
    required this.times,
    required this.dates,
  });

  @override
  List<Object> get props => [localTime, localDate, timeZones, times, dates];
}

class DigitalClockErrorState extends DigitalClockState {
  final String message;

  const DigitalClockErrorState(this.message);

  @override
  List<Object> get props => [message];
}
