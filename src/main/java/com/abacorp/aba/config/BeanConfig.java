package com.abacorp.aba.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ModelAndView;

@Configuration
public class BeanConfig {
    private static final Logger logger = LoggerFactory.getLogger(BeanConfig.class);

    @Bean
    public ModelAndView getModelAndView() {
        ModelAndView mv = new ModelAndView();
        mv.clear();

        return mv;
    }
}
