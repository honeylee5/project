package com.project.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.project.domain.*;

@Controller
public class SimpleRestController {
//    @GetMapping("/ajax")
//    public String ajax() {
//        return "ajax";
//    }

    @GetMapping("/test")
    public String test() {
        return "test"; // 뷰이름
    }

    @PostMapping("/send")
//  @ResponseBody
//  public Person test(@RequestBody Person p) {
        public Person test(Person p) {
        System.out.println("p = " + p);
        p.setName("ABC");
        p.setAge(p.getAge() + 10);

        return p;
    }
}