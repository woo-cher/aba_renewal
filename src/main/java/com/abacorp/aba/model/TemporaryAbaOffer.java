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
    private String title;           // 기존 제목

    private String si;
    private String dou;
    private String dongArea;
    private String jibunAddr;
    private String roadName;
    private String roadNum;
    private String tel;
    private String description;
    private String adminMemo;
    private String building;
    private String pyeong;

    private String statusCode;
    private String offerTypeCode;
    private String dealTypeCode;

    private String heatingType;
    private String hitMethod;

    private Timestamp checkDate;

    private String near;
    private String enter;
    private String layer;
    private String aptTerm;
    private String addedInfo;
    private String completionYear;
    private String expand;
    private String term;
    private String dong;
    private String ho;
    private String tenant;
    private String room;
    private String pet;
    private String parking;

    private String latitude;
    private String longitude;

    private String options;
    private String managementCategories;

    private String salePrice;
    private String deposit;

    private String monthly;
    private String manageOrProfit;

    private String images;
}
