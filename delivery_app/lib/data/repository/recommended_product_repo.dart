import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient}); //  Lớp PopularProductRepo nhận một đối tượng ApiClient làm tham số trong constructor. Điều này đại diện cho việc PopularProductRepo sẽ sử dụng ApiClient để gửi yêu cầu API và tương tác với dữ liệu từ API. Tham số này được đánh dấu là "required," nghĩa là bạn phải cung cấp một đối tượng

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}