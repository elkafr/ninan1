class CartDetails {
    int fromTime;
    int toTime;
    int price;
    int delivery;
    int cupone;
    int mtgerPercent;
    String vat;
    int total;

    CartDetails({
        this.fromTime,
        this.toTime,
        this.price,
        this.delivery,
        this.cupone,
        this.mtgerPercent,
        this.vat,
        this.total,
    });

    factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
        fromTime: json["from_time"],
        toTime: json["to_time"],
        price: json["price"],
        delivery: json["delivery"],
        cupone: json["cupone"],
        mtgerPercent: json["mtger_percent"],
        vat: json["vat"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "from_time": fromTime,
        "to_time": toTime,
        "price": price,
        "delivery": delivery,
        "cupone": mtgerPercent,
        "vat": vat,
        "total": total,
    };
}
