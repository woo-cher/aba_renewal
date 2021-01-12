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
public class NormalSaleOffer extends Offer {
    @NotBlank(message = "융자금을 알려주세요")
    private String loan;
    @NotBlank(message = "매매가를 알려주세요")
    private String salePrice;
    @NotBlank(message = "투자금액을 알려주세요")
    private String investmentMoney;
    @NotBlank(message = "이자를 알려주세요")
    private String interest;
    @NotBlank(message = "월순수익을 알려주세요")
    private String monthlyProfit;
}
