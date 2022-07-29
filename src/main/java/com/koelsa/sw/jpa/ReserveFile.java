package com.koelsa.sw.jpa;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "reserve_file")
public class ReserveFile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "res_id")
    private Integer resId;
    private String path;
    private String name;
    private String dupInfo;

}
