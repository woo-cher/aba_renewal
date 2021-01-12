package com.abacorp.aba.model.offer;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotBlank;

@Data
@SuperBuilder
@EqualsAndHashCode
@ToString
public class OfficeRentalOffer extends Offer {
    @NotBlank(message = "권시비를 알려주세요")
    private String suppliesPrice;
    @NotBlank(message = "현재업종을 알려주세요")
    private String industry;
    @NotBlank(message = "제한업종을 알려주세요")
    private String restrictedIndustry;
}
