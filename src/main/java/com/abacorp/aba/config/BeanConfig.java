package com.abacorp.aba.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.web.servlet.ModelAndView;

import javax.lang.model.type.PrimitiveType;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class BeanConfig {
    private static final Logger logger = LoggerFactory.getLogger(BeanConfig.class);

    @Bean
    public ModelAndView getModelAndView() {
        ModelAndView mv = new ModelAndView();
        mv.clear();

        return mv;
    }

    @Bean
    @Scope("prototype")
    public Map<String, String> getHashMap() {
        return new HashMap<>();
    }
}
