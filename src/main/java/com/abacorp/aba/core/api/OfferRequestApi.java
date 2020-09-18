package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.OfferRequestService;
import com.abacorp.aba.model.OfferRequest;
import com.abacorp.aba.model.dto.RequestFilterDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/requests")
@Slf4j
public class OfferRequestApi {

    @Autowired
    private OfferRequestService service;

    @RequestMapping(value = "/filters", method = RequestMethod.POST)
    public List<OfferRequest> offerRequests(@RequestBody RequestFilterDto requestFilterDto) {
        log.info("Request DTO : {}", requestFilterDto);

        return service.selectRequests(requestFilterDto);
    }
}
