class User {
    String userId;
    String userName;
    String userEmail;
    String userPhone;
    String userCharge;
    String userPhoto;
    String userRate;
    String userReceveRequests;

    String userNameEn;
    String userCountry;
    String userCity;
    String userIdentifyNumber;
    String userBank;
    String userAcount;
    String userIban;
    String carType;
    String carNumber;
    String carLicenceNumber;
    String carLicence1Number;
    String carInsurance;
    String userIdentifyPhoto;
    String carLicencePhoto;
    String carLicence1Photo;

    User({
        this.userId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.userCharge,
        this.userPhoto,
        this.userRate,
        this.userReceveRequests,

        this.userNameEn,
        this.userCountry,
        this.userCity,
        this.userIdentifyNumber,
        this.userBank,
        this.userAcount,
        this.userIban,
        this.carType,
        this.carNumber,
        this.carLicenceNumber,
        this.carLicence1Number,
        this.carInsurance,
        this.userIdentifyPhoto,
        this.carLicencePhoto,
        this.carLicence1Photo,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userCharge: json["user_charge"],
        userPhoto: json["user_photo"],
        userRate: json["user_rate"],
        userReceveRequests: json["user_receveRequests"],

        userNameEn: json["user_name_en"],
        userCountry: json["user_country"],
        userCity: json["user_city"],
        userIdentifyNumber: json["user_identify_number"],
        userBank: json["user_bank"],
        userAcount: json["user_acount"],
        userIban: json["user_iban"],
        carType: json["car_type"],
        carNumber: json["car_number"],
        carLicenceNumber: json["car_licence_number"],
        carLicence1Number: json["car_licence1_number"],
        carInsurance: json["car_insurance"],
        userIdentifyPhoto: json["user_identify_photo"],
        carLicencePhoto: json["car_licence_photo"],
        carLicence1Photo: json["car_licence1_photo"],

    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_charge": userCharge,
        "user_photo": userPhoto,
        "user_rate": userRate,
        "user_receveRequests": userReceveRequests,

        "user_name_en": userNameEn,
        "user_country": userCountry,
        "user_city": userCity,
        "user_identify_number": userIdentifyNumber,
        "user_bank": userBank,
        "user_acount": userAcount,
        "user_iban": userIban,
        "car_type": carType,
        "car_number": carNumber,
        "car_licence_number": carLicenceNumber,
        "car_licence1_number": carLicence1Number,
        "car_insurance": carInsurance,
        "user_identify_photo": userIdentifyPhoto,
        "car_licence_photo": carLicencePhoto,
        "car_licence1_photo": carLicence1Photo,
    };
}
