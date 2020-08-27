package com.abacorp.aba;

import com.abacorp.aba.model.dto.MapFiltersDto;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.model.type.UserRoleType;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.springframework.util.DigestUtils;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RunWith(JUnit4.class)
@Slf4j
public class BasicTest {

    @Test
    public void noArgsConstructor() {
        MapFiltersDto filtersDto = new MapFiltersDto();
        log.error("a : {}", filtersDto.getEast());
    }

    @Test
    public void enumTest() {
        String code = "ONE_ROOM";
        log.info("result : {}", OfferType.create(code).getValue());

        String dbValue = "MASTER";
        log.info("result : {}", UserRoleType.create(dbValue).getCode());
    }

    @Test
    public void regex() {
        String id = "vick123";

        Pattern pattern = Pattern.compile("[A-Za-z]+[0-9]*");
        Matcher matcher = pattern.matcher(id);

        if(matcher.find()) {
            log.info(matcher.group());
        } else {
            log.info("불일치");
        }
    }

    @Test
    public void regex2() {
        String options = "[1,2,3]";
        options = options.replaceAll("[\\[|\\]]", "");
        log.info("result : {}", options);
        List<String> optionIndex = Arrays.asList(options.split(","));
        log.info("result arr : {}", optionIndex.size());

        log.info("type : {}", OptionType.values()[0]);
    }

    @Test
    public void convertJibunToBelongsTo() {
        String regex = "[0-9\\\\-]";
        String jibun = "경남 진주시 호탄동 123-1";
        String jibun2 = "경기 고양시 일산동구 XX동 123-1";

        String result = jibun.replaceAll(regex, "");
        result = result.substring(0, result.length() - 1);
        log.info("result and size : {}, {}", result, result.length());

        result = jibun2.replaceAll(regex, "");
        result = result.substring(0, result.length() - 1);
        log.info("result2 and size : {}, {}", result, result.length());
    }
}
