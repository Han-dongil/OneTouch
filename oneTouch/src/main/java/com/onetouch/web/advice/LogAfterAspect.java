package com.onetouch.web.advice;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAfterAspect {
	
	@AfterReturning(pointcut = "LogAspect.allpointcut()" , returning = "returing")
	public void logAfter(JoinPoint jp,Object returing) {
		String name =jp.getSignature().getName();
		System.out.println(jp);
		System.out.printf("[after] %s %s",name ,returing);
	}
	
}
