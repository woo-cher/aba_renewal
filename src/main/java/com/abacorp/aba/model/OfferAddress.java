package com.abacorp.aba.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class OfferAddress {
    private int offerId;
    private float latitude;
    private float longitude;
    private String buildingName;
    private String jibun;
    private String road;
    private String dong;
    private String ho;
    private String entrance;
    private String door;
    private String floor;
    private String nearLocation;
    private String belongsTo;
}
