part of tack_tile;

class TackTileActions extends StatelessWidget {
  final Tack tack;

  const TackTileActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (tack.allowCounterOffers) ...<Widget>[
          Expanded(
            flex: 1,
            child: AppButton(
              labelKey: 'general.counter',
              type: ButtonType.secondary,
              withShadow: false,
              onTap: () => _onCounterButtonTap(context),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          flex: 2,
          child: AppButton(
            labelKey: 'general.accept',
            icon: AppIconsTheme.edit,
            onTap: () => _onAcceptButtonTap(context),
          ),
        ),
      ],
    );
  }

  void _onCounterButtonTap(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(CounterOfferOpen(tack: tack));
  }

  void _onAcceptButtonTap(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(AcceptTack(tack: tack));
  }
}
