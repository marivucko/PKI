import 'package:starter_pack/data/order_database.dart';
import 'package:starter_pack/services/database_services.dart';
import 'package:starter_pack/services/design_service.dart';

class AllServices {

  static final AllServices _instance = AllServices._internal();

  DesignService designService;
  DatabaseService databaseService;

  factory AllServices() {
    return _instance;
  }

  AllServices._internal() {
    designService = new DesignService();
    databaseService = new DatabaseService();
  }

}