package com.abacorp.aba.model;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OfferAddress {
    private int offerId;
    private float latitude;
    private float longitude;
    private String jibun;
    private String road;
    private String dong;
    private String ho;
    private String door;
    private String floor;
    private String nearLocation;
    private String belongsTo;
}
