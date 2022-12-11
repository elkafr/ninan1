class Order {
    String carttMtgerId;
    String carttMtgerName;
    String carttMtgerPhoto;
    String mtgerMapx;
    String mtgerMapy;
    String mtgerAdress;
    int   carttMtgerRate;
    String carttNumber;
    String carttFatora;
    String carttSeller;
    String carttDate;
    String carttState;
    String carttStateNumber;
    String carttStateId;
    String carttTotal;
    String carttTawsilDate;
    String carttTawsilTime;
    String carttLocation;
    String carttDeliveryType;
    String carttNotes;
    String deliveryPrice;
    String fromTime;
    String toTime;
    String carttType;
    String carttTypeId;
    String rateToMtger;

    String carttDriver;
    String driverName;
    String driverEmail;
    String driverPhone;
    String driverMapx;
    String driverMapy;
    String driverPhoto;

    String clientId;
    String clientPhoto;
    String clientAdress;
    String clientName;
    String clientEmail;
    String clientPhone;
    String userMapx;
    String userMapy;

    int distance;
    int distance1;


    List<CarttDetail> carttDetails;

    Order({
        this.carttMtgerId,
        this.carttMtgerName,
        this.carttMtgerPhoto,
        this.mtgerMapx,
        this.mtgerMapy,
        this.mtgerAdress,
        this.carttMtgerRate,
        this.carttNumber,
        this.carttFatora,
        this.carttSeller,
        this.carttDate,
        this.carttState,
        this.carttStateNumber,
        this.carttStateId,
        this.carttTotal,
        this.carttTawsilDate,
        this.carttTawsilTime,
        this.carttLocation,
        this.carttDeliveryType,
        this.carttNotes,
        this.deliveryPrice,
        this.fromTime,
        this.toTime,
        this.carttType,
        this.carttTypeId,
        this.rateToMtger,

        this.carttDriver,
        this.driverName,
        this.driverEmail,
        this.driverPhone,
        this.driverMapx,
        this.driverMapy,
        this.driverPhoto,

        this.clientId,
        this.clientPhoto,
        this.clientAdress,
        this.clientName,
        this.clientEmail,
        this.clientPhone,
        this.userMapx,
        this.userMapy,

        this.distance,
        this.distance1,

        this.carttDetails,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        carttMtgerId: json["cartt_mtger_id"],
        carttMtgerName: json["cartt_mtger_name"],
        carttMtgerPhoto: json["cartt_mtger_photo"],
        mtgerMapx: json["mtger_mapx"],
        mtgerMapy: json["mtger_mapy"],
        mtgerAdress: json["mtger_adress"],
        carttMtgerRate: json["cartt_mtger_rate"],
        carttNumber: json["cartt_number"],
        carttFatora: json["cartt_fatora"],
        carttSeller: json["cartt_seller"],
        carttDate: json["cartt_date"],
        carttState: json["cartt_state"],
        carttStateNumber: json["cartt_state_number"],
        carttStateId: json["cartt_state_id"],
        carttTotal: json["cartt_totlal"],
        carttTawsilDate: json["cartt_tawsil_date"],
        carttTawsilTime: json["cartt_tawsil_time"],
        carttLocation: json["cartt_location"],
        carttDeliveryType: json["cartt_delivery_type"],
        carttNotes: json["cartt_notes"],
        deliveryPrice: json["delivery_price"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        carttType: json["cartt_type"],
        carttTypeId: json["cartt_type_id"],
        rateToMtger: json["rate_to_mtger"],

        carttDriver: json["cartt_driver"],
        driverName: json["driver_name"],
        driverEmail: json["driver_email"],
        driverPhone: json["driver_phone"],
        driverMapx: json["driver_mapx"],
        driverMapy: json["driver_mapy"],
        driverPhoto: json["driver_photo"],

        clientId: json["client_id"],
        clientPhoto: json["client_photo"],
        clientAdress: json["client_adress"],
        clientName: json["client_name"],
        clientEmail: json["client_email"],
        clientPhone: json["client_phone"],
        userMapx: json["user_mapx"],
        userMapy: json["user_mapy"],

        distance: json["distance"],
        distance1: json["distance1"],

        carttDetails: List<CarttDetail>.from(json["cartt_details"].map((x) => CarttDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cartt_mtger_id": carttMtgerId,
        "cartt_mtger_name": carttMtgerName,
        "cartt_mtger_photo": carttMtgerPhoto,
        "mtger_mapx": mtgerMapx,
        "mtger_mapy": mtgerMapy,
        "mtger_adress": mtgerAdress,
        "cartt_mtger_rate": carttMtgerRate,
        "cartt_number": carttNumber,
        "cartt_fatora": carttFatora,
        "cartt_seller": carttSeller,
        "cartt_date": carttDate,
        "cartt_state": carttState,
        "cartt_state_number": carttStateNumber,
        "cartt_state_id": carttStateId,
        "cartt_totlal": carttTotal,
        "cartt_tawsil_date": carttTawsilDate,
        "cartt_tawsil_time": carttTawsilTime,
        "cartt_location": carttLocation,
        "cartt_delivery_type": carttDeliveryType,
        "cartt_notes": carttNotes,
        "delivery_price": deliveryPrice,
        "from_time": fromTime,
        "to_time": toTime,
        "cartt_type": carttType,
        "cartt_type_id": carttTypeId,
        "rate_to_mtger": rateToMtger,

        "cartt_driver": carttDriver,
        "driver_name": driverName,
        "driver_email": driverEmail,
        "driver_phone": driverPhone,
        "driver_mapx": driverMapx,
        "driver_mapy": driverMapy,
        "driver_photo": driverPhoto,

        "client_id": clientId,
        "client_photo": clientPhoto,
        "client_adress": clientAdress,
        "client_name": clientName,
        "client_email": clientEmail,
        "client_phone": clientPhone,
        "user_mapx": userMapx,
        "user_mapy": userMapy,

        "distance": distance,
        "distance1": distance1,

        "cartt_details": List<dynamic>.from(carttDetails.map((x) => x.toJson())),
    };
}

class CarttDetail {
    String carttName;
    int carttAmount;
    String carttPrice;
    int carttAds;
    String carttPhoto;
    String carttDetails;

    CarttDetail({
        this.carttName,
        this.carttAmount,
        this.carttPrice,
        this.carttPhoto,
        this.carttAds,
        this.carttDetails
    });

    factory CarttDetail.fromJson(Map<String, dynamic> json) => CarttDetail(
        carttName: json["cartt_name"],
        carttAmount: json["cartt_amount"],
        carttPrice: json["cartt_price"],
        carttPhoto: json["cartt_photo"],
        carttAds:json["cartt_ads"],
        carttDetails:json["cartt_details"]
    );

    Map<String, dynamic> toJson() => {
        "cartt_name": carttName,
        "cartt_amount": carttAmount,
        "cartt_price": carttPrice,
        "cartt_photo" :carttPhoto,
        "cartt_ads":carttAds,
        "cartt_details":carttDetails
    };
}
