/// Aggregated spending for a single category in a statement period.
class CategorySpend {
  const CategorySpend({
    required this.name,
    required this.amount,
    required this.icon,
  });

  final String name;
  final double amount;

  /// Semantic icon key (mapped to a Material icon in the UI layer).
  final String icon;
}
