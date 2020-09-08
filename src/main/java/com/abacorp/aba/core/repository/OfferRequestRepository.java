package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.OfferRequest;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class OfferRequestRepository {

    @Autowired
    private SqlSession sqlSession;

    public int createOfferRequest(OfferRequest offerRequest) {
        return sqlSession.insert("insertOfferRequest", offerRequest);
    }

    public OfferRequest findOfferRequestById(int id) {
        return sqlSession.selectOne("selectOfferRequestById", id);
    }

    public List<OfferRequest> findOfferRequests() {
        return sqlSession.selectList("selectOfferRequests");
    }

    public int deleteOfferRequest(int id) {
        return sqlSession.delete("deleteOfferRequestById", id);
    }

    public int updateOfferRequestHit(int id) {
        return sqlSession.update("updateOfferRequestHit", id);
    }
}
