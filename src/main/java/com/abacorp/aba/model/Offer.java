package com.abacorp.aba.model;

import com.abacorp.aba.model.dto.KeyValueDto;
import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class Offer extends ModelMapper {
    private User user;
    @NotBlank(message = "보증금을 알려주세요")
    private String deposit;
    @NotBlank(message = "월세를 알려주세요")
    private String monthlyPrice;
    @NotBlank(message = "관리비를 알려주세요")
    private String managementPrice;
    private String completionYear;
    @NotNull(message = "매물분류를 선택하세요")
    private OfferType type;
    @NotNull(message = "거래유형을 선택하세요")
    private DealType dealType;
    @NotNull(message = "난방유형을 선택하세요")
    private HeatingType heatingType;
    private HeatingMethodType heatingMethodType;
    private OfferStatusType status;
    private String description;
    private String thumbnail;
    @Builder.Default
    private List<MultipartFile> files = null;
    @Builder.Default
    private List<KeyValueDto> imageUrls = null;
    @Valid
    @JsonProperty("offerAddition")
    private OfferAddition offerAddition;
    @Valid
    @JsonProperty("offerAddress")
    private OfferAddress offerAddress;
}
