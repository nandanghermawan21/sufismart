import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/imagenews_model.dart';
import 'package:sufismart/model/imagepromo_model.dart';
import 'package:sufismart/model/news_detail_model.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/product_model.dart';
import 'package:sufismart/model/productlist_model.dart';
import 'package:sufismart/model/producttype_model.dart';
import 'package:sufismart/model/promo_model.dart';

class Api extends ChangeNotifier {
  static const endpoint = 'http://172.60.3.23/sufismart_ci/api/';
  //static const endpoint = 'http://192.168.0.164:81/api/';
  var client = http.Client();
  static const _timeout = 20;

  // void error(String text,BuildContext context){
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text("$text"),
  //     ));

  // }
  Future<List<BannerModel>> getBanner(BuildContext context) async {
    try {
      final response = await client.get(endpoint + 'getBannerList', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<BannerModel> listData =
            data.map((map) => BannerModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ImgPromoModel>> getImgPromoHome(BuildContext context) async {
    try {
      final response = await client.get(endpoint + 'getImgPromo', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<ImgPromoModel> listData =
            data.map((map) => ImgPromoModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ImgNewsModel>> getImgNewsHome(BuildContext context) async {
    try {
      final response = await client.get(endpoint + 'getImgNews', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<ImgNewsModel> listData =
            data.map((map) => ImgNewsModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //promo

  Future<List<PromoModel>> getPromo(BuildContext context) async {
    try {
      final response = await client.get(endpoint + 'getPromoNew', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<PromoModel> listData =
            data.map((map) => PromoModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //news
  Future<List<NewsModel>> getNews(BuildContext context) async {
    try {
      final response = await client.get(endpoint + 'getNewsNew', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<NewsModel> listData =
            data.map((map) => NewsModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  //detail news
  Future<DataDetailNews> getDetailNews(
      BuildContext context, String newsid) async {
    String url = endpoint + 'getDetailNews/' + newsid;
    print('$url');
    try {
      final response =
          await client.get(endpoint + 'getDetailNews/' + newsid, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        final Map parsed = json.decode(response.body)['data'];
        final dataNews = DataDetailNews.fromJson(parsed);
        return dataNews;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      //errorPage("error", "getAddressDetail", e.toString(), context);
    }
  }

  //product
  Future<List<ProductModel>> getProduct(BuildContext context) async {
    try {
      final response =
          await client.get(endpoint + 'getProductCategory', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<ProductModel> listData =
            data.map((map) => ProductModel.fromjson(map)).toList();
        return listData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ProductListModel>> getProductList(
      BuildContext context, String category) async {
    try {
      final response =
          await client.get(endpoint + 'getProductList/' + category, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<ProductListModel> listdata =
            data.map((map) => ProductListModel.fromJson(map)).toList();
        return listdata;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ProductTypeModel>> getProductType(
      BuildContext context, String productCode) async {
    try {
      final response = await client
          .get(endpoint + 'getProductType/' + productCode, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }).timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable data = json.decode(response.body)['data'];
        List<ProductTypeModel> listdata =
            data.map((map) => ProductTypeModel.fromJson(map)).toList();
        return listdata;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    // var map = new Map<String, dynamic>();
    //   map['email'] = email;
    //   map['pass'] = password;
    //   print(map);
    Map<String, dynamic> data = {"email": email, "pass": password};
    try {
      Response response;
      Dio dio = new Dio();
      FormData formData = FormData.fromMap(data);
      // FormData data = FormData.fromMap({
      //   "email": email,
      //   "password": password,
      // });
      //  final response = await client.post(endpoint+"action_login",
      //     headers: {
      //       "Content-Type": "application/json",
      //       //"Accept": "application/json",
      //     }, body: json.encode({
      //       "email": email,
      //       "pass": password
      //     })          //encoding: Encoding.getByName("application/json")
      // ).timeout(const Duration (seconds:_timeout));
      var headers = {
        "Content-Type": "multipart/form-data",
      };

      response = await dio
          .post(endpoint + "action_login",
              data: formData,
              options: Options(
                headers: headers,
                // followRedirects: false,
              ))
          .timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        if (response.data['isSuccess'] == true) {
          // print(response.data['message']);
          // print(response.data['data']['name']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              'username', response.data['data']['email'].toString());
          prefs.setString('is_login', 'true');
          print("user ada");
          print("status : " + response.data['data']['status'].toString());
          print("name : " + response.data['data']['name'].toString());
          print("pesan : " + response.data['message'].toString());
          return true;
        } else {
          print("user tidak ada");
          print(response.data['message']);
          // String message = json.decode(response.body)['message'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // print("status : "+json.decode(response.body)['data']['status'].toString());
          // print("name : "+json.decode(response.body)['data']['name'].toString());
          // print("pesan : "+json.decode(response.body)['data']['message'].toString());
          prefs.setString('message', response.data['message']);
          prefs.setString('is_login', '');
          print("status : " + response.data['data']['status'].toString());
          print("name : " + response.data['data']['name'].toString());
          print("pesan : " + response.data['message'].toString());
          return false;
        }
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> insertRegistrasi(
      String namalengkap,
      String nohp,
      String tanggallahir,
      String email,
      String password,
      String pekerjaan,
      String gender,
      BuildContext context) async {
    Map<String, dynamic> data = {
      "namalengkap": namalengkap,
      "nohp": nohp,
      "email": email,
      "pass": password,
      "tgllahir": tanggallahir,
      "pekerjaan": pekerjaan,
      "gender": gender
    };

    try {
      Response response;
      Dio dio = new Dio();
      FormData formData = FormData.fromMap(data);
      var headers = {
        "Content-Type": "multipart/form-data",
      };

      response = await dio
          .post(endpoint + "action_registrasi",
              data: formData,
              options: Options(
                headers: headers,
                // followRedirects: false,
              ))
          .timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        if (response.data['isSuccess'] == true) {
          print(response.data['message']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message_regis', response.data['message']);
          return true;
        } else {
          print(response.data['message']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message_regis', response.data['message']);
          //error(response.data['message'].toString(), context);
          return false;
        }
      } else {
        print(response.statusCode);
        //error(response.statusCode.toString(), context);
        return false;
      }
    } catch (e) {
      print(e);
      //error(e.toString(), context);
      return false;
    }
  }

  Future<bool> insertKeluhan(String nama, String email, String nohp,
      String pesan, BuildContext context) async {
    Map<String, dynamic> data = {
      "nama": nama,
      "email": email,
      "phone": nohp,
      "pesan": pesan
    };

    try {
      Response response;
      Dio dio = new Dio();
      FormData formData = FormData.fromMap(data);
      var headers = {
        "Content-Type": "multipart/form-data",
      };
      response = await dio
          .post(endpoint + "action_keluhan",
              data: formData,
              options: Options(
                headers: headers,
                // followRedirects: false,
              ))
          .timeout(const Duration(seconds: _timeout));
      if (response.statusCode == 200) {
        if (response.data['isSuccess'] == true) {
          return true;
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', response.data['message']);
          return false;
        }
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

// json.encode({
//             "email": email,
//             "pass": password
//           })

}
