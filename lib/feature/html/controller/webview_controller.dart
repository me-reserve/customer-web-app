import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/data/provider/checker_api.dart';
import 'package:me_reserve_bem_estar/feature/html/model/pages_model.dart';
import 'package:me_reserve_bem_estar/feature/html/repository/html_repo.dart';

class HtmlViewController extends GetxController{
  final HtmlRepository htmlRepository;
  HtmlViewController({required this.htmlRepository});

  final bool _isLoading = false;
  get isLoading=> _isLoading;
  String ? _htmlPage;
  String? get htmlPage => _htmlPage;
  PagesContent? _pagesContent;
  PagesContent? get pagesContent => _pagesContent;

  Future<void> getPagesContent() async {
    Response response =await htmlRepository.getPagesContent();
    if(response.statusCode == 200){
      _pagesContent = PagesContent.fromJson(response.body['content']);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }
}
