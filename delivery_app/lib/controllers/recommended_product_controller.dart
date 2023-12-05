import 'package:delivery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../model/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = []; //chứa danh sách
  List<dynamic> get recommendedProductList => _recommendedProductList; //popularProductList để truy cập danh sách _popularProductList
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> getRecommendedProductList() async{
    Response response =await recommendedProductRepo.getRecommendedProductList(); // Gửi yêu cầu đến *popularProductRepo* để lấy danh sách
    if(response.statusCode == 200) { //kiểm tra xem mã trạng thái của phản hồi từ API có phải là 200 không. Mã trạng thái 200 thường đại diện cho một phản hồi thành công từ API, nghĩa là dữ liệu đã được tải về thành công.
      _recommendedProductList = []; // Nếu mã trạng thái là 200, thì danh sách _popularProductList trong PopularProductController được khởi tạo lại bằng một danh sách trống (rỗng), tức là xóa tất cả dữ liệu cũ.
      _recommendedProductList.addAll(Product.fromJson(response.body).products); // lấy dữ liệu từ Product thêm vào danh sách (_popularProductList) bằng phương thức addAll.
      _isLoaded = true;
      update();
    }else {

    }
  }
}