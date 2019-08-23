import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'NetManager.dart';

const String CONTENT_TYPE_JSON = "application";
const String CONTENT_TYPE_FORM = "x-www-form-urlencoded";
const String CONTENT_CHART_SET = 'utf-8';

enum Method {
  GET,
  POST,
  UPLOAD,
  DOWNLOAD,
}

class ResultData {
  var data;

  /// true 请求成功 false 请求失败，show data
  bool result;

  ResultData(this.data, this.result) {
    print('最后数据:$result--$data');
  }
}

class HttpService {
  final Map<String, dynamic> headers;
  final String basicUrl;
  final BaseOptions dioOptions;

  HttpService({this.headers, this.basicUrl, this.dioOptions});

  /// get请求
  get(String url,
      {Map<String, dynamic> params,
      @required Function onSuccess,
      @required Function onError}) async {
    return await request(url,
        method: Method.GET,
        params: params,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// post请求
  post(String url,
      {Map<String, dynamic> params,
      @required Function onSuccess,
      @required Function onError}) async {
    return await request(url,
        method: Method.POST,
        params: params,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// 附件上传
  upLoad(var file, String fileName, String url,
      {Map<String, dynamic> params,
      @required Function onSuccess,
      @required Function onError}) async {
    return await request(url,
        method: Method.UPLOAD,
        params: params,
        file: file,
        fileName: fileName,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// 附件下载
  download(String url, String savePath, @required Function onSuccess,
      @required Function onError) async {
    return await request(url,
        method: Method.DOWNLOAD,
        fileSavePath: savePath,
        onSuccess: onSuccess,
        onError: onError);
  }

  ///  请求部分
  request(String url,
      {Method method,
      Map<String, dynamic> params,
      var file,
      String fileName,
      String fileSavePath,
      Function onSuccess,
      Function onError}) async {
    try {
      Response response;

      NetManager manager = NetManager();
      manager.options = BaseOptions(
        // 15s 超时时间
          connectTimeout:15000,
          receiveTimeout:15000,
          responseType: ResponseType.json,
          contentType: ContentType(CONTENT_TYPE_JSON, CONTENT_TYPE_FORM,charset: CONTENT_CHART_SET),
          baseUrl: 'https://www.yuque.com/api/v2/',

      );

      if (this.headers != null) {
        manager.options.headers = headers;
      }
      if (this.basicUrl != null) {
        manager.options.baseUrl = basicUrl;
      }

      if (this.dioOptions != null) {
        manager.options = dioOptions;
      }

      print('请求' +
          '$method : ' +
          manager.options.baseUrl +
          url +
          '\nHead:${this.headers}' +
          '\nParams:$params');
      switch (method) {
        case Method.GET:
          response = await manager.get(url, queryParameters: params);
          break;
        case Method.POST:
          response = await manager.post(url, data: params);
          break;
        case Method.UPLOAD:
          {
            FormData formData = new FormData();
            if (params != null) {
              formData = FormData.from(params);
            }
            formData.add(
                "files", UploadFileInfo.fromBytes(file, fileName + '.png'));
            response = await manager.post(url, data: formData);
            break;
          }
        case Method.DOWNLOAD:
          response = await manager.download(url, fileSavePath);
          break;
      }
      return await handleDataSource(response, method, onSuccess, onError);
      //  await handleDataSource(response, method,callback);
    } catch (exception) {
      print('请求异常了');
      // return ResultData(exception.toString(), false);
      return onError(exception.toString());
    }
  }

  /// 数据处理
  static handleDataSource(
      Response response, Method method, Function onSuccess, Function onError) {
    print('数据在处理中....');

    String errorMsg = "";
    int statusCode;
    statusCode = response.statusCode;
    if (method == Method.DOWNLOAD) {
      if (statusCode == 200) {
        /// 下载成功
        // return ResultData('下载成功', true);

      } else {
        /// 下载失败
        // return ResultData('下载失败', false);
      }
    }
    //处理错误部分
    if (statusCode < 0) {
      errorMsg = "网络请求错误,状态码:" + statusCode.toString();
      // return ResultData(errorMsg, false);
      return onError(errorMsg);
    }
    try {
      return onSuccess(response.data);
      // return ResultData(response.data, true);

      /* Map data = json.decode(response.data);
      if (data['code'] == 0 ) {
        try {
          return ResultData(data['data'], true);
        }catch (exception){
          return ResultData('暂无数据', false);
        }
      }else{
        return ResultData(data['msg'], false);
      } */
    } catch (exception) {
      /* List data = json.decode(response.data);
      return ResultData(data, true); */

      // return ResultData('数据解析异常', false);
      return onError(exception.toString());
    }
  }
}
