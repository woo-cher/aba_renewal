package com.abacorp.aba.model.offer;

import com.abacorp.aba.model.offer.group.AptGroup;
import com.abacorp.aba.model.offer.group.OfficeGroup;
import com.abacorp.aba.model.offer.group.RentalGroup;
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
    @NotBlank(message = "건물이름을 알려주세요")
    private String buildingName;
    @NotBlank(message = "주소를 검색해주세요")
    private String jibun;
    private String road;
    private String dong;
    @NotBlank(message = "호수를 알려주세요")
    private String ho;
    @NotBlank(message = "입구 암호를 알려주세요", groups = {RentalGroup.class, AptGroup.class, OfficeGroup.class})
    private String entrance;
    @NotBlank(message = "호실 암호를 알려주세요", groups = {RentalGroup.class, AptGroup.class, OfficeGroup.class})
    private String door;
    private String floor;
    @NotBlank(message = "주요위치를 알려주세요")
    private String nearLocation;
    private String belongsTo;
    private String buildingArea;
    private String landArea;
}
