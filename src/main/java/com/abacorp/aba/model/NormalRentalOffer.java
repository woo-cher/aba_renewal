package com.abacorp.aba.model;

import lombok.*;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotBlank;

@Data
@SuperBuilder
@EqualsAndHashCode
@ToString
public class NormalRentalOffer extends Offer {
    @NotBlank(message = "월세를 알려주세요")
    private String monthlyPrice;
    @NotBlank(message = "관리비를 알려주세요")
    private String managementPrice;
}
