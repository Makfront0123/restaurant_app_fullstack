abstract class ApplicationEvent {}

class TabChangedEvent extends ApplicationEvent {
  final int newIndex;
  TabChangedEvent(this.newIndex);
}