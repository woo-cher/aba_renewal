package com.abacorp.aba.model;

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
    @NotBlank(message = "단기 개월을 알려주세요")
    private String term;
    @NotBlank(message = "세입자 정보를 알려주세요")
    private String tenant;
    @NotNull(message = "옵션을 선택해주세요")
    private String optionCategory;
    @NotNull(message = "관리비 항목을 선택해주세요")
    private String managementCategory;
    private boolean hasElevator;
    private boolean canParking;
    private boolean canPet;

    // 확장여부(아파트), n층 세대

    private List<OptionType> optionTypes;
    private List<ManagementCategoryType> managementTypes;
}
