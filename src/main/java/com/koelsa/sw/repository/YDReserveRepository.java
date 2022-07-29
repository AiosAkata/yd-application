package com.koelsa.sw.repository;

import com.koelsa.sw.jpa.YDReserve;
import org.apache.tomcat.jni.Local;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface YDReserveRepository extends JpaRepository<YDReserve, Integer> {
    Page<YDReserve> findAllByDateAndTime(Pageable pageable, LocalDate date, String time);
    @Query("SELECT y from YDReserve y WHERE (y.name like ?1 or y.phone like ?2 and y.appNumber like ?3) and y.date = ?4 and y.time = ?5")
    Page<YDReserve> findAllByNameLikeOrPhoneLikeOrAppNumberLikeAndDateAndTime(Pageable pageable, String name, String phone, String appNumber, LocalDate date, String time);
    YDReserve findByAppNumberAndPhone(String appNumber, String phone);
    Integer countAllByDateBetween(LocalDate start, LocalDate end);
    Integer countAllByDateBetweenAndTime(LocalDate start, LocalDate end, String time);
    Integer countAllByDateAndTime(LocalDate date, String time);
    Integer countAllByDateAndTimeAndEnterLike(LocalDate date, String time, String enter);
}
