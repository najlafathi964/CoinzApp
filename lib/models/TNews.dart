import 'dart:convert';

class TNews {
  Pagination? pagination;
  List<News>? news;

  TNews({this.pagination, this.news});

  TNews.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
  }

}

class Pagination {
  int? iTotalObjects;
  int? iItemsOnPage;
  int? iPerPages;
  int? iCurrentPage;
  int? iTotalPages;

  Pagination(
      {this.iTotalObjects,
        this.iItemsOnPage,
        this.iPerPages,
        this.iCurrentPage,
        this.iTotalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    iTotalObjects = json['i_total_objects'];
    iItemsOnPage = json['i_items_on_page'];
    iPerPages = json['i_per_pages'];
    iCurrentPage = json['i_current_page'];
    iTotalPages = json['i_total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i_total_objects'] = this.iTotalObjects;
    data['i_items_on_page'] = this.iItemsOnPage;
    data['i_per_pages'] = this.iPerPages;
    data['i_current_page'] = this.iCurrentPage;
    data['i_total_pages'] = this.iTotalPages;
    return data;
  }
}

class News {
  int? pkIId;
  String? sTitle;
  String? sImage;
  String? sDescription;
  bool? bEnabled;
  String? dtCreatedDate;
  String? dtModifiedDate;
  Null? dtDeletedDate;

  News(
      {this.pkIId,
        this.sTitle,
        this.sImage,
        this.sDescription,
        this.bEnabled,
        this.dtCreatedDate,
        this.dtModifiedDate,
        this.dtDeletedDate});

  News.fromJson(Map<String, dynamic> json) {
    pkIId = json['pk_i_id'];
    sTitle = json['s_title'];
    sImage = json['s_image'];
    sDescription = json['s_description'];
    bEnabled = json['b_enabled'];
    dtCreatedDate = json['dt_created_date'];
    dtModifiedDate = json['dt_modified_date'];
    dtDeletedDate = json['dt_deleted_date'];
  }

  static Map<String, dynamic> toJson(News news) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_i_id'] = news.pkIId;
    data['s_title'] = news.sTitle;
    data['s_image'] = news.sImage;
    data['s_description'] = news.sDescription;
    data['b_enabled'] = news.bEnabled;
    data['dt_created_date'] = news.dtCreatedDate;
    data['dt_modified_date'] = news.dtModifiedDate;
    data['dt_deleted_date'] = news.dtDeletedDate;
    return data;
  }

  static String encode(List<News> news) =>json.encode(news
      .map<Map<String,dynamic>>((news) => News.toJson(news)).toList()) ;

  static List<News> decode(String news) => (json.decode(news) as List<dynamic>)
      .map<News>((item) => News.fromJson(item)).toList();
}