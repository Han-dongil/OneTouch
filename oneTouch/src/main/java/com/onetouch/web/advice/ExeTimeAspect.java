package com.onetouch.web.advice;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class ExeTimeAspect {
	@Around("LogAspect.allpointcut()")
	public Object measure(ProceedingJoinPoint pjp) throws Throwable {
		long start = System.nanoTime();
		Object result = pjp.proceed(); // ���� �޼��� ȣ��
		
		long finish = System.nanoTime();
		System.out.println("[around] ����ð� : " + (finish-start));
		return result;
		
	}
}
