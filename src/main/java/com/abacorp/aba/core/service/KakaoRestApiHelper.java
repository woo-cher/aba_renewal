package com.abacorp.aba.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URLEncoder;

@Component
public class KakaoRestApiHelper {
    private static final Logger logger = LoggerFactory.getLogger(KakaoRestApiHelper.class);

    @Value("${kakao.map.appkey}")
    private String appKey;

    private static final String API_SERVER_HOST = "https://dapi.kakao.com";
    private static final String SEARCH_PLACE_KEYWORD_PATH = "/v2/local/search/address.json";

    public ResponseEntity<String> getPlaceGeoByKeyword(String areaKeyword) throws Exception {
        String queryString = "?query=" + URLEncoder.encode(areaKeyword, "UTF-8");

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        headers.add("Authorization", "KakaoAK " + appKey);
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_JSON + ";charset=UTF-8");

        URI url = URI.create(API_SERVER_HOST + SEARCH_PLACE_KEYWORD_PATH + queryString);
        RequestEntity<String> rq = new RequestEntity<>(headers, HttpMethod.GET, url);
        ResponseEntity<String> re = restTemplate.exchange(rq, String.class);

        return re;
    }
}
