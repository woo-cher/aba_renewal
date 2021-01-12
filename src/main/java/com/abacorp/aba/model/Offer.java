package com.abacorp.aba.model;

import com.abacorp.aba.model.dto.KeyValueDto;
import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@SuperBuilder
@EqualsAndHashCode
@ToString
public class Offer extends ModelMapper {
    private User user;
    @NotBlank(message = "보증금을 알려주세요")
    private String deposit;
    @NotBlank(message = "집주인 혹은 본인 연락처를 알려주세요")
    private String inquiryTel;
    private String completionYear;
    @NotNull(message = "매물분류를 선택하세요")
    private OfferType type;
    @NotNull(message = "거래유형을 선택하세요")
    private DealType dealType;
    @NotNull(message = "난방유형을 선택하세요")
    private HeatingType heatingType;
    private HeatingMethodType heatingMethodType;
    private OfferStatusType status;
    private String adminMemo;
    private String description;
    private String thumbnail;
    private List<MultipartFile> files;
    private List<KeyValueDto> imageUrls;

    // 융자금(right_money), 총보증금(deposit), 매매가, 투자금액, 이자, 순수입(monthly),

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
