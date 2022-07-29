package com.koelsa.sw.jpa;

import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Where(clause = "deleted_at is null")
@SQLDelete(sql = "UPDATE hamo_fes SET deleted_at=CURRENT_TIMESTAMP WHERE id=?")
@Table(name = "reserve")
public class Reserve {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    private String gender;
    private String phone;
    private String birth;
    private String email;
    private String dupInfo;
    @CreationTimestamp
    private LocalDateTime createdAt;
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    private LocalDateTime deletedAt;
    private String memo;
    private String status;
    private String file1;
    private String filename1;
    private String file2;
    private String filename2;

}
