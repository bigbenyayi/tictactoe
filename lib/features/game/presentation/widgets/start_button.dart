part of '../screens/home_screen.dart';

class _StartButton extends StatelessWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Padding(
      padding: const .symmetric(horizontal: 12.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: .circular(15.0)),
          ),
          backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
        ),
        onPressed: () {
          const GameRoute().push(context);
        },
        child: Padding(
          padding: const .all(8.0),
          child: Text(
            l10n.start,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}