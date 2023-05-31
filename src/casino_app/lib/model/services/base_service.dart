abstract class BaseService {
  final String beerBaseUrl = "https://192.168.22.95:5001/api/";

  Future<dynamic> getResponse(String url);

}