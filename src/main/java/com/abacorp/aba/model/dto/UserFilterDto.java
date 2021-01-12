package com.abacorp.aba.model.dto;

import lombok.*;
import lombok.experimental.SuperBuilder;

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
