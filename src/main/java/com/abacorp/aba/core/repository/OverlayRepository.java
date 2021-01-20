package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Overlay;
import com.abacorp.aba.model.dto.MapFiltersDto;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class OverlayRepository {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    public List<Overlay> selectOverlaysByFilters(MapFiltersDto dto) {
        return sqlSession.selectList("selectOverlays", dto);
    }

    public Overlay selectOverlayById(int id) {
        return sqlSession.selectOne("selectOverlay", id);
    }

    public List<Overlay> selectOverlaysByKeyword(String keyword) {
        return sqlSession.selectList("selectOverlaysByKeyword", keyword);
    }
}
