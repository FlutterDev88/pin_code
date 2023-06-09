part of 'auth_pin_bloc.dart';

enum AuthPinStatus { enterPIN, equals , unequals}
@immutable
class AuthPinState {
  final AuthPinStatus pinStatus;
  final String pin;

  const AuthPinState({required this.pinStatus, this.pin = ""});

  AuthPinState copyWith({
    AuthPinStatus? pinStatus,
    String? pin,
  }) {
    return AuthPinState(
      pinStatus: pinStatus ?? this.pinStatus,
      pin: pin ?? this.pin,
    );
  }

  int getCountsOfPIN(){
    return pin.length;
  }
}