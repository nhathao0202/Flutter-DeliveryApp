import 'package:delivery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../model/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = []; //chứa danh sách
  List<ProductModel> get popularProductList => _popularProductList; //popularProductList để truy cập danh sách _popularProductList

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> getPopularProductList() async{
    Response response =await popularProductRepo.getPopularProductList(); // Gửi yêu cầu đến *popularProductRepo* để lấy danh sách
    if(response.statusCode == 200) { //kiểm tra xem mã trạng thái của phản hồi từ API có phải là 200 không. Mã trạng thái 200 thường đại diện cho một phản hồi thành công từ API, nghĩa là dữ liệu đã được tải về thành công.
      _popularProductList = []; // Nếu mã trạng thái là 200, thì danh sách _popularProductList trong PopularProductController được khởi tạo lại bằng một danh sách trống (rỗng), tức là xóa tất cả dữ liệu cũ.
      _popularProductList.addAll(Product.fromJson(response.body).products); // lấy dữ liệu từ Product thêm vào danh sách (_popularProductList) bằng phương thức addAll.
      _isLoaded = true;
      update();
    }else {

    }
  }
}

//PopularProductController (Điều khiển danh sách sản phẩm phổ biến):
//
// Đây là một GetX controller được sử dụng để quản lý trạng thái của danh sách sản phẩm phổ biến.
// Constructor của nó nhận một đối tượng PopularProductRepo làm tham số và lưu trữ nó.
// Danh sách _popularProductList chứa danh sách sản phẩm phổ biến và có một phương thức getter popularProductList để truy cập danh sách này.
// Phương thức getPopularProductList làm việc với đối tượng PopularProductRepo để tải danh sách sản phẩm và cập nhật danh sách _popularProductList bằng dữ liệu tải về.