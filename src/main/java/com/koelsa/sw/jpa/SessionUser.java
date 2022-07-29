package com.koelsa.sw.jpa;

import lombok.Getter;

import java.io.Serializable;

@Getter
public class SessionUser implements Serializable {
    private Integer id;
    private String userId;
    private String name;
    private String email;
    private Role role;
    private String company;
    private String addr;
    private String addrDetail;
    private String position;
    public SessionUser(CustomOAuth2User user){
        this.id = user.getId();
        this.userId = user.getUserId();
        this.name = user.getName();
        this.email = user.getEmail();
        this.role = user.getType();
        this.company = user.getCompany();
        this.addr = user.getAddr();
        this.addrDetail = user.getAddrDetail();
        this.position = user.getPosition();
    }
}