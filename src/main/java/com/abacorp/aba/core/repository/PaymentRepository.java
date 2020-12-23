package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Payment;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class PaymentRepository {

    @Autowired
    private SqlSession sqlSession;

    public int insertPayment(Payment payment) {
        return sqlSession.insert("insertPayment", payment);
    }
}
