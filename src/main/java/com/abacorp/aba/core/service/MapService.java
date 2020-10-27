package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OverlayRepository;
import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class MapService {

    @Autowired
    private OverlayRepository overlayRepository;

    @Autowired
    private OfferRepository offerRepository;

    @Transactional
    public List<Overlay> getOverlays(MapFiltersDto dto) {
        List<Overlay> overlays = overlayRepository.selectOverlaysByFilters(dto);

        for(Overlay overlay : overlays) {
            dto.setBelongsTo(overlay.getName());

            if(overlay.getCount() != 0) {
                overlay.setCount(offerRepository.selectCountByFilters(dto));
            }
        }

        return overlays;
    }

    public Overlay getOverlay(int id) {
        return overlayRepository.selectOverlayById(id);
    }

    public List<Overlay> getOverlayByKeyword(String keyword) {
        return overlayRepository.selectOverlaysByKeyword(keyword);
    }

    public Offer getOfferById(int id) {
        Offer offer = offerRepository.selectOfferById(id);

        OfferAddition addition = offer.getOfferAddition();

        OptionType[] optionTypes = OptionType.values();
        ManagementCategoryType[] managementTypes = ManagementCategoryType.values();

        List<OptionType> optionTypeList = new ArrayList<>();
        List<ManagementCategoryType> managementTypeList = new ArrayList<>();

        int i = 0;

        for(String indexStr :  addition.getOptionCategory().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            optionTypeList.add(optionTypes[i]);
        }

        for(String indexStr : addition.getManagementCategory().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            managementTypeList.add(managementTypes[i]);
        }

        addition.setOptionTypes(optionTypeList);
        addition.setManagementTypes(managementTypeList);

        return offer;
    }

    public List<Offer> getOffers(MapFiltersDto dto) {
        return offerRepository.selectOffersUsingFilter(dto);
    }

    public List<Offer> getOffersInRegion(MapFiltersDto dto) {
        return offerRepository.selectOffersByBelongsTo(dto);
    }

    public List<Offer> getOffersByLatLng(MapFiltersDto latLng) {
        return offerRepository.selectOffersByLatLng(latLng);
    }

    public List<Offer> getOffersByIdKeyword(String idKey) {
        return offerRepository.selectOffersByIdKeyword(idKey);
    }

    public List<Offer> getOffersByUserId(String userId) {
        return offerRepository.selectOffersByUserId(userId);
    }
}
