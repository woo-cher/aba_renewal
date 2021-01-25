package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

import javax.validation.constraints.NotBlank;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class OfferAddress {
    private int offerId;
    private String latitude;
    private String longitude;
    @NotBlank(message = "건물이름을 알려주세요", groups = BasicGroup.class)
    private String buildingName;
    @NotBlank(message = "주소를 검색해주세요", groups = BasicGroup.class)
    private String jibun;
    private String road;
    private String dong;
    @NotBlank(message = "호수를 알려주세요", groups = BasicGroup.class)
    private String ho;
    private String entrance;
    @NotBlank(message = "호실 비밀번호를 알려주세요", groups = BasicGroup.class)
    private String door;
    @NotBlank(message = "매물이 몇 층인가요?", groups = BasicGroup.class)
    private String floor;
    @NotBlank(message = "주요위치를 알려주세요", groups = BasicGroup.class)
    private String nearLocation;
    private String belongsTo;
    private String buildingArea;
    private String landArea;
}
