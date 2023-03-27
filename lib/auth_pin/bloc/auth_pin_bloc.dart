import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pin_code/repository/pin_repository.dart';

part 'auth_pin_event.dart';
part 'auth_pin_state.dart';

class AuthPinBloc extends Bloc<AuthPinEvent, AuthPinState> {
  final PINRepository pinRepository;

  AuthPinBloc({required this.pinRepository}) : super(const AuthPinState(pinStatus: AuthPinStatus.enterPIN)) {
    on<AuthPinAddEvent>((event, emit) async {
      String pin = "${state.pin}${event.pinNum}";
      if(pin.length < 4){
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPIN));
      }
      else if (await pinRepository.pinEquals(pin)){
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.equals));
      }
      else{
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.unequals));
        await Future.delayed(
          const Duration(seconds: 2),
              () => emit(const AuthPinState(pinStatus: AuthPinStatus.enterPIN)),
        );
      }
    });

    on<AuthPinEraseEvent>((event, emit) {
      String pin = state.pin.substring(0, state.pin.length - 1);
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPIN));
    });

    on<AuthNullPINEvent>((event, emit) {
      emit(const AuthPinState(pinStatus: AuthPinStatus.enterPIN));
    });
  }
}
