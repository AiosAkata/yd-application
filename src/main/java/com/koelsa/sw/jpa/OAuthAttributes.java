package com.koelsa.sw.jpa;

import lombok.Builder;
import lombok.Getter;

import java.util.Map;

@Getter
public class OAuthAttributes {
    private Map<String, Object> attributes;
    private String nameAttributeKey;
    private String name;
    private String email;
    private String oauthType;
    @Builder
    public OAuthAttributes(Map<String, Object> attributes
            , String nameAttributeKey
                           ,String primary
            , String name
            , String email
            , String picture
            , String oauthType) {
        this.attributes = attributes;
        this.nameAttributeKey = nameAttributeKey;
        this.name = name;
        this.email = email;
        this.oauthType = oauthType;
    }

    public static OAuthAttributes of(
            String registrationId
            , String userNameAttributeName
            , Map<String, Object> attributes) {

        if("kakao".equals(registrationId)){
            return ofKakao("id",attributes);
        }

        if("naver".equals(registrationId)){
            return ofNaver("id",attributes);
        }

        return ofGoogle(userNameAttributeName, attributes);
    }

    public static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) {
        Map<String,Object> response = (Map<String, Object>)attributes.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) response.get("profile");
        return OAuthAttributes.builder()
                .name((String)profile.get("nickname"))
                .email((String)response.get("email"))
                .picture((String)profile.get("profile_image_url"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .oauthType("kakao")
                .build();
    }
    public static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) {
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        return OAuthAttributes.builder()
                .name((String) response.get("name"))
                .email((String) response.get("email"))
                .attributes(response)
                .nameAttributeKey(userNameAttributeName)
                .oauthType("naver")
                .build();
    }

    public static OAuthAttributes ofGoogle(
            String userNameAttributeName
            , Map<String, Object> attributes) {

        return OAuthAttributes.builder()
                .name((String)attributes.get("name"))
                .email((String)attributes.get("email"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .oauthType("google")
                .build();
    }

    public CustomOAuth2User toEntity() {
        return CustomOAuth2User.builder()
                .name(name)
                .email(email)
                .userId(email)
                .type(Role.USER)
                .oauthType(oauthType)
                .build();
    }

}