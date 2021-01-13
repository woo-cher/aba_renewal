package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.User;
import com.abacorp.aba.model.dto.KeyValueDto;
import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.Builder;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@Builder
@EqualsAndHashCode
@ToString
public class Offer extends ModelMapper {
    private User user;

    @NotBlank(message = "보증금을 알려주세요", groups = RentalGroup.class)
    private String deposit;
    @NotBlank(message = "월세를 알려주세요", groups = RentalGroup.class)
    private String monthlyPrice;
    @NotBlank(message = "관리비를 알려주세요", groups = RentalGroup.class)
    private String managementPrice;

    @NotBlank(message = "융자금을 알려주세요", groups = SaleGroup.class)
    private String loan;
    @NotBlank(message = "매매가를 알려주세요", groups = SaleGroup.class)
    private String salePrice;
    @NotBlank(message = "투자금액을 알려주세요", groups = SaleGroup.class)
    private String investmentMoney;
    @NotBlank(message = "이자를 알려주세요", groups = SaleGroup.class)
    private String interest;
    @NotBlank(message = "월순수익을 알려주세요", groups = SaleGroup.class)
    private String monthlyProfit;

    @NotBlank(message = "권시비를 알려주세요", groups = OfficeGroup.class)
    private String suppliesPrice;
    @NotBlank(message = "현재업종을 알려주세요", groups = OfficeGroup.class)
    private String industry;
    @NotBlank(message = "제한업종을 알려주세요", groups = OfficeGroup.class)
    private String restrictedIndustry;

    @NotBlank(message = "집주인 혹은 본인 연락처를 알려주세요", groups = BasicGroup.class)
    private String inquiryTel;
    private String area;
    private String completionYear;
    @NotNull(message = "매물분류를 선택하세요", groups = BasicGroup.class)
    private OfferType type;
    @NotNull(message = "거래유형을 선택하세요", groups = BasicGroup.class)
    private DealType dealType;
    @NotNull(message = "난방유형을 선택하세요", groups = BasicGroup.class)
    private HeatingType heatingType;
    private HeatingMethodType heatingMethodType;
    private OfferStatusType status;
    private String adminMemo;
    private String description;
    private String thumbnail;
    private List<MultipartFile> files;
    private List<KeyValueDto> imageUrls;

    @Valid
    @JsonProperty("offerAddition")
    private OfferAddition offerAddition;

    @Valid
    @JsonProperty("offerAddress")
    private OfferAddress offerAddress;

    // For Transfer `AbaOffer` to `renewal Offer`
    private String temporaryImages;
    private int abaOfferId;
}
