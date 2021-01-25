package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferRequestType;
import com.abacorp.aba.model.type.RequiredConditionType;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.Builder;

import java.util.List;

@Data
@Builder
@EqualsAndHashCode
@ToString
public class OfferRequest extends ModelMapper {
    private DealType dealType;
    private String offerRequestTypes;
    private String deposit;
    private String monthlyDeposit;
    private String monthlyPrice;
    private String salePrice;
    private String moveIn;
    private String room;
    private String floor;
    private String pyeong;
    private String location;
    private String requiredConditions;
    private String demand;
    private String phone;
    @Builder.Default
    private int hits = 0;
    @JsonProperty("isAgree")
    private boolean isAgree;

    private String latitude;
    private String longitude;
    private String latitude2;
    private String longitude2;

    private List<RequiredConditionType> conditionTypeList;
    private List<OfferRequestType> offerTypeList;
}
