package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.RequiredConditionType;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
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
    private String pyeong;
    private String location;
    private String requiredConditions;
    private String demand;
    private String phone;
    @Builder.Default
    private int hits = 0;
    @JsonProperty("isAgree")
    private boolean isAgree;

    private List<RequiredConditionType> conditionTypeList;
    private List<OfferType> offerTypeList;
}
