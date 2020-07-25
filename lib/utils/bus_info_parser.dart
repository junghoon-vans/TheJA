import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:theja/models/models.dart';
import 'package:theja/authenticate.dart';

class BusInfoParser {
  BusInfoParser._();
  static final BusInfoParser bus = BusInfoParser._();

  String searchStationUri =
      "http://openapi.gbis.go.kr/ws/rest/busstationservice";
  String searchRouteUri =
      "http://ws.bus.go.kr/api/rest/arrive/getLowArrInfoByStId";

  Future<List<Vehicle>> searchStation(String keyword) async {
    String xmlString = await fetchDocument(
        searchStationUri + "?serviceKey=" + serviceKey + "&keyword=" + keyword);
    var raw = xml.parse(xmlString);
    var elements = raw.findAllElements("busStationList");

    List<Vehicle> busList = List<Vehicle>();
    elements.forEach((element) {
      Vehicle bus = new Bus(
        stationId: int.parse(element.findElements("stationId").first.text),
        stationName: element.findElements("stationName").first.text,
      );
      busList.add(bus);
    });
    return busList;
  }

  Future<List<Vehicle>> searchVehicle(String stationId) async {
    String xmlString = await fetchDocument(searchRouteUri +
        "?serviceKey=" +
        serviceKey +
        "&stId=" +
        stationId +
        "&");
    var raw = xml.parse(xmlString);
    print(raw);
    var elements = raw.findAllElements("itemList");

    List<Vehicle> busList = List<Vehicle>();
    elements.forEach((element) {
      Vehicle bus = new Bus(
        routeId: int.parse(element.findElements("busRouteId").first.text),
        routeName: element.findElements("rtNm").first.text,
        stationId: int.parse(element.findElements("stId").first.text),
        stationName: element.findElements("stNm").first.text,
      );
      busList.add(bus);
    });
    return busList;
  }

  Future<String> fetchDocument(String uri) async {
    http.Response response = await http.get(uri);
    return response.body;
  }
}
