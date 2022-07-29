package com.koelsa.sw.jpa;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "yd_reserve")
public class YDReserve {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String phone;
    private String gender;
    private String vac;
    private String enter;
    private String appNumber;
    private String time;
    private String originName;
    private String originPhone;
    private String type;
    private LocalDate date;
}
