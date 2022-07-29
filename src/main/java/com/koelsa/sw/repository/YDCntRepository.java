package com.koelsa.sw.repository;

import com.koelsa.sw.jpa.YDCnt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface YDCntRepository extends JpaRepository<YDCnt, Integer> {
    YDCnt findByTime(String time);
}
