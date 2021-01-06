package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.TemporaryAbaOffer;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class TransformerRepository {

    @Autowired
    private SqlSession sqlSession;

    public List<TemporaryAbaOffer> selectAbaOffers() {
        return sqlSession.selectList("selectAbaOffers");
    }
}
