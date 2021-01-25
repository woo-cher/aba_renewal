package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class TransformerRepository extends AbaRepository {

    public List<TemporaryAbaOffer> selectAbaOffers() {
        return manageSqlSession.selectList("selectAbaOffers");
    }
}
