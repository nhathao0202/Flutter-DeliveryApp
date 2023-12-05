import 'package:delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
// Khách hàng gửi yêu cầu API
class ApiClient extends GetConnect implements GetxService {
  String? token; //Biến này được sử dụng để lưu trữ token xác thực (hoặc mã thông báo) để gửi với các yêu cầu API. Token này thường được sử dụng để xác minh người dùng hoặc đăng nhập vào hệ thống. Đối tượng token có kiểu dữ liệu là chuỗi (string) và có thể là null.
  final String appBaseUrl; // Đây là URL cơ sở của ứng dụng, tức là địa chỉ gốc của API. Nó được định nghĩa trong constructor của lớp ApiClient và là một thông số bắt buộc (required) khi tạo một phiên bản của lớp.
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }
  Future<Response> getData(String uri,) async {
    try{
      Response response = await get(uri);
      return response;
    }catch(e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}