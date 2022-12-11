class NotificationItem {
    String id;
    String title;
    String titleEn;
    String body;
    String bodyEn;
    String view;
    String createdAt;
    String messageAds;
    String messageSender;

    NotificationItem({
        this.id,
        this.title,
        this.titleEn,
        this.body,
        this.bodyEn,
        this.view,
        this.createdAt,
        this.messageAds,
        this.messageSender,
    });

    factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
        id: json["id"],
        title: json["title"],
        titleEn: json["title_en"],
        body: json["body"],
        bodyEn: json["body_en"],
        view: json["view"],
        createdAt: json["created_at"],
        messageAds: json["message_ads"],
        messageSender: json["message_sender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "title_en": titleEn,
        "body": body,
        "body_en": bodyEn,
        "view": view,
        "created_at": createdAt,
        "message_ads": messageAds,
        "message_sender": messageSender,
    };
}
