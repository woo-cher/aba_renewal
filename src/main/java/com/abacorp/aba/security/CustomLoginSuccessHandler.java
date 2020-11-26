package com.abacorp.aba.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        HttpSession session = request.getSession();
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

        session.setAttribute("sessionUser", userDetails.getUser());

        log.info("User log in : {}", userDetails.getUser());

        String redirectUrl = (String) session.getAttribute("prevPage");
        if (redirectUrl != null) {
            session.removeAttribute("prevPage");
            response.sendRedirect(redirectUrl);
        }
    }
}
