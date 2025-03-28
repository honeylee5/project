package com.project.board.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.project.board.domain.*;

@Controller
public class SimpleRestController {
    @GetMapping("/test")
    public String test() {
        return "test"; 
    }

    @PostMapping("/send")
    public Person test(Person p) {
    System.out.println("p = " + p);
    p.setName("ABC");
    p.setAge(p.getAge() + 10);

    return p;
    }
}