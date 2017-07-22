
package com.johnmcgrath.interceptors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by root on 6/21/17.
 */

//@Service
public class ExecutionTimerInterceptor extends HandlerInterceptorAdapter {

    private static Logger LOGGER = LoggerFactory.getLogger(ExecutionTimerInterceptor.class);
    long PREHANDLE_TIME = 0;
    long POSTHANDLE_TIME = 0;
    long AFTER_COMPLETION_TIME = 0;



    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        PREHANDLE_TIME = System.currentTimeMillis();
        LOGGER.info("Info Message: PREHANDLE_TIME = " + PREHANDLE_TIME);
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        POSTHANDLE_TIME = System.currentTimeMillis();
        LOGGER.info("Info Message: POSTHANDLE_TIME = " + POSTHANDLE_TIME);

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        AFTER_COMPLETION_TIME = System.currentTimeMillis();
        LOGGER.info("Info Message: AFTER_COMPLETION_TIME = "+ AFTER_COMPLETION_TIME);
        long HANDLER_EXECUTION_TIME = POSTHANDLE_TIME - PREHANDLE_TIME;
        long TOTAL_EXECUTION_TIME = AFTER_COMPLETION_TIME - PREHANDLE_TIME;
        LOGGER.info("Info Message: HANDLER_EXECUTION_TIME = " + HANDLER_EXECUTION_TIME);
        LOGGER.info("Info Message: TOTAL_EXECUTION_TIME = " + TOTAL_EXECUTION_TIME);

    }
}
