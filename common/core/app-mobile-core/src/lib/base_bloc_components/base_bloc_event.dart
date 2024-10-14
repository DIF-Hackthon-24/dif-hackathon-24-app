/// extend this class to create a custom event
/// sent by the [BaseWidget] subclass
/// bloc.event.add(SubClassOfBaseBlocEvent(myData))
abstract class BaseBlocEvent {
  final String analyticEventName;
  Map<String, dynamic>? eventProperties;

  BaseBlocEvent(this.analyticEventName, {this.eventProperties});
}