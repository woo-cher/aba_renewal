package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Overlay;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/overlays")
public class OverlayController {
    private static final Logger logger = LoggerFactory.getLogger(OverlayController.class);

    @Autowired
    MapService service;

    @RequestMapping(value = "/{weight}", method = RequestMethod.GET)
    public List<Overlay> overlays(@PathVariable int weight) {
        return service.getAllOverlays(weight);
    }
}
