class ApiServicesAdmin {
  final String baseUrl = 'https://rest-refac.vercel.app/';
  final String tambahTukangServis = 'api/v1/service';
  final String getTukangServis = 'api/v1/service';

  String getTukangServicesDetail(int idTukangServis) {
    return '/api/v1/service/$idTukangServis';
  }
}
