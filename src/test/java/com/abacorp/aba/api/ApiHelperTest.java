package com.abacorp.aba.api;

import com.abacorp.aba.core.service.KakaoRestApiHelper;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class ApiHelperTest {

    @Autowired
    private KakaoRestApiHelper helper;

    @Test
    public void getXY() throws Exception {
        log.info("result : {}", helper.getPlaceGeoByKeyword("호탄동 619-1"));
    }
}
