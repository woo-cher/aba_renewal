package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class OfferRequest extends ModelMapper {
    private DealType dealType;
    private String offerTypes;
    private String deposit;
    private String monthlyDeposit;
    private String monthlyPrice;
    private String salePrice;
    private String moveIn;
    private String room;
    private String pyeong;
    private String location;
    private String requiredConditions;
    private String request;
    private String phone;
    private String title;
    @Builder.Default
    private int hits = 0;
    @JsonProperty("isAgree")
    private boolean isAgree;
}
