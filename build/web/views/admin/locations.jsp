<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2 d-flex justify-content-center">
  <div class="row col-md-12">
    <div class="col-5">
      <h3>Thêm vị trí cho sách</h3>
      <form action="${pageContext.request.contextPath}/admin/location" method="post">
        <div class="form-group">
          <label for="floor">Tầng</label>
          <input type="text" class="form-control" id="floor" name="floor" required>
        </div>

        <div class="form-group">
          <label for="room">Phòng</label>
          <input type="text" class="form-control" id="room" name="room" required>
        </div>

        <div class="form-group">
          <label for="bookshelf">Kệ sách</label>
          <input type="text" class="form-control" id="bookshelf" name="bookshelf" required>
        </div>

        <div class="form-group">
          <label for="shelf">Ngăn</label>
          <input type="text" class="form-control" id="shelf" name="shelf" required>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary btn-block">Thêm mới</button>
        </div>
      </form>
    </div>
    <div class="col-7">
      <h3>Danh sách</h3>
      <table class="table table-bordered table-striped" id="table">
        <thead>
        <tr>
          <th>Tầng</th>
          <th>Phòng</th>
          <th>Kệ sách</th>
          <th>Ngăn</th>
          <th>Số lượng sách</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${locations}" var="location">
          <tr>
            <td>${location.getFloor()}</td>
            <td>${location.getRoom()}</td>
            <td>${location.getBookshelf()}</td>
            <td>${location.getShelf()}</td>
            <td>
              <a href="${pageContext.request.contextPath}/admin/view-books-in-location?location_id=${location.getId()}">
                <button class="btn btn-primary">${location.getQuantity()}</button>
              </a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
  $('#table').DataTable();
</script>