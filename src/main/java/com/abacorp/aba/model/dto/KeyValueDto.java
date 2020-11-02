package com.abacorp.aba.model.dto;

import lombok.*;

import java.io.File;


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
