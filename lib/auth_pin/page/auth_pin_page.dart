import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code/auth_pin/bloc/auth_pin_bloc.dart';
import 'package:pin_code/home_page.dart';
import 'package:pin_code/i10n/app_localizations.dart';
import 'package:pin_code/repository/pin_repository.dart';
import 'package:pin_code/widgets/button_of_numpad.dart';
import 'package:pin_code/widgets/pin_sphere.dart';

class AuthPINPage extends StatelessWidget {
  const AuthPINPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) =>
              AuthPinBloc(pinRepository: HivePINRepository(context: context)),
          child: BlocListener<AuthPinBloc, AuthPinState>(
            listener: (context, state) {
              if (state.pinStatus == AuthPinStatus.equals) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Text(S.of(context).authSuccess),
                    actionsAlignment: MainAxisAlignment.center,
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 2),
                  () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (_) => false),
                );
              } else if (state.pinStatus == AuthPinStatus.unequals) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          title: Text(S.of(context).authFailed),
                          actionsAlignment: MainAxisAlignment.center,
                        ));
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 2, child: _MainPart()),
                Expanded(flex: 3, child: _NumPad()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "1",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 1)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "2",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 2)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "3",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "4",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 4)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "5",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 5)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "6",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "7",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 7)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "8",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 8)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "9",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "0",
                        onPressed: () =>
                            BlocProvider.of<AuthPinBloc>(context).add(
                                const AuthPinAddEvent(pinNum: 0)))),
                const SizedBox(width: 8),
                Expanded(
                    child: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () =>
                      BlocProvider.of<AuthPinBloc>(context)
                          .add(const AuthPinEraseEvent()),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: BlocBuilder<AuthPinBloc, AuthPinState>(
        buildWhen: (previous, current) => previous.pin != current.pin,
        builder: (context, state) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              flex: 2,
              child: Text(S.of(context).enterYourPIN,
                  style: const TextStyle(color: Color(0xFF687ea1), fontSize: 36)),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) =>
                        PinSphere(input: index < state.getCountsOfPIN())),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
