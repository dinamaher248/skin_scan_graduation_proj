import '../helper/Chat.dart';
import 'package:event_bus/event_bus.dart';

class ChatConnectionEvent {
  final Chat chatService;

  ChatConnectionEvent(this.chatService);
}

class EventBusSingleton {
  EventBusSingleton._();
  static final EventBus _instance = EventBus();
  static EventBus get instance => _instance;
}
