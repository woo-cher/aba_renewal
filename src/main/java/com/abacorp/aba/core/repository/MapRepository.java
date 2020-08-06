package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
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

    /* --------------------------- Overlays ------------------------------ */
    public List<Overlay> selectOverlaysByFilters(MapFiltersDto dto) {
        return sqlSession.selectList("selectOverlays", dto);
    }

    public Overlay selectOverlayById(int id) {
        return sqlSession.selectOne("selectOverlay", id);
    }

    public List<Overlay> selectOverlaysByKeyword(String keyword) {
        return sqlSession.selectList("selectOverlaysByKeyword", keyword);
    }
    /* ------------------------------------------------------------------- */

    /* ---------------------------- Offers ------------------------------- */
    public Offer selectOfferById(int id) {
        return sqlSession.selectOne("selectOfferById", id);
    }

    public List<Offer> selectOffersUsingFilter(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersByFilters", dto);
    }

    public List<Offer> selectOffersByBelongsTo(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersByRegion", dto);
    }

    public List<Offer> selectOffersByLatLng(MapFiltersDto latLng) {
        return sqlSession.selectList("selectOffersByLatLng", latLng);
    }

    public List<Offer> selectOffersByIdKeyword(String idKey) {
        return sqlSession.selectList("selectOffersByIdKey", idKey);
    }
    /* --------------------------------------------------------------------- */

    public int selectCountByFilters(MapFiltersDto dto) {
        return sqlSession.selectOne("selectCountByBelongsAndFilters", dto);
    }
}
