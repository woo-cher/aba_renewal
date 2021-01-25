package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Payment;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class PaymentRepository extends AbaRepository {

    public int insertPayment(Payment payment) {
        return sqlSession.insert("insertPayment", payment);
    }
}
