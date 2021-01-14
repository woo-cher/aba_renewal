package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @see OptionType
 * @see ManagementCategoryType
 *
 *  ex) optionCategory = "1,3,5,7".split(",")
 *    => ["1", "3", "5", "7"]
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class OfferAddition {
    private int offerId;
    @NotBlank(message = "단기 개월을 알려주세요", groups = BasicGroup.class)
    private String term;
    @NotBlank(message = "세입자 정보를 알려주세요", groups = BasicGroup.class)
    private String tenant;
    private String householdInfo; // 세대정보 (1층 세대/2층 세대 .../n층 세대)
    @NotBlank(message = "현재업종을 알려주세요", groups = OfficeGroup.class)
    private String industry;
    @NotBlank(message = "제한업종을 알려주세요", groups = OfficeGroup.class)
    private String restrictedIndustry;
    @NotNull(message = "옵션을 선택해주세요", groups = BasicGroup.class)
    private String optionCategory;
    @NotNull(message = "관리비 항목을 선택해주세요", groups = BasicGroup.class)
    private String managementCategory;
    private boolean hasElevator;
    private boolean canParking;
    private boolean canPet;

    private List<OptionType> optionTypes;
    private List<ManagementCategoryType> managementTypes;
}
