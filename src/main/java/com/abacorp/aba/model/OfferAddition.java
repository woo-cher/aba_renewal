package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.*;

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
@ToString
public class OfferAddition {
    private int offerId;
    private int term; // term = 0 ? `단기불가` : 'term 개월 가능'
    private String tenant;
    private String optionCategory;
    private String managementCategory;
    private boolean hasElevator;
    private boolean isParking;
    private boolean isPet;
}
