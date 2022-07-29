package com.koelsa.sw.handler;

import com.koelsa.sw.jpa.CustomOAuth2User;
import com.koelsa.sw.jpa.SessionUser;
import com.koelsa.sw.service.CustomOAuth2UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
    private final CustomOAuth2UserService userService;

    public LoginSuccessHandler(CustomOAuth2UserService userService){
        this.userService = userService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        CustomOAuth2User user = userService.findById(authentication.getName());
        HttpSession session = httpServletRequest.getSession();
        session.setAttribute("user",new SessionUser(user));
        httpServletResponse.sendRedirect("loginSuccess");
    }
}


