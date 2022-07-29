package com.koelsa.sw.repository;


import com.koelsa.sw.jpa.Reserve;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReserveRepository extends JpaRepository<Reserve, Integer> {
    Reserve findByDupInfo(String dupInfo);

    List<Reserve> findAllByDupInfo(String dupInfo);

    @Query("SELECT res FROM Reserve res WHERE res.name like ?1 or res.phone like ?1")
    Page<Reserve> search(Pageable pageable, String key);
}
