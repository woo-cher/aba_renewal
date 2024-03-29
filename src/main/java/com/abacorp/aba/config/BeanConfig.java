package com.abacorp.aba.config;

import com.abacorp.aba.model.offer.group.AptGroup;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ModelAndView;

@Configuration
@Slf4j
public class BeanConfig {

    @Bean
    public ModelAndView getModelAndView() {
        return new ModelAndView();
    }
}
