package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.KakaoRestApiHelper;
import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @RequestMapping(value = "/overlays")
    public List<Overlay> overlaysByKeyword(@RequestParam(value = "keyword") String keyword) {
        return service.getOverlayByKeyword(keyword);
    }

    @RequestMapping(value = "/kakao/address")
    public String searchAddress(@RequestParam(value = "keyword") String address) throws Exception {
        return helper.getPlaceGeoByKeyword(address).getBody();
    }
}
