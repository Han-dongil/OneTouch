package com.onetouch.web.advice;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAspect {
	@Pointcut("execution( * com.onetouch.web..*Impl.*(..))")
	public void allpointcut() {}
	@Before("allpointcut()")
	public void printLog(JoinPoint jp) {
		String name = jp.getSignature().getName();
		Object[] objs =jp.getArgs();
		System.out.println(String.format("[before] %s: arg: %s",name,(objs!=null && objs.length>0?objs[0]:"") ));
	}
}
