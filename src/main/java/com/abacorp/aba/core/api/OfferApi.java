package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.core.service.OfferService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/apis")
@Slf4j
public class OfferApi {
    private final int OFFERS_PER_PAGE = 2;
    private final int MAXIMUM_PAGE = 999;

    @Autowired
    private MapService service;

    @Autowired
    private OfferService offerService;

    @RequestMapping(value = "/maps/offers", method = RequestMethod.POST)
    public PageInfo<Offer> offersOfMap(@RequestBody MapFiltersDto dto) {
        log.info("Dto : {}", dto);

        if (dto.getBelongsTo() != null) {
            return PageHelper.startPage(dto.getPage(), OFFERS_PER_PAGE).doSelectPageInfo(
                    () -> service.getOffersInRegion(dto)
            );
        } else {
            int limit = dto.getPage() == 0 ? MAXIMUM_PAGE : OFFERS_PER_PAGE;

            return PageHelper.startPage(dto.getPage(), limit).doSelectPageInfo(
                    () -> service.getOffersInCoordinate(dto)
            );
        }
    }

    @RequestMapping(value = "/maps/offers/spot", method = RequestMethod.POST)
    public List<Offer> offersOfLatLng(@RequestBody MapFiltersDto dto) {
        log.info("dto : {}", dto);
        return service.getOffersByLatLng(dto);
    }

    @RequestMapping(value = "/maps/offers", method = RequestMethod.GET)
    public List<Offer> offersById(@RequestParam(value = "idKey") String idKey) {
        return service.getOffersByIdKeyword(idKey);
    }

    @RequestMapping(value = "/offers", method = RequestMethod.GET)
    public <O extends Offer, P extends PageInfo<Offer>> Object offers(@RequestParam(required = false, value = "user") String userId,
                                                                      @RequestParam(required = false, value = "page") Integer page) {
        log.info("userId : {}", userId);
        log.info("page : {}", page);

        if (userId != null && page == null) {
            return (List<O>) service.getOffersByUserId(userId);
        }

        PageInfo<Offer> offers = userId == null ?

                PageHelper.startPage(page, OFFERS_PER_PAGE).doSelectPageInfo(
                        () -> service.getOffers()) :
                PageHelper.startPage(page, 3).doSelectPageInfo(
                        () -> service.getOffersByUserId(userId));

        return (P) offers;
    }

    @RequestMapping(value = "/offers/{offer}", method = RequestMethod.DELETE)
    public int delete(@PathVariable(value = "offer") int id) {
        return offerService.deleteOfferById(id);
    }

    @RequestMapping(value = "/offers/search", method = RequestMethod.GET)
    public PageInfo<Offer> search(@RequestParam String keyword, @RequestParam int page) {
        return PageHelper.startPage(page, OFFERS_PER_PAGE).doSelectPageInfo(
                () -> offerService.searchOffers(keyword)
        );
    }
}
