class Product {
    String adsMtgerId;
    String adsMtgerName;
    String adsMtgerNameEn;
    String adsMtgerDetails;
    String adsMtgerDetailsEn;
    String adsMtgerPrice;
    dynamic adsMtgerCat;
    dynamic adsMtgerCatName;
    String adsMtgerPhoto;
    String adsMtgerActive;
    String addCart;

    Product({
        this.adsMtgerId,
        this.adsMtgerName,
        this.adsMtgerNameEn,
        this.adsMtgerDetails,
        this.adsMtgerDetailsEn,
        this.adsMtgerPrice,
        this.adsMtgerCat,
        this.adsMtgerCatName,
        this.adsMtgerPhoto,
        this.adsMtgerActive,
        this.addCart,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        adsMtgerId: json["ads_mtger_id"],
        adsMtgerName: json["ads_mtger_name"],
        adsMtgerNameEn: json["ads_mtger_name_en"],
        adsMtgerDetails: json["ads_mtger_details"],
        adsMtgerDetailsEn: json["ads_mtger_details_en"],
        adsMtgerPrice: json["ads_mtger_price"],
        adsMtgerCat: json["ads_mtger_cat"] ?? '',
        adsMtgerCatName: json["ads_mtger_cat_name"] ?? '',
        adsMtgerPhoto: json["ads_mtger_photo"],
        adsMtgerActive: json["ads_mtger_active"],
        addCart: json["add_cart"],
    );

    Map<String, dynamic> toJson() => {
        "ads_mtger_id": adsMtgerId,
        "ads_mtger_name": adsMtgerName,
        "ads_mtger_name_en": adsMtgerNameEn,
        "ads_mtger_details": adsMtgerDetails,
        "ads_mtger_details_en": adsMtgerDetailsEn,
        "ads_mtger_price": adsMtgerPrice,
        "ads_mtger_cat": adsMtgerCat,
        "ads_mtger_cat_name": adsMtgerCatName,
        "ads_mtger_photo": adsMtgerPhoto,
        "ads_mtger_active": adsMtgerActive,
        "add_cart": addCart,
    };
}