package com.project.controller;

import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.domain.User;
import com.project.service.JoinService;

@Controller
@RequestMapping("/register")
public class JoinController {
    @Autowired
    JoinService joinService;

    @GetMapping("/add")
    public String registerForm() {
        return "registerForm";
    }
    
    @PostMapping("/join")
    public String join(String id, String pwd, String name, String email, @DateTimeFormat(pattern = "yyyy-MM-dd") Date birth, String sns, String toURL, 
                        HttpServletRequest request, HttpServletResponse response) throws Exception {
    	User user = new User();
        user.setId(id);
        user.setPwd(pwd);
        user.setName(name);
        user.setEmail(email);
        user.setBirth(birth);
        user.setSns(sns);
        
        try {
            joinService.join(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        toURL = toURL == null || toURL.equals("") ? "/" : toURL;
        return "redirect:"+toURL;
        
    }
}