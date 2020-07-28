package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.KakaoRestApiHelper;
import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/apis")
public class KakaoMapApi {
    private static final Logger logger = LoggerFactory.getLogger(KakaoMapApi.class);

    @Autowired
    private MapService service;

    @Autowired
    private KakaoRestApiHelper helper;

    @RequestMapping(value = "/overlays", method = RequestMethod.POST)
    public List<Overlay> overlays(@RequestBody MapFiltersDto dto) {
        logger.info("dto : {}", dto);
        return service.getOverlays(dto);
    }

    @RequestMapping(value = "/overlays/{id}", method = RequestMethod.GET)
    public Overlay show(@PathVariable int id) {
        return service.getOverlay(id);
    }

    @RequestMapping(value = "/kakao/address")
    public String searchAddress(@RequestParam(value = "keyword") String address) throws Exception {
        return helper.getPlaceGeoByKeyword(address).getBody();
    }
}
