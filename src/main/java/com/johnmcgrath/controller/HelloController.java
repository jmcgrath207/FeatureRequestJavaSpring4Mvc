
package com.johnmcgrath.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class HelloController {

    @RequestMapping("/")
    public String showhello(ModelMap model) {
        model.addAttribute("message", "Hello BEEEzzzzzzzzzzzzzzzzzzzzzzzzzzEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE!");
        System.out.println("ClientViewPostgre ClientViewPostgre");
        return "index";
    }

}