import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code/create_pin/bloc/create_pin_bloc.dart';
import 'package:pin_code/home_page.dart';
import 'package:pin_code/i10n/app_localizations.dart';
import 'package:pin_code/repository/pin_repository.dart';
import 'package:pin_code/widgets/button_of_numpad.dart';
import 'package:pin_code/widgets/pin_sphere.dart';

class CreatePINPage extends StatelessWidget {
  const CreatePINPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(S.of(context).setupPIN, style: const TextStyle(color: Colors.black)),
        actions: [
          Center(
              child: Text(S.of(context).useFourDigitsPIN,
                  style: const TextStyle(color: Color(0xFF687ea1))))
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) => CreatePINBloc(pinRepository: HivePINRepository(context: context)),
          child: BlocListener<CreatePINBloc, CreatePINState>(
            listener: (context, state) {
              if (state.pinStatus == PINStatus.equals) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          title: Text(S.of(context).pinCreated),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false),
                              child: Text(S.of(context).ok),
                            )
                          ],
                        ));
              } else if (state.pinStatus == PINStatus.unequals) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          title: Text(S.of(context).pinNonCreated),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  BlocProvider.of<CreatePINBloc>(context)
                                      .add(const CreateNullPINEvent()),
                              child: Text(S.of(context).ok),
                            )
                          ],
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
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 1)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "2",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 2)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "3",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 3)))),
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
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 4)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "5",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 5)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "6",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 6)))),
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
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 7)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "8",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 8)))),
                const SizedBox(width: 8),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "9",
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
                        onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                            .add(const CreatePINAddEvent(pinNum: 0)))),
                const SizedBox(width: 8),
                Expanded(
                    child: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () => BlocProvider.of<CreatePINBloc>(context)
                      .add(const CreatePINEraseEvent()),
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
      child: BlocBuilder<CreatePINBloc, CreatePINState>(
        buildWhen: (previous, current) =>
            previous.firstPIN != current.firstPIN ||
            previous.secondPIN != current.secondPIN,
        builder: (context, state) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              flex: 2,
              child: Text(
                  state.pinStatus == PINStatus.enterFirst
                      ? S.of(context).createPIN
                      : S.of(context).reEnterYourPIN,
                  style:
                      const TextStyle(color: Color(0xFF687ea1), fontSize: 36)),
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