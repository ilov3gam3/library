<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
  <div class="breadcrumb page-header text-center">
    <div class="container">
      <h1 class="page-title">Trang quản trị</h1>
    </div>
  </div>
  <div class="col-12 justify-content-center mt-2">
    <div class="row">
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/genre" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Thể loại
          </button>
        </a>
      </div>
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/author" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Tác giả
          </button>
        </a>
      </div>
    </div>
  </div>
  <div class="col-12 justify-content-center mt-2">
    <div class="row">
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/book" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Sách
          </button>
        </a>
      </div>
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/payment" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Quản lý tiền nạp vào
          </button>
        </a>
      </div>
    </div>
  </div>
  <div class="col-12 justify-content-center mt-2">
    <div class="row">
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/location" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Quản lý vị trí sách
          </button>
        </a>
      </div>
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/rentals" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Quản lý đơn mượn sách
          </button>
        </a>
      </div>
    </div>
  </div>
  <div class="col-12 justify-content-center mt-2">
    <div class="row">
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/user" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Quản lý người dùng
          </button>
        </a>
      </div>
      <div class="col-6 ">
        <a href="${pageContext.request.contextPath}/admin/rentals" style="width: 100%">
          <button class="btn btn-primary btn-block">
            Quản lý đơn mượn sách
          </button>
        </a>
      </div>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>