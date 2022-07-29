package com.koelsa.sw.jpa;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.json.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "user")
public class CustomOAuth2User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String userId;
    private String password;
    private String name;
    private String phone;
    private String email;

    @Enumerated(EnumType.STRING)
    private Role type;
    private String company;
    private String addr;
    private String addrDetail;
    private String position;
    @CreationTimestamp
    private Timestamp createdAt;
    private String oauthType;
    private String memo;


    @Builder
    public CustomOAuth2User(String name, String email, String userId, Role type, String oauthType){
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        this.name = name;
        this.userId = userId;
        this.password = encoder.encode(userId);
        this.email = email;
        this.type = type;
        this.oauthType = oauthType;
    }

    public CustomOAuth2User update (String oauthType){
        this.oauthType = oauthType;
        return this;
    }

    public String getRoleKey() {
        return this.type.getKey();
    }

    public JSONObject toJsonEntity(){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("name",this.name);
        jsonObject.put("phone",this.phone);
        jsonObject.put("email",this.email);
        jsonObject.put("type",this.oauthType);
        return jsonObject;
    }
}
