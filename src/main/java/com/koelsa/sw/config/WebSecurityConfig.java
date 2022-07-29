package com.koelsa.sw.config;

//import com.koelsa.sw.handler.LoginFHandler;
import com.koelsa.sw.handler.LoginFHandler;
import com.koelsa.sw.handler.LoginSuccessHandler;
import com.koelsa.sw.jpa.Role;
import com.koelsa.sw.service.CustomOAuth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    CustomOAuth2UserService customOAuth2UserService;


    private static final String[] CLASSPATH_RESOURCE_LOCATIONS = { "classpath:/smarteditor2/","classpath:/static/", "classpath:/public/", "classpath:/",
            "classpath:/resources/", "classpath:/META-INF/resources/", "classpath:/META-INF/resources/webjars/" };
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**").addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS);


    }
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/cms/user/**")
                .hasAuthority(Role.ADMIN.name())
                .antMatchers("/cms/**")
                .hasAnyAuthority(Role.ADMIN.name(),Role.MANAGER.name())
                .anyRequest()
                .permitAll()
            .and()
                .oauth2Login()
                .userInfoEndpoint().userService(customOAuth2UserService) // 네이버 USER INFO의 응답을 처리하기 위한 설정
            .and()
                .defaultSuccessUrl("/loginSuccess")
                .failureUrl("/loginFailure")
            .and()
                .formLogin()
                .loginPage("/login")
                .failureUrl("/login?error=exception")
                .defaultSuccessUrl("/loginSuccess")
                .successHandler(new LoginSuccessHandler(customOAuth2UserService))
                .failureHandler(new LoginFHandler())
            .and()
                .exceptionHandling()
                .authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"))
            .and()
                .logout()
                .logoutUrl("/doLogout")
                .logoutSuccessUrl("/");
        http.cors().and().csrf().disable();
        http.headers().frameOptions().sameOrigin();

    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

