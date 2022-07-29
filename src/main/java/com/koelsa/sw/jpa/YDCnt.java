package com.koelsa.sw.jpa;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@Table(name = "yd_cnt")
public class YDCnt {
    @Id
    private int id;
    private int ydCnt;
    private String time;
}
