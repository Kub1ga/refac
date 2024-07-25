class ApiServicesUser {
  // final String baseUrl = 'https://ceiebwrsssjftwubtxye.supabase.co/';
  final String baseUrl = 'https://rest-refac.vercel.app/';
  final String userLogin = 'api/v1/auth/login';
  final String userRegister = 'api/v1/auth/register';
  final String getUserDetail = 'api/v1/users';
  final String getKategori = 'api/v1/category';
  final String getAllService = 'api/v1/category-service';
  final String userOrder = 'api/v1/orders';

  String getDetailServiceById(int idCategoryService) {
    return 'api/v1/category-service/$idCategoryService';
  }

  String getDetailCategory(int idCategory) {
    return 'api/v1/category-service/where/$idCategory';
  }
}
