package com.abacorp.aba.model;

import com.abacorp.aba.core.repository.MembershipRepository;
import com.abacorp.aba.core.repository.ProductRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class MembershipTest {

    @Autowired
    private MembershipRepository membershipRepository;

    @Autowired
    private ProductRepository packageRepository;

    @Test
    public void isExistUsingMembership() {
        String userId = UserTest.TEST_USER.getUserId();

        log.info("2 : {}", membershipRepository.isExistUsingMembership("test").getProduct());
    }

    @Test
    public void selectProduct() {
        log.info("?? : {}", packageRepository.selectProductById(1));
    }
}
