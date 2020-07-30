package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.KakaoRestApiHelper;
import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/apis")
@Slf4j
public class KakaoMapApi {

    @Autowired
    private MapService service;

    @Autowired
    private KakaoRestApiHelper helper;

    @RequestMapping(value = "/overlays", method = RequestMethod.POST)
    public List<Overlay> overlays(@RequestBody MapFiltersDto dto) {
        log.info("dto : {}", dto);
        return service.getOverlays(dto);
    }

    @RequestMapping(value = "/overlays/{id}", method = RequestMethod.GET)
    public Overlay coordinates(@PathVariable int id) {
        return service.getOverlay(id);
    }

    @RequestMapping(value = "/offers", method = RequestMethod.POST)
    public List<Offer> offers(@RequestBody MapFiltersDto dto) {
        String region = dto.getBelongsTo();

        if(region != null) {
            return service.getOffersInRegion(region);
        } else {
            return service.getOffers(dto);
        }
    }

    @RequestMapping(value = "/offers", method = RequestMethod.GET)
    public List<Offer> offersOfLatLng(@RequestParam(value = "latitude") String lat,
                                      @RequestParam(value = "longitude") String lng) {
        Map<String, String> latLng = new HashMap<>();

        latLng.put("latitude", lat);
        latLng.put("longitude", lng);

        log.info("dto map : {}", latLng);

        return service.getOffersByLatLng(latLng);
    }

    @RequestMapping(value = "/kakao/address")
    public String searchAddress(@RequestParam(value = "keyword") String address) throws Exception {
        return helper.getPlaceGeoByKeyword(address).getBody();
    }

}
