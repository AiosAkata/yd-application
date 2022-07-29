package com.koelsa.sw.controller;

import com.koelsa.sw.jpa.YDCnt;
import com.koelsa.sw.jpa.YDReserve;
import com.koelsa.sw.service.YDCounterService;
import com.koelsa.sw.service.YDReserveService;
import com.koelsa.sw.util.PagingInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/cms/cnt")
public class AdminCntController {
    @Autowired
    private YDCounterService ydCounterService;

    @RequestMapping({"","/"})
    public String counter(Model model){
        model.addAttribute("list",ydCounterService.getAll());
        return "admin/counter/list";
    }

    @PostMapping("/save")
    public String save(HttpServletRequest request, Model model){
        List<YDCnt> list = ydCounterService.getAll();

        for(YDCnt cnt : list){
            int number = Integer.parseInt(request.getParameter(cnt.getTime()));
            cnt.setYdCnt(number);
        }

        ydCounterService.saveAll(list);

        model.addAttribute("message","저장되었습니다.");
        model.addAttribute("returnUrl","/cms/cnt");

        return "redirect";
    }
}
