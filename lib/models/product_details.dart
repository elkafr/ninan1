class ProductDetails {
    String adsMtgerId;
    String adsMtgerName;
    String adsMtgerCat;
    String adsMtgerPrice;
    String adsMtgerContent;
    bool isAddToCart;
    String adsMtgerPhoto;
    List<MtgerDetail> mtgerDetails;

    ProductDetails({
        this.adsMtgerId,
        this.adsMtgerName,
        this.adsMtgerCat,
        this.adsMtgerPrice,
        this.adsMtgerContent,
        this.isAddToCart,
        this.adsMtgerPhoto,
        this.mtgerDetails,
    });

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        adsMtgerId: json["ads_mtger_id"],
        adsMtgerName: json["ads_mtger_name"],
        adsMtgerCat: json["ads_mtger_cat"],
        adsMtgerPrice: json["ads_mtger_price"],
        adsMtgerContent: json["ads_mtger_content"],
        isAddToCart: json["is_add_to_cart"],
        adsMtgerPhoto: json["ads_mtger_photo"],
        mtgerDetails: List<MtgerDetail>.from(json["mtger_details"].map((x) => MtgerDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ads_mtger_id": adsMtgerId,
        "ads_mtger_name": adsMtgerName,
        "ads_mtger_cat": adsMtgerCat,
        "ads_mtger_price": adsMtgerPrice,
        "ads_mtger_content": adsMtgerContent,
        "is_add_to_cart": isAddToCart,
        "ads_mtger_photo": adsMtgerPhoto,
        "mtger_details": List<dynamic>.from(mtgerDetails.map((x) => x.toJson())),
    };
}

class MtgerDetail {
    String id;
    String name;
    String photo;

    MtgerDetail({
        this.id,
        this.name,
        this.photo,
    });

    factory MtgerDetail.fromJson(Map<String, dynamic> json) => MtgerDetail(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
    };
}