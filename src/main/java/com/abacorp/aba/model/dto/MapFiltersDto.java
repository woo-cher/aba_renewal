package com.abacorp.aba.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MapFiltersDto {
    private int weight;
    @Builder.Default
    private int page = 1;
    private String east;
    private String west;
    private String south;
    private String north;
    private String belongsTo;

    /* Basic Filters .. */
    private String latitude;
    private String longitude;
    private String[] offerTypes;
    private String[] dealTypes;
    private String maxDeposit;
    private String maxMonthlyPrice;

    /* Detail Filters */
    @JsonProperty
    private boolean isParking;
    @JsonProperty
    private boolean isNotTenant;
    @JsonProperty
    private boolean isCanTerm;
    @JsonProperty
    private boolean isPet;
    private boolean hasElevator;
    private String floor;
    private String completionYear;
    private String[] options;
}
