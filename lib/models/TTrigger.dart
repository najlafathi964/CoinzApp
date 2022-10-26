class TTrigger {
  Pagination? pagination;
  List<Condition>? condition;

  TTrigger({this.pagination, this.condition});

  TTrigger.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['condition'] != null) {
      condition = <Condition>[];
      json['condition'].forEach((v) {
        condition!.add(new Condition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition!.map((v) => v.toJson()).toList();
    }
    return data;
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

class Condition {
  int? pkIId;
  String? sCode;
  String? sName;
  String? dValue;
  String? iType;
  String? sIcon;
  bool? bEnabled;
  String? dtCreatedDate;
  String? dtModifiedDate;
  Null? dtDeletedDate;

  Condition(
      {this.pkIId,
        this.sCode,
        this.sName,
        this.dValue,
        this.iType,
        this.sIcon,
        this.bEnabled,
        this.dtCreatedDate,
        this.dtModifiedDate,
        this.dtDeletedDate});

  Condition.fromJson(Map<String, dynamic> json) {
    pkIId = json['pk_i_id'];
    sCode = json['s_code'];
    sName = json['s_name'];
    dValue = json['d_value'];
    iType = json['i_type'];
    sIcon = json['s_icon'];
    bEnabled = json['b_enabled'];
    dtCreatedDate = json['dt_created_date'];
    dtModifiedDate = json['dt_modified_date'];
    dtDeletedDate = json['dt_deleted_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_i_id'] = this.pkIId;
    data['s_code'] = this.sCode;
    data['s_name'] = this.sName;
    data['d_value'] = this.dValue;
    data['i_type'] = this.iType;
    data['s_icon'] = this.sIcon;
    data['b_enabled'] = this.bEnabled;
    data['dt_created_date'] = this.dtCreatedDate;
    data['dt_modified_date'] = this.dtModifiedDate;
    data['dt_deleted_date'] = this.dtDeletedDate;
    return data;
  }
}