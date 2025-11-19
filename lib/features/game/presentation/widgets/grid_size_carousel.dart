part of '../screens/home_screen.dart';

class _GridSizeCarousel extends ConsumerStatefulWidget {
  const _GridSizeCarousel({Key? key}) : super(key: key);

  @override
  ConsumerState<_GridSizeCarousel> createState() => _GridSizeCarouselState();
}

class _GridSizeCarouselState extends ConsumerState<_GridSizeCarousel> {
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final GameSettings settings = ref.watch(gameSettingsProvider);
    final GameSettingsNotifier gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    return CarouselSlider.builder(
      itemCount: GridSize.values.length,
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 325.0,
        enlargeCenterPage: true,
        viewportFraction: MediaQuery.of(context).size.width > 600 ? .4 : .65,
        enableInfiniteScroll: false,
        initialPage: GridSize.values.indexOf(settings.gridSize),
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          gameSettingsNotifier.setGridSize(GridSize.values[index]);
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final GridSize gridSize = GridSize.values[index];
        return GestureDetector(
          onTap: () {
            _carouselController.animateToPage(index);
            gameSettingsNotifier.setGridSize(gridSize);
          },
          child: Column(
            children: <Widget>[
              Text(
                gridSize.sizeLabel,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(l10n.connectNToWin(gridSize.winLength), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8.0),
              Flexible(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  padding: const .all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: .circular(20.0),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize.dimension,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: gridSize.dimension * gridSize.dimension,
                    itemBuilder: (BuildContext context, int index) {
                      const double maxRadius = 15.0;
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: .circular(maxRadius - gridSize.dimension.toDouble()),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Theme.of(context).primaryColor, offset: const Offset(.0, 4.0)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
