class AnalyticsEvent {
  const AnalyticsEvent._(this._index);

  final int _index;

  static const deck = AnalyticsEvent._(0);
  static const card = AnalyticsEvent._(1);
  static const pack = AnalyticsEvent._(2);
  static const search = AnalyticsEvent._(3);
  static const filter = AnalyticsEvent._(4);
  static const home_refresh = AnalyticsEvent._(5);
  static const home_load_more = AnalyticsEvent._(6);
  static const card_image = AnalyticsEvent._(7);

  String toString() {
    return const <int, String>{
      0: 'deck',
      1: 'card',
      2: 'pack',
      3: 'search',
      4: 'filter',
      5: 'home_refresh',
      6: 'home_load_more',
      7: 'card_image',
    }[_index];
  }
}
