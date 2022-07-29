package com.koelsa.sw.controller;

import com.koelsa.sw.jpa.YDReserve;
import com.koelsa.sw.service.YDReserveService;
import com.koelsa.sw.util.PagingInfo;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/cms/reserve")
public class AdminReserveController {
    @Autowired
    private YDReserveService ydReserveService;

    @RequestMapping({"","/","/list","/list/"})
    public String redirect(){
        LocalDate now = LocalDate.now();

        return "redirect:/cms/reserve/list/"+now+"/13/0";
    }

    @RequestMapping("/list/{dateStr}/{timeStr}/{page}")
    public String list(@PathVariable String dateStr, @PathVariable String timeStr, @PathVariable int page, HttpServletRequest request, Model model){
        LocalDate date = LocalDate.parse(dateStr);
        String time = timeStr + ":00";

        String key = request.getParameter("key");

        Page<YDReserve> pages = ydReserveService.getPages(page,10,date,time,key);
        JSONObject cnt = ydReserveService.getCnt(date,time);

        PagingInfo pagingInfo = new PagingInfo(pages);

        model.addAttribute("pagingInfo",pagingInfo);
        model.addAttribute("key",key);
        model.addAttribute("cnt",cnt);

        return "admin/reserve/list";
    }
}
