package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OverlayRepository;
import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OfferStatusType;
import com.abacorp.aba.model.type.OptionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class MapService {

    @Autowired
    private OverlayRepository overlayRepository;

    @Autowired
    private OfferRepository offerRepository;

    @Autowired
    private AwsS3Service s3Service;

    @Transactional
    public List<Overlay> getOverlays(MapFiltersDto dto) {
        List<Overlay> overlays = overlayRepository.selectOverlaysByFilters(dto);

        for (Overlay overlay : overlays) {
            dto.setBelongsTo(overlay.getName());

            if (overlay.getCount() != 0) {
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

        for (String indexStr : addition.getOptionCategory().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            optionTypeList.add(optionTypes[i]);
        }

        for (String indexStr : addition.getManagementCategory().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            managementTypeList.add(managementTypes[i]);
        }

        addition.setOptionTypes(optionTypeList);
        addition.setManagementTypes(managementTypeList);

        offer.setImageUrls(s3Service.getAllFileUrls(String.valueOf(id)));

        return offer;
    }

    public List<Offer> getOffersInCoordinate(MapFiltersDto dto) {
        return offerRepository.selectOffersInRectUsingFilter(dto);
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

    public List<Offer> getOffers() {
        return offerRepository.selectOffers();
    }

    public int updateOfferStatus(int id, String status) {
        OfferStatusType statusType = OfferStatusType.create(status);

        Map<String, Object> kv = new HashMap<>();

        kv.put("id", id);
        kv.put("status", statusType);

        return offerRepository.updateOfferStatusById(kv);
    }
}
