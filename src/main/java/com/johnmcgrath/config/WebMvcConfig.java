package com.johnmcgrath.config;





import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;


@Configuration // adds the middle ware or the beans at startup ex.beans.xml
@ComponentScan("com.johnmcgrath")
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {



    @Bean()
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    // @Override
    // public void addViewControllers(ViewControllerRegistry registry){
    //     registry.addViewController("/").setViewName("index");
    // }

    //@Autowired
    //private HeaderInterceptor headerInterceptor;
//
    //@Autowired
    //private ExecutionTimerInterceptor executionTimerInterceptor;
//
    //@Override // use generate to create override method; inject the custom HeaderInterceptor class
    //public void addInterceptors(InterceptorRegistry registry) {
    //    registry.addInterceptor(headerInterceptor);
    //    registry.addInterceptor(executionTimerInterceptor).addPathPatterns("/location");
    //}
}