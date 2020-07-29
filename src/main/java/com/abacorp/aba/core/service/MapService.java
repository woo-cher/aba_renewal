package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.MapRepository;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class MapService {

    @Autowired
    private MapRepository repository;

    public List<Overlay> getOverlays(MapFiltersDto dto) {
        return repository.selectOverlaysByFilters(dto);
    }

    public Overlay getOverlay(int id) {
        return repository.selectOverlayById(id);
    }

    public List<Offer> getOffers(MapFiltersDto dto) {
        return repository.selectOffersUsingFilter(dto);
    }

    public List<Offer> getOffersInRegion(String region) {
        return repository.selectOffersByBelongsTo(region);
    }
}
