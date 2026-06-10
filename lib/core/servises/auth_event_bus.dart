import 'dart:async';

enum AuthEvent {
  loggedOut,
}

class AuthEventBus {
  AuthEventBus._();

  static final AuthEventBus instance = AuthEventBus._();

  final StreamController<AuthEvent> _controller =
      StreamController<AuthEvent>.broadcast();

  Stream<AuthEvent> get stream => _controller.stream;

  void add(AuthEvent event) => _controller.add(event);

  void dispose() {
    _controller.close();
  }
}
