class Cart {
    String title;
    String cartId;
    String cartTime;
    int cartPrice;
    int cartAmount;
    int price;
    int priceWithAditions;
    String adsMtgerId;
    String adsMtgerPhoto;
    String cartMtger;

    Cart({
        this.title,
        this.cartId,
        this.cartTime,
        this.cartPrice,
        this.cartAmount,
        this.price,
        this.priceWithAditions,
        this.adsMtgerId,
        this.adsMtgerPhoto,
        this.cartMtger,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        title: json["title"],
        cartId: json["cart_id"],
        cartTime: json["cart_time"],
        cartPrice: json["cart_price"],
        cartAmount: json["cart_amount"],
        price: json["price"],
        priceWithAditions: json["price_with_aditions"],
        adsMtgerId: json["ads_mtger_id"],
        adsMtgerPhoto: json["ads_mtger_photo"],
        cartMtger: json["cart_mtger"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "cart_id": cartId,
        "cart_time": cartTime,
        "cart_price": cartPrice,
        "cart_amount": cartAmount,
        "price": price,
        "price_with_aditions": priceWithAditions,
        "ads_mtger_id": adsMtgerId,
        "ads_mtger_photo": adsMtgerPhoto,
        "cart_mtger": cartMtger,
    };
}
