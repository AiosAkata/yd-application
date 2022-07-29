package com.koelsa.sw.controller;

import com.koelsa.sw.jpa.SessionUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cms")
public class AdminController {

    @RequestMapping("/header")
    public String header(Model model, HttpSession session){
        SessionUser sessionUser = (SessionUser) session.getAttribute("user");
        model.addAttribute("user",sessionUser);
        return "admin/template/header";
    }

    @RequestMapping({"","/"})
    public String adminMain(){
        return "redirect:/cms/reserve/list";
    }
}
