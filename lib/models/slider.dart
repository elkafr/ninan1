class SliderModel {
    String offerId;
    String offerMtger;
    String offerCupone;
    String offerCuponeValue;
    String offerPhoto;

    SliderModel({
        this.offerId,
        this.offerMtger,
        this.offerCupone,
        this.offerCuponeValue,
        this.offerPhoto,
    });

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        offerId: json["offer_id"],
        offerMtger: json["offer_mtger"],
        offerCupone: json["offer_cupone"],
        offerCuponeValue: json["offer_cupone_value"],
        offerPhoto: json["offer_photo"],
    );

    Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "offer_mtger": offerMtger,
        "offer_cupone": offerCupone,
        "offer_cupone_value": offerCuponeValue,
        "offer_photo": offerPhoto,
    };
}