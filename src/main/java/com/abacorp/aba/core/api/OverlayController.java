package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/overlays")
public class OverlayController {
    private static final Logger logger = LoggerFactory.getLogger(OverlayController.class);

    @Autowired
    MapService service;

    @RequestMapping(value = {"", "/"}, method = RequestMethod.POST)
    public List<Overlay> overlays(@RequestBody MapFiltersDto dto) {
        return service.getAllOverlays(dto);
    }
}
