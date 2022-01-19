<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav"> 
          <li class="nav-item">
            <a class="nav-link" href="ordList">
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
                <li class="nav-item"> <a class="nav-link" href="BasList">공통코드관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="BomList">제품Bom관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="mngList">공정관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="FlwList">공정흐름관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="FltList">불량코드관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="mtrList">자재정보관리</a></li>
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
                <li class="nav-item"><a class="nav-link" href="ordList">♡동일쓰ㅋㅋ</a></li>
                <li class="nav-item"><a class="nav-link" href="PlanList">♨동일쓰ㅋㅋ</a></li>
                <li class="nav-item"><a class="nav-link" href="WorkList">♬동일쓰ㅋㅋ</a></li>
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
                <li class="nav-item"> <a class="nav-link" href="inForm">입고자재관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="inList">입고자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="outList">출고자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="rtnForm">반품자재관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="rtnList">반품자재조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="stckList">현재재고조회</a></li>
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
                <li class="nav-item"> <a class="nav-link" href="ftcIhfoIns">설비등록</a></li>
                <li class="nav-item"> <a class="nav-link" href="ftcIhfoSel">설비조회</a></li>
                <li class="nav-item"> <a class="nav-link" href="ftcFix">수리관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="ftcProd">정기점검관리</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#icons" aria-expanded="false" aria-controls="icons">
              <i class="icon-contract menu-icon"></i>
              <span class="menu-title">Icons</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="icons">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/icons/mdi.html">Mdi icons</a></li>
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