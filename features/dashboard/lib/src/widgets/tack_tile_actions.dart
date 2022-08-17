part of tack_tile;

class TackTileActions extends StatelessWidget {
  final Tack tack;

  const TackTileActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
        builder: (_, GlobalState state) {
      final bool isOwnTack = state.user.id == tack.tacker.id;
      if (isOwnTack) {
        return AppButton(
          labelKey: 'dashboardScreen.createdByYouButton',
          withFeedback: true,
          onTap: () => _onCreatedByMeButtonPressed(context),
        );
      } else {
        return Row(
          children: <Widget>[
            if (tack.allowCounterOffers) ...<Widget>[
              Expanded(
                flex: 1,
                child: AppButton(
                  labelKey: 'general.counter',
                  type: ButtonType.secondary,
                  withShadow: false,
                  onTap: () => _onCounterButtonPressed(context),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: 2,
              child: AppButton(
                labelKey: 'general.accept',
                icon: AppIconsTheme.edit,
                withFeedback: true,
                onTap: () => _onAcceptButtonPressed(context),
              ),
            ),
          ],
        );
      }
    });
  }

  void _onCreatedByMeButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(OpenOwnOngoingTack(tack: tack));
  }

  void _onCounterButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(CounterOfferOpen(tack: tack));
  }

  void _onAcceptButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(AcceptTack(tack: tack));
  }
}
