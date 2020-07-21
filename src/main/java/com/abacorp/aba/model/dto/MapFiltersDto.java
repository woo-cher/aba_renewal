package com.abacorp.aba.model.dto;

import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@ToString
public class MapFiltersDto {
    private int weight;
    private String east;
    private String west;
    private String south;
    private String north;
}
