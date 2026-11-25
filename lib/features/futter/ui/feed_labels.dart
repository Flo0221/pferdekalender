import '../../../core/format/formatters.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/feed.dart';

String categoryName(AppLocalizations l10n, FeedCategory c) => switch (c) {
  FeedCategory.raufutter => l10n.feedCategory_raufutter,
  FeedCategory.kraftfutter => l10n.feedCategory_kraftfutter,
  FeedCategory.mineralfutter => l10n.feedCategory_mineralfutter,
  FeedCategory.ergaenzung => l10n.feedCategory_ergaenzung,
  FeedCategory.oel => l10n.feedCategory_oel,
  FeedCategory.leckerli => l10n.feedCategory_leckerli,
  FeedCategory.medikament => l10n.feedCategory_medikament,
};

String unitName(AppLocalizations l10n, FeedUnit u) => switch (u) {
  FeedUnit.kg => l10n.feedUnit_kg,
  FeedUnit.g => l10n.feedUnit_g,
  FeedUnit.ml => l10n.feedUnit_ml,
  FeedUnit.messbecher => l10n.feedUnit_messbecher,
  FeedUnit.stueck => l10n.feedUnit_stueck,
  FeedUnit.liter => l10n.feedUnit_liter,
};

String variantName(AppLocalizations l10n, FeedVariant v) => switch (v) {
  FeedVariant.always => l10n.feedVariant_always,
  FeedVariant.trainingDay => l10n.feedVariant_training,
  FeedVariant.restDay => l10n.feedVariant_rest,
};

/// „2,5 kg“ bzw. „laut Packungsangabe“.
String amountText(AppLocalizations l10n, double? amount, FeedItem? item) {
  if (amount == null) return l10n.feedAsDirected;
  final unit = item == null ? '' : ' ${unitName(l10n, item.unit)}';
  return '${Fmt.decimal(amount)}$unit';
}
