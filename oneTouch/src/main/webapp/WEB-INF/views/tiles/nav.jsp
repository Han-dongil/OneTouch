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
              <span class="menu-title">공통 관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/BasList">🍊공통코드관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/BomList">🍋제품Bom관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/mngList">🍍공정관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/FlwList">🍒공정흐름관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/FltList">🍑불량코드관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/adm/mtrList">🍓자재정보관리</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
              <i class="icon-columns menu-icon"></i>
              <span class="menu-title">생산 관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="form-elements">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/ordList">♡주문서조회</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/PlanList">♨생산계획관리</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/planListView">★생산계획조회</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/WorkList">♬생산지시관리</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/WorkListView">♣생산지시조회</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/prdPrcList">♠생산공정관리</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/pdt/movingPrc">♀공정이동표</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
              <i class="icon-bar-graph menu-icon"></i>
              <span class="menu-title">자재 관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="charts">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/inForm">🍔입고자재관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/inList">🍕입고자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/outList">🌭출고자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/rtnForm">🍟반품자재관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/rtnList">🥞반품자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/calForm">🥪재고조정관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/calList">🍗재고조정조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/mtr/stckList">🍿재고조회</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
              <i class="icon-grid-2 menu-icon"></i>
              <span class="menu-title">설비 관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="tables">
              <ul class="nav flex-column sub-menu">
            	<li class="nav-item"> <a class="nav-link" href="${path}/fct/fctInfoIns">🦾설비등록</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctInfoSel">🔍설비조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctFix">🛠수리관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctProd">👀점검관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/fct/fctDwtmIns">⚙비동기관리</a></li>
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
                <li class="nav-item"> <a class="nav-link" href="${path}/uat/uia/egovLoginUsr.do">로그인</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/sec/ram/EgovAuthorList.do">권한관리</a></li>
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