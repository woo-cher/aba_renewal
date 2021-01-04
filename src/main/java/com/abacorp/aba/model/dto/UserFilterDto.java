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
public class UserFilterDto {
    private String[] userTypes;
    private String[] roles;

    @Builder.Default
    private int page = 1;
}
