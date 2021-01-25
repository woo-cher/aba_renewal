package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.offer.OfferRequest;
import com.abacorp.aba.model.dto.RequestFilterDto;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Slf4j
public class OfferRequestRepository extends AbaRepository {

    public int createOfferRequest(OfferRequest offerRequest) {
        return sqlSession.insert("insertOfferRequest", offerRequest);
    }

    public OfferRequest findOfferRequestById(int id) {
        return sqlSession.selectOne("selectOfferRequestById", id);
    }

    public List<OfferRequest> findOfferRequests(RequestFilterDto filterDto) {
        return filterDto == null ?
                sqlSession.selectList("selectOfferRequests") :
                sqlSession.selectList("selectOfferRequestsByFilter", filterDto);
    }

    public int deleteOfferRequest(int id) {
        return sqlSession.delete("deleteOfferRequestById", id);
    }

    public int updateOfferRequestHit(int id) {
        return sqlSession.update("updateOfferRequestHit", id);
    }

    public List<OfferRequest> findOfferRequestByPhone(String phone) {
        return sqlSession.selectList("selectOfferRequestByPhone", phone);
    }
}
