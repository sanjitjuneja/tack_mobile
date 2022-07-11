part of tack_tile;

class TackTileActions extends StatelessWidget {
  final TackModel tack;

  const TackTileActions({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: AppButton(
            label: FlutterI18n.translate(context, 'general.counter'),
            type: ButtonType.secondary,
            withShadow: false,
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)
                  .add(CounterOfferOpen(tack: tack));
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: AppButton(
            label: FlutterI18n.translate(context, 'general.accept'),
            icon: AppIconsTheme.edit,
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)
                  .add(AcceptTack(tack: tack));
            },
          ),
        ),
      ],
    );
  }
}
