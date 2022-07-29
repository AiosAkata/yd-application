package com.koelsa.sw.service;

import com.koelsa.sw.jpa.YDCnt;
import com.koelsa.sw.repository.YDCntRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class YDCounterService {
    @Autowired
    private YDCntRepository ydCntRepository;

    @Transactional
    public List<YDCnt> getAll(){
        return ydCntRepository.findAll(Sort.by(Sort.Direction.ASC,"id"));
    }

    public List<YDCnt> saveAll(List<YDCnt> list){
        return ydCntRepository.saveAll(list);
    }

}
