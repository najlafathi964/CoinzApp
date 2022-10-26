import 'dart:convert';

class TCoinz {
  Pagination? pagination;
  List<Currencies>? currencies;

  TCoinz({this.pagination, this.currencies});

  TCoinz.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(new Currencies.fromJson(v));
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

class Currencies {
  int? pkIId;
  String? sCode;
  String? sName;
  String? dValue;
  String? dTrading;
  String? sIcon;
  bool? bEnabled;
  String? dtCreatedDate;
  String? dtModifiedDate;
  Null? dtDeletedDate;

  Currencies(
      {this.pkIId,
        this.sCode,
        this.sName,
        this.dValue,
        this.dTrading,
        this.sIcon,
        this.bEnabled,
        this.dtCreatedDate,
        this.dtModifiedDate,
        this.dtDeletedDate});

  Currencies.fromJson(Map<String, dynamic> json) {
    pkIId = json['pk_i_id'];
    sCode = json['s_code'];
    sName = json['s_name'];
    dValue = json['d_value'];
    dTrading = json['d_trading'];
    sIcon = json['s_icon'];
    bEnabled = json['b_enabled'];
    dtCreatedDate = json['dt_created_date'];
    dtModifiedDate = json['dt_modified_date'];
    dtDeletedDate = json['dt_deleted_date'];
  }

  static Map<String, dynamic> toJson(Currencies currencies) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_i_id'] = currencies.pkIId;
    data['s_code'] = currencies.sCode;
    data['s_name'] = currencies.sName;
    data['d_value'] = currencies.dValue;
    data['d_trading'] = currencies.dTrading;
    data['s_icon'] = currencies.sIcon;
    data['b_enabled'] = currencies.bEnabled;
    data['dt_created_date'] = currencies.dtCreatedDate;
    data['dt_modified_date'] = currencies.dtModifiedDate;
    data['dt_deleted_date'] = currencies.dtDeletedDate;
    return data;
  }

  static String encode(List<Currencies> currencies) =>json.encode(currencies
      .map<Map<String,dynamic>>((currencies) => Currencies.toJson(currencies)).toList()) ;

  static List<Currencies> decode(String currencies) => (json.decode(currencies) as List<dynamic>)
      .map<Currencies>((item) => Currencies.fromJson(item)).toList();
}