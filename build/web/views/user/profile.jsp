<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="container">
  <div class="row mt-2">
    <div class="col-md-6">
        <h3>Thông tin cá nhân của bạn.</h3>
        <form action="" method="post">
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label">
              Social title                    </label>
            <div class="col-md-10 form-control-valign">
              <label class="radio-inline">
                    <span class="custom-radio">
                        <input name="gender" type="radio" value="true" <%=user.gender.equals("1") ? "checked" : ""%>>
                        <span></span>
                    </span>
                Mr.
              </label>
              <label class="radio-inline">
                    <span class="custom-radio">
                        <input name="gender" type="radio" value="false" <%=user.gender.equals("0") ? "checked" : ""%>>
                        <span></span>
                    </span>
                Mrs.
              </label>
            </div>
            <div class="col-md-2 form-control-comment">
            </div>
          </div>
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label required" for="name">
              Tên                 </label>
            <div class="col-md-10">
              <input class="form-control" id="name" name="name" type="text" value="<%=user.name%>" required="">
              <span class="form-control-comment">
                        Only letters and the dot (.) character, followed by a space, are allowed.
                    </span>
            </div>
            <div class="col-md-2 form-control-comment">
            </div>
          </div>
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label required" for="email">
              Địa chỉ email                  </label>
            <div class="col-md-10">
              <input class="form-control" id="email" name="email" type="email" value="<%=user.email%>" required="">
              <span class="form-control-comment">
                        Only letters and the dot (.) character, followed by a space, are allowed.
                    </span>
            </div>
            <div class="col-md-2 form-control-comment">
            </div>
          </div>
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label required" for="phone">
              Số điện thoại                    </label>
            <div class="col-md-10">
              <input class="form-control" id="phone" name="phone" type="tel" value="<%=user.phone%>" required="">
            </div>
            <div class="col-md-2 form-control-comment">
            </div>
          </div>
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label" for="dob">
              Ngày sinh                    </label>
            <div class="col-md-10">
              <input class="form-control" name="dob" id="dob" type="date" value="<%=user.dob%>">
              <span class="form-control-comment">
                        (E.g.: 05/31/1970)
                    </span>
            </div>
          </div>
          <div class="form-group row align-items-center ">
            <label class="col-md-12 form-control-label" for="address">
              Địa chỉ                </label>
            <div class="col-md-10">
              <input class="form-control" name="address" id="address" value="<%=user.address%>" required type="text">
            </div>
          </div>
          <footer class="form-footer clearfix col-md-10">
              <div class="row col-md-12">
                  <div class="col-md-6">
                      <button class="btn btn-outline-primary-2 btn-block" data-link-action="save-customer" type="submit">
                          Lưu thay đổi
                      </button>
                  </div>
                  <div class="col-md-6">
                      <a href="${pageContext.request.contextPath}/user/change-password">
                          <button class="btn btn-outline-danger btn-block" data-link-action="save-customer" type="button">
                              Đổi mật khẩu
                          </button>
                      </a>
                  </div>
              </div>
          </footer>
      </form>
    </div>
    <div class="col-md-6 ">
        <form action="${pageContext.request.contextPath}/user/change-avatar" method="post" enctype="multipart/form-data">
            <h3 >Ảnh đại diện.</h3>
            <div class="col-md-12 d-flex justify-content-center">
                <% if (user.avatar.startsWith("http")) {%>
                <img id="previewImage" src="<%=user.avatar%>"
                     style="max-height: 400px; max-width: 100%"
                     alt="">
                <% } else { %>
                <img id="previewImage" src="${pageContext.request.contextPath}<%=user.avatar%>"
                     style="max-height: 400px; max-width: 100%"
                     alt="">
                <% } %>
            </div>
            <div class="col-md-12 d-flex justify-content-center mt-2" id="1_button">
                <label for="image" style="width: 100%" class="btn btn-primary">Đổi ảnh đại diện</label>
                <input hidden type="file" name="image" id="image">
            </div>
            <div class="col-md-12 d-flex justify-content-center mt-2 hidden" id="3_button">
                <div class="col-md-4">
                    <label for="image" class="btn btn-outline-primary btn-block">Đổi ảnh đại diện</label>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary btn-block" type="submit">Cập nhật</button>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-danger btn-block" type="button" id="cancel">Hủy</button>
                </div>
            </div>
        </form>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    const current_avatar = "${pageContext.request.contextPath}<%=user.getAvatar()%>"
    document.getElementById('image').addEventListener('change', function (e) {
        var file = e.target.files[0];
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('previewImage').setAttribute('src', e.target.result);
        }
        reader.readAsDataURL(file);
        $("#1_button").addClass("hidden")
        $("#3_button").removeClass("hidden")
    });
    $("#cancel").on('click', function () {
        $("#1_button").removeClass("hidden")
        $("#3_button").addClass("hidden")
        document.getElementById('previewImage').setAttribute('src', current_avatar);
    })
</script>