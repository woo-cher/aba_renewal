package com.abacorp.aba.model.dto;

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
    private String east;
    private String west;
    private String south;
    private String north;
    private String belongsTo;

    /* Added Filters .. */
}
