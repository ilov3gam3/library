<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
  <div class="breadcrumb page-header text-center">
    <div class="container">
      <h1 class="page-title">Tìm vị trí sách</h1>
    </div>
  </div>
  <div class="container mt-2">
    <div class="row col-12">
      <form action="${pageContext.request.contextPath}/admin/find-book-location" method="post">
        <div class="row">
          <div class="col-md-4">
            <h4 class="mt-1">Nhập tên sách</h4>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <input type="text" class="form-control" id="name_id" name="name_id">
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <button class="btn btn-block btn-primary">Tìm kiếm</button>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div class="row col-12">
      <table class="table table-striped" id="table">
        <thead>
        <tr>
          <th >ID sách</th>
          <th class="text-center">Tên sách</th>
          <th >Vị trí</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${books}" var="book">
          <tr>
            <td>${book.getId()}</td>
            <td>
              <a href="${pageContext.request.contextPath}/view-book?id=${book.getId()}">
                  ${book.getTitle()}
              </a>
            </td>
            <td>${book.getLocation_name()}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
  $("#table").DataTable()
  $("#table_wrapper").css({"width": "100%"})
</script>