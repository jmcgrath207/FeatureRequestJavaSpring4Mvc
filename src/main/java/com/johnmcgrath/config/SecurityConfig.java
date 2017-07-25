//package com.johnmcgrath.config;
//
//import org.springframework.beans.factory.annotation.Autowired;
//
//import org.springframework.context.annotation.*;
//import org.springframework.security.config.annotation.authentication.builders.*;
//import org.springframework.security.config.annotation.web.configuration.*;
//
//
//
//// http://docs.spring.io/spring-security/site/docs/3.2.0.RC2/reference/htmlsingle/#jc
//
//// http://www.concretepage.com/spring-4/spring-mvc-4-security-hibernate-5-mysql-using-annotation-xml-example
//
//@Configuration
//@EnableWebSecurity
//public class SecurityConfig extends WebSecurityConfigurerAdapter {
//
//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        auth
//                .inMemoryAuthentication()
//                .withUser("user").password("password").roles("USER");
//    }
//}