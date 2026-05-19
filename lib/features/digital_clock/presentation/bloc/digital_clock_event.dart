part of 'digital_clock_bloc.dart';

abstract class DigitalClockEvent extends Equatable {
  const DigitalClockEvent();

  @override
  List<Object> get props => [];
}

class StartClockEvent extends DigitalClockEvent {
  const StartClockEvent();
}

class UpdateClockEvent extends DigitalClockEvent {
  const UpdateClockEvent();
}

class StopClockEvent extends DigitalClockEvent {
  const StopClockEvent();
}
