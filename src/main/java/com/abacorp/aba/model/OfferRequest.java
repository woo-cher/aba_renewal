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
    private OfferType offerType;
    private String deposit;
    private String salePrice;
    private String moveIn;
    private String room;
    private String pyeong;
    private String location1;
    private String location2;
    private String requiredConditions;
    private String request;
    private String phone;
    private String name;
    @JsonProperty("isAgree")
    private boolean isAgree;
}
