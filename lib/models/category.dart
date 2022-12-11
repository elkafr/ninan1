class Category {
    String mtgerCatId;
    String mtgerCatName;
    String mtgerCatNameEn;
    String mtgerCatPhoto;
    String mtgerCatType;
    String mtgerCatDetails;
    String mtgerCatShow;
      bool isSelected =  false;

    Category({
        this.mtgerCatId,
        this.mtgerCatName,
        this.mtgerCatNameEn,
        this.mtgerCatPhoto,
        this.mtgerCatType,
        this.mtgerCatDetails,
        this.mtgerCatShow,
        this.isSelected
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        mtgerCatId: json["mtger_cat_id"],
        mtgerCatName: json["mtger_cat_name"],
        mtgerCatNameEn: json["mtger_cat_name_en"],
        mtgerCatPhoto: json["mtger_cat_photo"],
        mtgerCatType: json["mtger_cat_type"],
        mtgerCatDetails: json["mtger_cat_details"],
        mtgerCatShow: json["mtger_cat_show"],
        isSelected: false
    );

    Map<String, dynamic> toJson() => {
        "mtger_cat_id": mtgerCatId,
        "mtger_cat_name": mtgerCatName,
        "mtger_cat_name_en": mtgerCatNameEn,
        "mtger_cat_photo": mtgerCatPhoto,
        "mtger_cat_type": mtgerCatType,
        "mtger_cat_details": mtgerCatDetails,
        "mtger_cat_show": mtgerCatShow,
    };
}