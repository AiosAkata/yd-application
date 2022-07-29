package com.koelsa.sw.controller;

import com.koelsa.sw.service.YDReserveService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;

@Controller
@RequestMapping("/cms/analysis")
public class AdminAnalysisController {
    @Autowired
    private YDReserveService ydReserveService;

    @RequestMapping({"","/","/main","/main/"})
    public String redirect(){
        LocalDate date = LocalDate.now();
        return "redirect:/cms/analysis/main/" + date;
    }

    @RequestMapping("/main/{dateStr}")
    public String analysisMain(Model model, @PathVariable String dateStr){
        LocalDate date = LocalDate.parse(dateStr);
        LocalDate start = date.minusDays((date.getDayOfWeek().getValue() - 1));
        LocalDate end = date.plusDays((7-date.getDayOfWeek().getValue()));

        JSONArray week = new JSONArray();

        for(LocalDate d = start ; d.isBefore(end) || d.isEqual(end) ; d = d.plusDays(1)){
            JSONObject jsonObject = new JSONObject();
            JSONArray jsonArray1 = ydReserveService.getReserveCounter(d);
            jsonObject.put("date",d);
            jsonObject.put("data",jsonArray1);
            week.add(jsonObject);
        }

        JSONArray day = ydReserveService.getReserveCounter(date);
        JSONArray sumOfTime = ydReserveService.getAdmCounter(start,end);

        model.addAttribute("day", day);
        model.addAttribute("week", week);
        model.addAttribute("start", start);
        model.addAttribute("end", end);
        model.addAttribute("sumOfTime", sumOfTime);

        return "admin/analysis/main";
    }

    @RequestMapping("/get/day")
    @ResponseBody
    public ResponseEntity<Object> getDay(@RequestParam(name = "date") String dateStr){
        try {
            LocalDate date = LocalDate.parse(dateStr);
            JSONArray jsonArray = ydReserveService.getReserveCounter(date);
            return new ResponseEntity<>(jsonArray,HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping("/get/week")
    @ResponseBody
    public ResponseEntity<Object> getWeek(@RequestParam(name = "date") String dateStr){
        try {
            LocalDate date = LocalDate.parse(dateStr);
            LocalDate start = date.minusDays((date.getDayOfWeek().getValue() - 1));
            LocalDate end = date.plusDays((7-date.getDayOfWeek().getValue()));

            JSONArray jsonArray = new JSONArray();

            for(LocalDate d = start ; d.isBefore(end) || d.isEqual(end) ; d = d.plusDays(1)){
                JSONObject jsonObject = new JSONObject();
                JSONArray jsonArray1 = ydReserveService.getReserveCounter(d);
                jsonObject.put("date",d);
                jsonObject.put("data",jsonArray1);
                jsonArray.add(jsonObject);
            }
            return new ResponseEntity<>(jsonArray,HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
