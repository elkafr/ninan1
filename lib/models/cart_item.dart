class CartItem {
    String title;
    String cartId;
    int cartPrice;
    int cartAmount;
    int price;
    String adsMtgerPhoto;

    CartItem({
        this.title,
        this.cartId,
        this.cartPrice,
        this.cartAmount,
        this.price,
        this.adsMtgerPhoto,
    });

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        title: json["title"],
        cartId: json["cart_id"],
        cartPrice: json["cart_price"],
        cartAmount: json["cart_amount"],
        price: json["price"],
        adsMtgerPhoto: json["ads_mtger_photo"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "cart_id": cartId,
        "cart_price": cartPrice,
        "cart_amount": cartAmount,
        "price": price,
        "ads_mtger_photo": adsMtgerPhoto,
    };
}