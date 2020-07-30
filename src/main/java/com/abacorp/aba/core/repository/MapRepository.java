package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class MapRepository {

    @Autowired
    private SqlSession sqlSession;

    public List<Overlay> selectOverlaysByFilters(MapFiltersDto dto) {
        return sqlSession.selectList("selectOverlays", dto);
    }

    public Overlay selectOverlayById(int id) {
        return sqlSession.selectOne("selectOverlay", id);
    }

    public List<Offer> selectOffersUsingFilter(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersByFilters", dto);
    }

    public List<Offer> selectOffersByBelongsTo(String region) {
        return sqlSession.selectList("selectOffersByRegion", region);
    }

    public List<Offer> selectOffersByLatLng(Map<String, String> latLng) {
        return sqlSession.selectList("selectOffersByLatLng", latLng);
    }
}
