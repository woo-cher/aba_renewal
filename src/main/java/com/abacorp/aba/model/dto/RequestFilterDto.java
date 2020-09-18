package com.abacorp.aba.model.dto;

import lombok.*;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RequestFilterDto {
    private String[] requestTypes;
    private String[] dealTypes;
    private String[] room;
    private String[] moveIn;
}
