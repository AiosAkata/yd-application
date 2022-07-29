package com.koelsa.sw.service;

import com.koelsa.sw.jpa.YDCnt;
import com.koelsa.sw.jpa.YDReserve;
import com.koelsa.sw.repository.YDCntRepository;
import com.koelsa.sw.repository.YDReserveRepository;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDate;

@Service
public class YDReserveService {
    @Autowired
    private YDReserveRepository ydReserveRepository;
    @Autowired
    private YDCntRepository ydCntRepository;

    private final static int startTime = 13;
    private final static int endTime = 21;

    public JSONObject getCnt(LocalDate date, String time){
        JSONObject jsonObject = new JSONObject();

        int total = ydCntRepository.findByTime(time).getYdCnt();
        int user = ydReserveRepository.countAllByDateAndTime(date,time);
        int bugyo1 = ydReserveRepository.countAllByDateAndTimeAndEnterLike(date,time,"%1부교%");
        int bugyo2 = ydReserveRepository.countAllByDateAndTimeAndEnterLike(date,time,"%2부교%");

        int dayOfWeek = date.getDayOfWeek().getValue();

        if(dayOfWeek == 6 || dayOfWeek == 7){
            if(time.equals("13:00") || time.equals("15:00")){
                int castle = ydReserveRepository.countAllByDateAndTimeAndEnterLike(date,time,"%진주성%");
                int manggyeong = ydReserveRepository.countAllByDateAndTimeAndEnterLike(date,time,"%망경%");
                jsonObject.put("castle",castle);
                jsonObject.put("manggyeong",manggyeong);
            }
        }

        jsonObject.put("total",total);
        jsonObject.put("user",user);
        jsonObject.put("bugyo1",bugyo1);
        jsonObject.put("bugyo2",bugyo2);

        return jsonObject;
    }

    public JSONArray getAdmCounter(LocalDate start, LocalDate end){
        JSONArray jsonArray = new JSONArray();

        for( int i = startTime ; i <= endTime ; i++){
            JSONObject jsonObject = new JSONObject();
            String time = i + ":00";
            int user = ydReserveRepository.countAllByDateBetweenAndTime(start,end,time);

            jsonObject.put("count",user);
            jsonObject.put("time",time);
            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }

    public JSONArray getReserveCounter(LocalDate date){
        JSONArray jsonArray = new JSONArray();


        for( int i = startTime ; i <= endTime ; i++){
            JSONObject jsonObject = new JSONObject();
            String time = i + ":00";
            int user = ydReserveRepository.countAllByDateAndTime(date,time);

            jsonObject.put("count",user);
            jsonObject.put("time",time);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    public Page<YDReserve> getPages(int page, int showNum, LocalDate date, String time, String searchKey){
        PageRequest pageRequest = PageRequest.of(page,showNum, Sort.by(Sort.Direction.DESC,"id"));
        Page<YDReserve> reserve = ydReserveRepository.findAllByDateAndTime(pageRequest,date,time);
        if(searchKey != null){
            searchKey = "%"+searchKey+"%";
            reserve = ydReserveRepository.findAllByNameLikeOrPhoneLikeOrAppNumberLikeAndDateAndTime(pageRequest,searchKey,searchKey,searchKey,date,time);
        }
        return reserve;
    }

    public YDReserve findByAppNumberAndPhone(String appNumber, String phone){
        return ydReserveRepository.findByAppNumberAndPhone(appNumber,phone);
    }

    @Transactional
    public YDReserve getOne(int id){
        return ydReserveRepository.getOne(id);
    }

    @Transactional
    public YDReserve save(YDReserve ydReserve){
        return ydReserveRepository.save(ydReserve);
    }

    @Modifying
    @Transactional
    public void deleteById(Integer id){
        ydReserveRepository.deleteById(id);
    }
}
