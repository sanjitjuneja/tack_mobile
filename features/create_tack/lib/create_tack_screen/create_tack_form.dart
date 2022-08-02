import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_tack/bloc/create_tack_bloc.dart';
import 'package:create_tack/bloc/create_tack_event.dart';
import 'package:create_tack/bloc/create_tack_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTackForm extends StatefulWidget {
  final Group? group;

  const CreateTackForm({
    required this.group,
    super.key,
  });

  @override
  State<CreateTackForm> createState() => _CreateTackFormState();
}

class _CreateTackFormState extends State<CreateTackForm> {
  bool isShowPrompt = false;
  String time = '';
  String title = '';
  String price = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTackBloc, CreateTackState>(
      builder: (_, CreateTackState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${FlutterI18n.translate(
                          context,
                          'createTack.instructions',
                        )} (${widget.group?.name ?? ''})',
                        style: AppTextTheme.manrope13Medium.copyWith(
                          color: AppTheme.textDescriptionColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      RequiredMarkerWidget(
                        text: FlutterI18n.translate(
                          context,
                          'createTack.fields.title',
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        placeholder: 'createTack.fields.titlePlaceholder',
                        onTextChange: (String value) {},
                      ),
                      const SizedBox(height: 12),
                      RequiredMarkerWidget(
                        text: FlutterI18n.translate(
                          context,
                          'createTack.fields.price',
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        placeholder: 'createTack.fields.pricePlaceholder',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters:
                            CurrencyUtility.dollarInputFormatters(),
                        onTextChange: (String value) {},
                      ),
                      const SizedBox(height: 12),
                      RequiredMarkerWidget(
                        text: FlutterI18n.translate(
                          context,
                          'createTack.fields.description',
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        placeholder: 'createTack.fields.descriptionPlaceholder',
                        minLines: 3,
                        onTextChange: (String value) {},
                      ),
                      const SizedBox(height: 12),
                      RequiredMarkerWidget(
                        text: FlutterI18n.translate(
                          context,
                          'createTack.fields.timeEstimation',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: DefaultTabController(
                          length: 2,
                          child: Row(
                            children: const <Widget>[
                              Flexible(
                                child: AppTextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  placeholder:
                                      'createTack.fields.timeEstimationPlaceholder',
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 58),
                              Flexible(
                                flex: 2,
                                child: AppSegmentController(
                                  // controller: controller,
                                  tabs: <int, String>{
                                    0: 'Min',
                                    1: 'Hrs',
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      DefaultTabController(
                        length: 2,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: RequiredMarkerWidget(
                                text: FlutterI18n.translate(
                                  context,
                                  'createTack.fields.counterOffer',
                                ),
                              ),
                            ),
                            const Flexible(
                              flex: 2,
                              child: AppSegmentController(
                                tabs: <bool, String>{
                                  true: 'No',
                                  false: 'Yes',
                                },
                              ),
                            ),
                            const SizedBox(width: 14),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowPrompt = !isShowPrompt;
                                });
                              },
                              child: AppIconsTheme.prompt.svg(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      AnimatedContainer(
                        height: isShowPrompt ? 40 : 0,
                        duration: const Duration(milliseconds: 550),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            FlutterI18n.translate(
                              context,
                              'createTack.promptText',
                            ),
                            style: AppTextTheme.manrope12SemiBold.copyWith(
                              color: AppTheme.textHeavyHintColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  AppCircleButton(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    isDisabled: true,
                    labelKey: 'createTack.editAndPublishButton',
                    onTap: () => _onCreateTackPressed(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onCreateTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<CreateTackBloc>(context).add(
      CreateTack(),
    );
  }

  void _onCreateOpenGroupsFlow(
    BuildContext context,
  ) {
    BlocProvider.of<CreateTackBloc>(context).add(
      OpenGroupsFlow(),
    );
  }
}
