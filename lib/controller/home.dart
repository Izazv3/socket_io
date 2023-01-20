import 'package:get/get.dart';
import 'package:socket/model.dart';

class HomeController extends GetxController {
  final List<Message> listmessages = [];
  var couter = 0.obs;
  //List<Message> get messages => listmessages;

  addNewMessage(Message message) {
    listmessages.add(message);
  }
}
