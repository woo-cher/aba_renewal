package com.abacorp.aba.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.servlet.ModelAndView;

@Configuration
@Slf4j
public class BeanConfig {

    @Bean
    public ModelAndView getModelAndView() {
        ModelAndView mv = new ModelAndView();

        return mv;
    }
}
