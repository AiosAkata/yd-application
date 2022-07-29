package com.koelsa.sw.service;

import com.koelsa.sw.jpa.CustomOAuth2User;
import com.koelsa.sw.jpa.OAuthAttributes;
import com.koelsa.sw.jpa.Role;
import com.koelsa.sw.jpa.SessionUser;
import com.koelsa.sw.repository.CustomOAuthRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
    private final CustomOAuthRepository customOAuthRepository;
    private final HttpSession httpSession;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2User = delegate.loadUser(userRequest);

        // OAuth2 서비스 프로바이더 아이디(google, kakao, naver, apple)
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        // OAuth2 로그인 진행시 키가 되는 필드 값
        String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUserNameAttributeName();

        OAuthAttributes attributes = OAuthAttributes.of(registrationId,userNameAttributeName,oAuth2User.getAttributes());
        CustomOAuth2User user = saveOrUpdate(attributes);
        httpSession.setAttribute("user",new SessionUser(user));

        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority(user.getRoleKey())),
                attributes.getAttributes(),
                attributes.getNameAttributeKey());
    }

    private CustomOAuth2User saveOrUpdate(OAuthAttributes attributes){
        CustomOAuth2User user = customOAuthRepository.findByEmail(attributes.getEmail())
                .map(entity -> entity.update(attributes.getOauthType()))
                .orElse(attributes.toEntity());
        return customOAuthRepository.save(user);
    }

    public CustomOAuth2User findByEmail(String email){
        return customOAuthRepository.findByEmail2(email);
    }

    public CustomOAuth2User findById(String id){
        return customOAuthRepository.findByuserId(id).orElse(null);
    }

    public Optional<CustomOAuth2User> optFindByEmail(String email){
        return customOAuthRepository.findByEmail(email);
    }

    public CustomOAuth2User findById(Integer id){
        return customOAuthRepository.findById(id).orElse(null);
    }

    public CustomOAuth2User save(CustomOAuth2User customOAuth2User){
        return customOAuthRepository.save(customOAuth2User);
    }

    public boolean isDuplicate(String email){
        CustomOAuth2User user = customOAuthRepository.findByEmail(email).orElse(null);
        return user == null;
    }


}
