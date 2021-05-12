import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class RefreshRiarysEvent {
  bool refreshRiarys;
  RefreshRiarysEvent(this.refreshRiarys);
}

class SignInEvent{
  bool signIn;
  SignInEvent(this.signIn);
}