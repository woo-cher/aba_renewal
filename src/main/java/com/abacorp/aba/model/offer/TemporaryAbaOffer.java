package com.abacorp.aba.model.offer;

import lombok.*;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class TemporaryAbaOffer {
    private int id; // 매물번호
    private String title; // 기존 제목

    private String area2; // 시
    private String area1; // 도
    private String addr; // 동
    private String addr2; // 지번
    private String juso1; // 도로명
    private String juso2; // 도로번호

    private String mPhone; // 연락처
    private String mPhone2; // 연락처2
    private String mPhone3; // 연락처3
    private String remark;
    private String remarkMemo;
    private String jibunAddrEtc; // 건물명
    private String pyeong;
    private String make;

    private String etc2; // 매물상태
    private String gubun; // 오퍼타입
    private String etc1; // 거래타입

    private String hot; // 난방유형
    private String input4; // 난방방식

    private Timestamp date; // 확인일

    private String input1; // 근방
    private String mLicence; // 상가 호실
    private String useArea; // 현 업종
    private String mArea; // 상가 비밀번호

    private String zone1; // 매매 일때 준공년도

    private String extra4; // 입구 / 엘베여부
    private String extra5; // 전체층 / 아파트 해당층
    private String extra6; // 부가정보
    private String extra7; // 아파트 세입자여부 / 상가 층정보
    private String extra8; // 준공년도 or
    private String extra9; // 확장여부
    private String extra10; // 즉시입주일 /
    private String extra11; // 세입자
    private String dong; // 동
    private String extra12; // 호
    private String extra13; // 호실암호
    private String extra14; // 애완가능여부
    private String extra15; // 주차여부

    private String latitude;
    private String longitude;

    private String options;
    private String managementCategories;

    private String salePrice;
    private String deposit;

    private String monthly;
    private String investmentPrice;
    private String manageOrProfit;
    private String aptLoan;
    private String loan;

    /* APT */
    private String park;
    private String totalNum;
    private String floor1;
    private String direction;
    private String tongro;
    private String price7;
    private String room_num;
    private String cool;

    private String videoUrl;
    private String images;
}
