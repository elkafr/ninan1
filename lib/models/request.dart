class Request {
  String requestDate;
  String requestId;
  String requestMtger;
  String requestBank;
  String requestBankName;
  String requestName;
  String requestNumber;
  String requestType;
  String requestActive;
  String requestBy;
  String requestValue;

  Request({
    this.requestDate,
    this.requestId,
    this.requestMtger,
    this.requestBank,
    this.requestBankName,
    this.requestName,
    this.requestNumber,
    this.requestType,
    this.requestActive,
    this.requestBy,
    this.requestValue
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    requestDate: json["request_date"],
    requestId: json["request_id"],
    requestMtger: json["request_mtger"],
    requestBank: json["request_bank"],
    requestBankName: json["request_bank_name"],
    requestName: json["request_name"],
    requestNumber: json["request_number"],
    requestType: json["request_type"],
    requestActive: json["request_active"],
    requestBy: json["request_by"],
    requestValue: json["request_value"],
  );

  Map<String, dynamic> toJson() => {
    "request_date": requestDate,
    "request_id": requestId,
    "request_mtger": requestMtger,
    "request_bank": requestBank,
    "request_bank_name": requestBankName,
    "request_name": requestName,
    "request_number": requestNumber,
    "request_type": requestType,
    "request_active": requestActive,
    "request_by": requestBy,
    "request_value": requestValue,
  };
}
