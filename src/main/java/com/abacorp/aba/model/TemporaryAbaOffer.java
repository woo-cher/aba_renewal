package com.abacorp.aba.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import lombok.*;

import java.sql.Timestamp;
import java.util.List;

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
    private String enter;
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

    private String images;
}
