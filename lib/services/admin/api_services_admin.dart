class ApiServicesAdmin {
  final String baseUrl = 'https://rest-refac.vercel.app/';
  final String tambahTukangServis = 'api/v1/service';
  final String getTukangServis = 'api/v1/service';
  final String createCategory = 'api/v1/category';
  final String getAllOrder = 'api/v1/orders';

  String getTukangServicesDetail(int idTukangServis) {
    return '/api/v1/service/$idTukangServis';
  }
}
