package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MapRepository {
    private static final Logger logger = LoggerFactory.getLogger(MapRepository.class);

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
}
