package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Offer extends ModelMapper {
    private User dealer;
    private int deposit;
    private int monthlyPrice;
    private int managementPrice;
    private String completionYear;
    private OfferType type;
    private DealType dealType;
    private HeatingType heatingType;
    private HeatingMethodType heatingMethodType;
    private OfferStatusType status;
    private String description;
    @JsonProperty("OfferAddition")
    private OfferAddition offerAddition;
    @JsonProperty("OfferAddress")
    private OfferAddress offerAddress;
}
