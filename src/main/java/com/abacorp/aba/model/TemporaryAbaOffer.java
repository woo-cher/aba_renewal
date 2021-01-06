package com.abacorp.aba.model;

import lombok.*;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class TemporaryAbaOffer {
    private int id;                 // 매물번호
    private String si;
    private String dou;
    private String dong;
    private String jibunAddr;
    private String roadName;
    private String roadNum;
    private String tel;
    private String memo;
    private String building;
    private String pyeong;

    private String statusCode;
    private String heatingType;
    private String hitMethod;

    private Timestamp checkDate;

    private String near;
    private String addedInfo;
    private String completionYear;
    private String tenant;
    private String room;
    private String pet;

    private String offerTypeCode;
    private String latitude;
    private String longitude;

    private String options;
    private String managementCategories;

    private String salePrice;
    private String deposit;

    private String monthly;
    private String manageOrProfit;

    private String img1;
    private String img2;
    private String img3;
    private String img4;
    private String img5;
    private String img6;
    private String img7;
    private String img8;
    private String img9;
    private String img10;
    private String img11;
    private String img12;
    private String img13;
    private String img14;
    private String img15;
    private String img16;
    private String img17;
    private String img18;
    private String img19;
    private String img20;
}
