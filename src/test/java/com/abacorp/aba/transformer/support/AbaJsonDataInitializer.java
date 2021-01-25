package com.abacorp.aba.transformer.support;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.annotation.PostConstruct;
import java.io.FileReader;
import java.io.IOException;

public class AbaJsonDataInitializer {
    protected JSONObject gubun;
    protected JSONObject etc1;
    protected JSONObject etc2;

    @PostConstruct
    private void init() throws IOException, ParseException {
        JSONParser parser = new JSONParser();
        JSONObject abaType = (JSONObject) parser.parse(new FileReader("aba-type.json"));

        this.gubun = (JSONObject) abaType.get("gubun");
        this.etc1 = (JSONObject) abaType.get("etc1");
        this.etc2 = (JSONObject) abaType.get("etc2");

        if (gubun == null || etc1 == null || etc2 == null) {
            throw new NullPointerException("Caused by => gubun, etc1, etc2 initializing failure");
        }
    }
}
