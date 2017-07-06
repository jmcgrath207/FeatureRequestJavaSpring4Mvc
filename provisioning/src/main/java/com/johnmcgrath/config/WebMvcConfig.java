package com.johnmcgrath.config;



import com.johnmcgrath.interceptors.ExecutionTimerInterceptor;
import com.johnmcgrath.interceptors.HeaderInterceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import javax.sql.DataSource;

@Configuration // adds the middle ware or the beans at startup ex.beans.xml
@ComponentScan("com.johnmcgrath.controller")
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {




    @Bean
    public DataSource dataSource() {
        final JndiDataSourceLookup dsLookup = new JndiDataSourceLookup();
        dsLookup.setResourceRef(true);
        DataSource dataSource = dsLookup.getDataSource("jdbc/springdb");
        return dataSource;
    }


    @Bean()
    public UrlBasedViewResolver urlBasedViewResolver() {
        UrlBasedViewResolver  resolver = new UrlBasedViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        return resolver;
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry){
        registry.addViewController("/").setViewName("index");
    }

    @Autowired
    private HeaderInterceptor headerInterceptor;

    @Autowired
    private ExecutionTimerInterceptor executionTimerInterceptor;

    @Override // use generate to create override method; inject the custom HeaderInterceptor class
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(headerInterceptor);
        registry.addInterceptor(executionTimerInterceptor).addPathPatterns("/location");
    }
}