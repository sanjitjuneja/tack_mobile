part of image_cropper;

class _ImageCropperScreen extends StatefulWidget {
  final File file;

  const _ImageCropperScreen({
    required this.file,
  });

  @override
  State<_ImageCropperScreen> createState() => _ImageCropperScreenState();
}

class _ImageCropperScreenState extends State<_ImageCropperScreen>
    with TickerProviderStateMixin {
  static const Duration _maskBlurDelay = Duration(milliseconds: 700);
  static const Duration _maskBlurDuration = Duration(milliseconds: 700);

  final CropController _cropController = CropController();
  final ValueNotifier<CropStatus> _cropperStatusNotifier =
      ValueNotifier<CropStatus>(CropStatus.nothing);

  late Uint8List _fileDataToCrop;

  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late ColorTween _colorTween;
  late Color _fallbackColor;

  Timer? _maskBlurTimer;

  bool get isCropperReady => _cropperStatusNotifier.value == CropStatus.ready;

  bool get isCropperLoading =>
      _cropperStatusNotifier.value == CropStatus.nothing ||
      _cropperStatusNotifier.value == CropStatus.loading;

  bool get isCropping => _cropperStatusNotifier.value == CropStatus.cropping;

  @override
  void initState() {
    _fileDataToCrop = widget.file.readAsBytesSync();

    _fallbackColor = AppTheme.primaryColor;

    _colorTween = ColorTween(
      begin: AppTheme.primaryColor.withOpacity(0.25),
      end: AppTheme.primaryColor.withOpacity(0.75),
    );

    _animationController = AnimationController(vsync: this);
    _colorAnimation = _colorTween.animate(_animationController);

    super.initState();
  }

  void _onReveal() {
    _maskBlurTimer?.cancel();
    _animationController.value = 0;
  }

  void _onBlur() {
    _maskBlurTimer?.cancel();
    _maskBlurTimer = Timer(
      _maskBlurDelay,
      () => _animationController.animateTo(
        1,
        duration: _maskBlurDuration,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _onReveal(),
      onPointerUp: (_) => _onBlur(),
      child: Scaffold(
        body: ValueListenableBuilder<CropStatus>(
          valueListenable: _cropperStatusNotifier,
          builder: (_, __, ___) {
            return CupertinoPageScaffold(
              backgroundColor: AppTheme.primaryColor,
              navigationBar: CupertinoNavigationBar(
                border: null,
                backgroundColor: AppTheme.primaryColor,
                leading: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  onPressed: () => AppRouter.of(context).popWithResult(null),
                  child: Text(
                    FlutterI18n.translate(context, 'general.cancel'),
                    style: AppTextTheme.manrope16Regular.copyWith(
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                trailing: Visibility(
                  visible: isCropperReady,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    onPressed: _cropController.crop,
                    child: Text(
                      FlutterI18n.translate(context, 'general.apply'),
                      style: AppTextTheme.manrope16Regular.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Spacer(),
                      Expanded(
                        flex: 7,
                        child: AnimatedBuilder(
                          builder: (_, __) {
                            return Crop(
                              controller: _cropController,
                              image: _fileDataToCrop,
                              onCropped: _onCropped,
                              withCircleUi: true,
                              onStatusChanged: (status) {
                                if (mounted) {
                                  _cropperStatusNotifier.value = status;
                                }
                              },
                              initialSize: 0.9,
                              maskColor:
                                  _colorAnimation.value ?? _fallbackColor,
                              cornerDotBuilder: (size, edgeAlignment) {
                                return const SizedBox.shrink();
                              },
                              interactive: true,
                              fixArea: true,
                            );
                          },
                          animation: _colorAnimation,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  if (isCropperLoading)
                    Positioned.fill(
                      child: Container(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  if (isCropperLoading || isCropping)
                    const AppProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onCropped(Uint8List croppedData) async {
    final File file = await FileManager.writeTempFile(
      croppedData,
      fileName: 'croppedImage',
      mimeType: 'png',
    );

    if (!mounted) return;
    AppRouter.of(context).popWithResult(file);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _maskBlurTimer?.cancel();

    super.dispose();
  }
}
