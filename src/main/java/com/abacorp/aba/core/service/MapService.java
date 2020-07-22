package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.MapRepository;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MapService {
    private static final Logger logger = LoggerFactory.getLogger(MapService.class);

    @Autowired
    private MapRepository repository;

    public List<Overlay> getOverlays(MapFiltersDto dto) {
        return repository.findOverlaysByFilters(dto);
    }

    public Overlay getOverlay(int id) {
        return repository.findOverlayById(id);
    }
}