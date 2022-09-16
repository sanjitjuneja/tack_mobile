part of tack_tile;

class TackTileActions extends StatelessWidget {
  final GroupTack groupTack;

  const TackTileActions({
    super.key,
    required this.groupTack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, GlobalState state) {
        final bool isMineOfferSent = groupTack.isMineOfferSent;
        final bool isOwnTack = state.user.id == groupTack.tack.tacker.id;

        if (isMineOfferSent) {
          return AppButton(
            labelKey: 'dashboardScreen.offerSentButton',
            withFeedback: true,
            onTap: () => _onRunningByMeButtonPressed(context),
          );
        } else if (isOwnTack) {
          return AppButton(
            labelKey: 'dashboardScreen.createdByYouButton',
            withFeedback: true,
            onTap: () => _onCreatedByMeButtonPressed(context),
          );
        } else {
          return Row(
            children: <Widget>[
              if (groupTack.tack.allowCounterOffers) ...<Widget>[
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
      },
    );
  }

  void _onRunningByMeButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(
      OpenOwnRunningOngoingTack(groupTack: groupTack),
    );
  }

  void _onCreatedByMeButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(
      OpenOwnCreatedOngoingTack(groupTack: groupTack),
    );
  }

  void _onCounterButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(
      CounterOfferOpen(groupTack: groupTack),
    );
  }

  void _onAcceptButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(
      AcceptTack(groupTack: groupTack),
    );
  }
}
