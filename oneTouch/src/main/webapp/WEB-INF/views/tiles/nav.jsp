<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav"> 
          <li class="nav-item">
            <a class="nav-link" href="${path}/brd/dashBoard">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <i class="icon-layout menu-icon"></i>
              <span class="menu-title">κ³΅ν΅ κ΄λ¦¬</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/BasList">πκ³΅ν΅μ½λκ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/BomList">πμ νBomκ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/mngList">πκ³΅μ κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/FlwList">πκ³΅μ νλ¦κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/FltList">πλΆλμ½λκ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/mtrList">πμμ¬μ λ³΄κ΄λ¦¬</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
              <i class="icon-columns menu-icon"></i>
              <span class="menu-title">μμ° κ΄λ¦¬</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="form-elements">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/ordList">β‘μ£Όλ¬Έμμ‘°ν</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/PlanList">β¨μμ°κ³νκ΄λ¦¬</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/planListView">βμμ°κ³νμ‘°ν</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/WorkList">β¬μμ°μ§μκ΄λ¦¬</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/WorkListView">β£μμ°μ§μμ‘°ν</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/prdPrcList">β μμ°κ³΅μ κ΄λ¦¬</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/movingPrc">βκ³΅μ μ΄λν</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
              <i class="icon-bar-graph menu-icon"></i>
              <span class="menu-title">μμ¬ κ΄λ¦¬</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="charts">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/inForm">πμκ³ μμ¬κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/inList">πμκ³ μμ¬μ‘°ν</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/outList">π­μΆκ³ μμ¬μ‘°ν</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/rtnForm">πλ°νμμ¬κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/rtnList">π₯λ°νμμ¬μ‘°ν</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/calForm">π₯ͺμ¬κ³ μ‘°μ κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/calList">πμ¬κ³ μ‘°μ μ‘°ν</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/stckList">πΏμ¬κ³ μ‘°ν</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
              <i class="icon-grid-2 menu-icon"></i>
              <span class="menu-title">μ€λΉ κ΄λ¦¬</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="tables">
              <ul class="nav flex-column sub-menu">
            	<li class="nav-item"> <a class="nav-link" href="${path}/fct/fctInfoIns">π¦Ύμ€λΉλ±λ‘</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctInfoSel">πμ€λΉμ‘°ν</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctFix">π μλ¦¬κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctProd">πμ κ²κ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctDwtmIns">βλΉκ°λκ΄λ¦¬</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctDwtmSel">λΉκ°λμ‘°ν</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#icons" aria-expanded="false" aria-controls="icons">
              <i class="icon-contract menu-icon"></i>
              <span class="menu-title">egov</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="icons">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/uat/uia/egovLoginUsr.do">λ‘κ·ΈμΈ</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/sec/ram/EgovAuthorList.do">κΆνκ΄λ¦¬</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              <i class="icon-head menu-icon"></i>
              <span class="menu-title">User Pages</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/samples/login.html"> Login </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/register.html"> Register </a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#error" aria-expanded="false" aria-controls="error">
              <i class="icon-ban menu-icon"></i>
              <span class="menu-title">Error pages</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="error">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/samples/error-404.html"> 404 </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/error-500.html"> 500 </a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/documentation/documentation.html">
              <i class="icon-paper menu-icon"></i>
              <span class="menu-title">Documentation</span>
            </a>
          </li>
        </ul>
      </nav>