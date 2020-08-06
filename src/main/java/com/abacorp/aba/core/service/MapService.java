package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.MapRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
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
    private MapRepository repository;

    @Transactional
    public List<Overlay> getOverlays(MapFiltersDto dto) {
        List<Overlay> overlays = repository.selectOverlaysByFilters(dto);

        for(Overlay overlay : overlays) {
            dto.setBelongsTo(overlay.getName());

            if(overlay.getCount() != 0) {
                overlay.setCount(repository.selectCountByFilters(dto));
            }
        }

        return overlays;
    }

    public Overlay getOverlay(int id) {
        return repository.selectOverlayById(id);
    }

    public List<Overlay> getOverlayByKeyword(String keyword) {
        return repository.selectOverlaysByKeyword(keyword);
    }

    public Offer getOfferById(int id) {
        Offer offer = repository.selectOfferById(id);

        OfferAddition addition = offer.getOfferAddition();
        String optionIndexStr = addition.getOptionCategory().replaceAll("[\\[|\\]]", "");
        String manageIndexStr = addition.getManagementCategory().replaceAll("[\\[|\\]]", "");

        OptionType[] optionTypes = OptionType.values();
        ManagementCategoryType[] managementTypes = ManagementCategoryType.values();

        List<OptionType> optionTypeList = new ArrayList<>();
        List<ManagementCategoryType> managementTypeList = new ArrayList<>();

        int i = 0;

        for(String indexStr : optionIndexStr.split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            optionTypeList.add(optionTypes[i]);
        }

        for(String indexStr : manageIndexStr.split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            managementTypeList.add(managementTypes[i]);
        }

        addition.setOptionTypes(optionTypeList);
        addition.setManagementTypes(managementTypeList);

        return offer;
    }

    public List<Offer> getOffers(MapFiltersDto dto) {
        return repository.selectOffersUsingFilter(dto);
    }

    public List<Offer> getOffersInRegion(MapFiltersDto dto) {
        return repository.selectOffersByBelongsTo(dto);
    }

    public List<Offer> getOffersByLatLng(MapFiltersDto latLng) {
        return repository.selectOffersByLatLng(latLng);
    }

    public List<Offer> getOffersByIdKeyword(String idKey) {
        return repository.selectOffersByIdKeyword(idKey);
    }
}
