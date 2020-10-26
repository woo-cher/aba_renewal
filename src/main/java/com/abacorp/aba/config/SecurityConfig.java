package com.abacorp.aba.config;

import com.abacorp.aba.security.CustomLoginSuccessHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.ForwardAuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeRequests()
//                .antMatchers("/admin/**").hasAnyRole("ADMIN", "MASTER")
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .exceptionHandling().accessDeniedPage("/auth/denied")
                .and()
            .formLogin()
                .loginPage("/auth/login")
                .successHandler(successHandler())
                .failureHandler(new ForwardAuthenticationFailureHandler("/auth/login"))
                .loginProcessingUrl("/auth/doLogin")
                .permitAll()
                .and()
            .logout()
                .logoutUrl("/auth/logout")
                .logoutSuccessUrl("/")
                .permitAll();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring()
                .antMatchers("/web-resources/css/**", "/web-resources/js/**",
                        "/web-resources/img/**", "/web-resources/font/**", "/web-resources/scss/**");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new CustomLoginSuccessHandler();
    }
}
