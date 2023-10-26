<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/master/head.jsp" %>
<%@ page pageEncoding="utf-8" %>

<div class="container ">
  <a href="${pageContext.request.contextPath}/admin/admin-panel">
    <button class="btn btn-primary">Quay về trang quản trị</button>
  </a>
  <div class="row">
    <div class="text-center">
      <h3>User List</h3>
      <table class="table table-bordered table-striped" id="table">
        <thead>
        <tr>
          <th scope="col">Name</th>
          <th scope="col">Email</th>
          <th scope="col">Phone</th>
          <th scope="col">DOB</th>
          <th scope="col">Address</th>
          <th scope="col">Xác thực tài khoản</th>
          <th scope="col">Role</th>
          <th scope="col">Chặn</th>
          <th scope="col">Xác thực</th>
          <th scope="col">Giới tính</th>
          <th scope="col">Avatar</th>
          <th class="col-1">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
          <tr>
            <td>${user.getName()}</td>
            <td>${user.email}</td>
            <td>${user.phone}</td>
            <td>${user.dob}</td>
            <td>${user.address}</td>
            <td>${user.is_verify  == "1" ? "Đã xác thực" : "Chưa xác thực"}</td>
            <td>${user.getIs_admin() == "1" ? "admin" : "user"}</td>
            <td>
              <select onchange="changeIsBlock('${user.getId()}', this.value)" name="block">
                <option ${user.is_block  == "1" ? "selected " : ""} value="true">Có</option>
                <option ${user.is_block  == "1" ? " " : "selected"} value="false">Không</option>
              </select>
            </td>
            <td>
              <select onchange="changeVerify('${user.getId()}', this.value)" name="verify">
                <option ${user.getIs_verify()  == "1" ? "selected " : ""} value="true">Rồi</option>
                <option ${user.getIs_verify()  == "1" ? " " : "selected"} value="false">Chưa</option>
              </select>
            </td>
            <td>${user.gender  == "1" ? "Nam" : "Nữ"}</td>
            <c:choose>
              <c:when test="${fn:startsWith(user.getAvatar(), 'http')}">
                <td><img src="${user.getAvatar()}" alt="Uploaded Image"></td>
              </c:when>
              <c:otherwise>
                <td><img src="${pageContext.request.contextPath}${user.getAvatar()}" alt="Uploaded Image"></td>
              </c:otherwise>
            </c:choose>

            <td class="col-1">
              <a role="button" style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;" class="btn btn-warning" data-toggle="modal" data-target="#editModal" onclick="showUpdateModal('${user.getId()}', '${user.getName()}', '${user.getEmail()}', '${user.getPhone()}', '${user.getAvatar()}', '${user.getDob()}', '${user.getAddress()}','${user.getGender()}')" >Edit</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Chỉnh sửa user</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="container">
              <form action="${pageContext.request.contextPath}/admin/user/update" method="post" enctype="multipart/form-data">
                  <input type="hidden" name="update_id" id="update_id">
                  <div class="form-group">
                      <label for="update_name">Tên</label>
                      <input required type="text" class="form-control" name="update_name" id="update_name">
                  </div>

                  <div class="form-group">
                      <label for="update_email">Email</label>
                      <input required type="text" class="form-control" name="update_email" id="update_email">
                  </div>

                  <div class="form-group">
                      <label for="update_phone">Số điện thoại</label>
                      <input required type="tel" class="form-control" name="update_phone" id="update_phone">
                  </div>

                  <div class="form-group">
                      <label for="update_gender">Giới tính</label>
                      <select class="form-control" name="update_gender" id="update_gender">
                          <option id="update_gender_male" value="true">Nam</option>
                          <option id="update_gender_female" value="false">Nữ</option>
                      </select>
                  </div>

                  <div class="form-group d-flex justify-content-center">
                      <img src="" alt="Avatar" id="update_avatar_img">
                  </div>

                  <div class="form-group">
                      <label class="btn btn-primary btn-block" for="update_avatar">Đổi ảnh đại diện</label>
                      <input hidden="" type="file" class="form-control" name="update_avatar" id="update_avatar">
                  </div>

                  <div class="form-group">
                      <label for="update_dob">Ngày sinh</label>
                      <input required type="date" class="form-control" name="update_dob" id="update_dob">
                  </div>
                  <div class="form-group">
                      <label for="update_address">Địa chỉ</label>
                      <input required type="text" class="form-control" name="update_address" id="update_address">
                  </div>
                  <div class="form-group">
                      <label for="update_password">Mật khẩu</label>
                      <input type="text" class="form-control" name="update_password" id="update_password">
                  </div>
                  <div class="form-group">
                      <button class="btn btn-primary">Cập nhật</button>
                  </div>
              </form>
          </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
$(document).ready(function () {
    $('#table').DataTable();
});
function changeIsBlock(user_id, value) {
const postData = {
  'user_id' : user_id,
  'status' : value
}
$.ajax({
  type: "POST",
  url: "${pageContext.request.contextPath}/admin/user/block",
  data: postData,
  dataType: 'JSON',
  success: function (x) {
    if (x.status) {
      toastr.success(x.message, "Thành công.")
    } else {
      toastr.error(x.message, "Lỗi.")
    }
  }
});
}
function changeVerify(user_id, value) {
const postData = {
  'user_id' : user_id,
  'status' : value
}
$.ajax({
  type: "POST",
  url: "${pageContext.request.contextPath}/admin/user/verify",
  data: postData,
  dataType: 'JSON',
  success: function (x) {
    if (x.status) {
      toastr.success(x.message, "Thành công.")
    } else {
      toastr.error(x.message, "Lỗi.")
    }
  }
});
}
document.getElementById('update_avatar').addEventListener('change', function (e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        document.getElementById('update_avatar_img').setAttribute('src', e.target.result);
    }
    reader.readAsDataURL(file);
});
function showUpdateModal(id, name, email, phone, avatar, dob, address, gender) {
    $("#update_id").val(id)
    $("#update_name").val(name)
    $("#update_email").val(email)
    $("#update_phone").val(phone)
    $("#update_dob").val(dob)
    $("#update_address").val(address)
    if (gender === "1"){
        $("#update_gender_male").attr("selected", true)
    } else {
        $("#update_gender_female").attr("selected", true)
    }
}
</script>