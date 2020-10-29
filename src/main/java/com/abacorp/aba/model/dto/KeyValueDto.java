package com.abacorp.aba.model.dto;

import lombok.*;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class KeyValueDto {
    private String key;
    private String url;
}
