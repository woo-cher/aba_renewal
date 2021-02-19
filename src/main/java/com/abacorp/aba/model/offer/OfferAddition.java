package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.offer.group.OfficeGroup;
import com.abacorp.aba.model.offer.group.RentalGroup;
import com.abacorp.aba.model.offer.group.SaleGroup;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
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
    @NotBlank(message = "단기 개월을 알려주세요", groups = RentalGroup.class)
    private String term;
    @NotBlank(message = "세입자 정보를 알려주세요")
    private String tenant;
//    @Pattern(regexp = "[가-힣0-9a-zA-Z]+", message = "세대 정보를 알려주세요", groups = SaleGroup.class)
    private String householdInfo; // 세대정보 (1층 세대/2층 세대 .../n층 세대)
    @NotBlank(message = "현재업종을 알려주세요", groups = OfficeGroup.class)
    private String industry;
    @NotBlank(message = "제한업종을 알려주세요", groups = OfficeGroup.class)
    private String restrictedIndustry;
    private String optionCategory;
    private String managementCategory;
    private boolean hasElevator;
    private boolean canParking;
    private boolean canPet;

    /* APT */
    private boolean hasCool;
    private boolean builtIn;
    private boolean remodeling;
    private String moveIn;
    private String households;
    private String totalDong;
    private String totalParking;
    private String direction;
    private String frontStructure;
    private String bathrooms;
    private String rooms;

    private List<OptionType> optionTypes;
    private List<ManagementCategoryType> managementTypes;
}
