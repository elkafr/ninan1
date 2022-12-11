class Store {
    String mtgerId;
    String mtgerName;
    String mtgerNameEn;
    String mtgerEmail;
    String mtgerPhone;
    String mtgerSgl;
    String mtgerCharge;
    String mtgerCat;
    String mtgerCatName;
    String mtgerSub;
    String mtgerType;
    String mtgerRegister;
    String mtgerAdress;
    String mtgerAdressEn;
    String mtgerMapx;
    String mtgerMapy;
    String mtgerRate;
    String mtgerRateNumber;
    String userMapx;
    String userMapy;
    int distance;
    String state;
    String mtgerState;
    String deliveryType;
    String deliveryFree;
    String deliveryPrice;
    int fromTime;
    int toTime;
    int isAddToFav;
    String mtgerPhoto;
    String mtgerPhoto1;
    String mtgerSglPhoto;
    int storeCartValue;

    Store({
        this.mtgerId,
        this.mtgerName,
        this.mtgerNameEn,
        this.mtgerEmail,
        this.mtgerPhone,
        this.mtgerSgl,
        this.mtgerCharge,
        this.mtgerCat,
        this.mtgerCatName,
        this.mtgerSub,
        this.mtgerType,
        this.mtgerRegister,
        this.mtgerAdress,
        this.mtgerAdressEn,
        this.mtgerMapx,
        this.mtgerMapy,
        this.mtgerRate,
        this.mtgerRateNumber,
        this.userMapx,
        this.userMapy,
        this.distance,
        this.state,
        this.mtgerState,
        this.deliveryType,
        this.deliveryFree,
        this.deliveryPrice,
        this.fromTime,
        this.toTime,
        this.isAddToFav,
        this.mtgerPhoto,
        this.mtgerPhoto1,
        this.mtgerSglPhoto,
        this.storeCartValue
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        mtgerId: json["mtger_id"],
        mtgerName: json["mtger_name"],
        mtgerNameEn: json["mtger_name_en"],
        mtgerEmail: json["mtger_email"],
        mtgerPhone: json["mtger_phone"],
        mtgerSgl: json["mtger_sgl"],
        mtgerCharge: json["mtger_charge"],
        mtgerCat: json["mtger_cat"],
        mtgerCatName: json["mtger_cat_name"],
        mtgerSub: json["mtger_sub"],
        mtgerType: json["mtger_type"],
        mtgerRegister: json["mtger_register"],
        mtgerAdress: json["mtger_adress"],
        mtgerAdressEn: json["mtger_adress_en"],
        mtgerMapx: json["mtger_mapx"],
        mtgerMapy: json["mtger_mapy"],
        mtgerRate: json["mtger_rate"],
        mtgerRateNumber: json["mtger_rate_number"],
        userMapx: json["user_mapx"],
        userMapy: json["user_mapy"],
        distance: json["distance"],
        state: json["state"],
        mtgerState: json["mtger_state"],
        deliveryType: json["delivery_type"],
        deliveryFree: json["delivery_free"],
        deliveryPrice: json["delivery_price"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        isAddToFav: json["is_add_to_fav"],
        mtgerPhoto: json["mtger_photo"],
        mtgerPhoto1: json["mtger_photo1"],
        mtgerSglPhoto: json["mtger_sgl_photo"],
        storeCartValue: json["store_cart_value"],
    );

    Map<String, dynamic> toJson() => {
        "mtger_id": mtgerId,
        "mtger_name": mtgerName,
        "mtger_name_en": mtgerNameEn,
        "mtger_email": mtgerEmail,
        "mtger_phone": mtgerPhone,
        "mtger_sgl": mtgerSgl,
        "mtger_charge": mtgerCharge,
        "mtger_cat": mtgerCat,
        "mtger_cat_name": mtgerCatName,
        "mtger_sub": mtgerSub,
        "mtger_type": mtgerType,
        "mtger_register":mtgerRegister,
        "mtger_adress":mtgerAdress,
        "mtger_adress_en":mtgerAdressEn,
        "mtger_mapx":mtgerMapx,
        "mtger_mapy":mtgerMapy,
        "mtger_rate":mtgerRate,
        "mtger_rate_number":mtgerRateNumber,
        "user_mapx":userMapx,
        "user_mapy":userMapy,
        "distance":distance,
        "state":state,
        "mtger_state":mtgerState,
        "delivery_type":deliveryType,
        "delivery_free":deliveryFree,
        "delivery_price":deliveryPrice,
        "from_time":fromTime,
        "to_time":toTime,
        "is_add_to_fav":isAddToFav,
        "mtger_photo":mtgerPhoto,
        "mtger_photo1":mtgerPhoto1,
        "mtger_sgl_photo":mtgerSglPhoto,
        "store_cart_value":storeCartValue,
    };
}