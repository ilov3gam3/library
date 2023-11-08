<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <a href="${pageContext.request.contextPath}/admin/admin-panel">
        <button class="btn btn-primary">Quay về trang quản trị</button>
    </a>
    <h3 class="mt-2">Thêm Sách.</h3>
    <button class="btn btn-warning" data-toggle="modal" data-target="#addModal">
        Thêm sách
    </button>

    <div class="row">
        <h3>Danh sách</h3>
        <table class="table table-bordered table-striped" id="table">
            <thead>
            <tr>
                <th >Tiêu đề</th>
                <th class="text-center">Mô tả</th>
                <th >Tác giả</th>
                <th >Thể loại</th>
                <th >Năm</th>
                <th class="text-center">Số lượng</th>
                <th class="col-2">Ảnh bìa</th>
                <th >Khả dụng</th>
                <th class="col-1">File mềm</th>
                <th class="col-1">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${books}" var="book" >
              <tr>
                <td>${book.getTitle()}</td>
                <td>${book.getDescription()}</td>
              <td>${book.getAuthor_name()}</td>
              <td>${book.getGenre_name()}</td>
              <td>${book.getYear()}</td>
                <td class="text-center">${book.getQuantity()}</td>
                <td class="col-2">
                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt="">
                </td>
                  <td class="text-center">${book.getAvailable() == "1" ? "Có" : "Không"}</td>
                  <td class="col-1">
                      <a href="${pageContext.request.contextPath}${book.getSoft_file()}" style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;" class="btn btn-primary text-center">xem file</a>
                  </td>
                <td class="col-1">
                    <a style="width: 100%" href="/library/admin/genre/delete?id=1">
                        <button class="btn btn-danger btn-block" style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;">Xóa
                        </button>
                    </a>
                    <button type="button" onclick="showMyModal('${book.getId()}','${book.getTitle()}','${book.getDescription()}','${book.getAuthor_id()}','${book.getGenre_id()}','${book.getQuantity()}','${book.price}','${book.getCover_image()}','${book.getSoft_file()}', '${book.getYear()}')" data-toggle="modal" data-target="#editModal" class="btn btn-warning btn-block" style="
        border-top-width: 0;
        border-left-width: 0;
        border-right-width: 0;
        padding-right: 0;
        padding-left: 0;
    min-width: 70px;">Sửa
                    </button>
                </td>
              </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Chỉnh sửa</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container col-md-12">
                    <form action="${pageContext.request.contextPath}/admin/book" method="post" enctype="multipart/form-data">
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="title">
                                Tựa đề </label>
                            <div class="col-md-12">
                                <input class="form-control" id="title" name="title" type="text" required="">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="description">
                                Mô tả
                            </label>
                            <div class="col-md-12">
                        <textarea class="form-control" name="description" id="description" rows="8" style="width: 100%"
                                  required></textarea>
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="author_id">
                                Tác giả
                            </label>
                            <div class="col-md-12">
                                <select name="author_id" id="author_id"
                                        class="form-control">
                                    <c:forEach items="${authors}" var="author">
                                        <option value="${author.getId()}">${author.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row justify-content-center ">
                            <a href="${pageContext.request.contextPath}/admin/author" target="_blank">
                                <button class="btn col-11 btn-primary" type="button">Thêm tác giả</button>
                            </a>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="genre_id">
                                Thể loại
                            </label>
                            <div class="col-md-12">
                                <select name="genre_id" id="genre_id"
                                        class="form-control">
                                    <c:forEach items="${genres}" var="genre">
                                        <option value="${genre.getId()}">${genre.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="year">Năm hoàn thành</label>
                            <input type="text" name="year" id="year" required class="form-control">
                        </div>

                        <div class="form-group row justify-content-center ">
                            <a href="${pageContext.request.contextPath}/admin/genre" target="_blank">
                                <button class="btn col-11 btn-primary" type="button">Thêm thể loại mới</button>
                            </a>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="location_id">
                                Vị trí sách
                            </label>
                            <div class="col-md-12">
                                <select name="location_id" id="location_id"
                                        class="form-control">
                                    <c:forEach items="${locations}" var="location">
                                        <option value="${location.getId()}">Tầng ${location.getFloor()}, phòng ${location.getRoom()}, kệ sách ${location.getBookshelf()}, ngăn thứ ${location.getShelf()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row justify-content-center ">
                            <a href="${pageContext.request.contextPath}/admin/genre" target="_blank">
                                <button class="btn col-11 btn-primary" type="button">Thêm thể loại mới</button>
                            </a>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="quantity">
                                Số lượng </label>
                            <div class="col-md-12">
                                <input class="form-control" id="quantity" name="quantity" type="number" required="">
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="price">
                                Giá/ngày </label>
                            <div class="col-md-12">
                                <input class="form-control" id="price" name="price" type="number" required="">
                            </div>
                        </div>

                        <div class="form-group row justify-content-center ">
                            <label class="col-md-11 form-control-label required btn btn-outline-primary-2" for="image">
                                Ảnh bìa
                            </label>
                            <div class="col-md-12">
                                <input hidden class="form-control" id="image" name="image" type="file"  required="">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <div class="col-md-12">
                                <img id="previewImage" hidden="until-found" alt="Uploaded Image" style="max-height: 400px; width: 100%" >
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <div class="col-md-12">
                                <input class="form-control" id="soft_file" name="soft_file" type="file"  required="" accept="application/pdf">
                            </div>
                        </div>
                        <div class="form-group row justify-content-center ">
                            <button class="btn col-11 btn-outline-primary-2 btn-block " id="submit" type="submit">
                                Thêm Sách
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="">Chỉnh sửa</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/book/edit" method="post" enctype="multipart/form-data">
                    <div class="container">
                        <input type="hidden" name="id" id="id">
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_title">
                                Tựa đề </label>
                            <div class="col-md-12">
                                <input class="form-control" id="update_title" name="update_title" type="text" required="">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_description">
                                Mô tả
                            </label>
                            <div class="col-md-12">
                        <textarea class="form-control" name="update_description" id="update_description" rows="8" style="width: 100%"
                                  required></textarea>
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_author_id">
                                Tác giả
                            </label>
                            <div class="col-md-12">
                                <select name="update_author_id" id="update_author_id" data-placeholder="Chọn tác giả"
                                        class="form-control">
                                    <c:forEach items="${authors}" var="author">
                                        <option value="${author.getId()}">${author.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_genre_id">
                                Thể loại
                            </label>
                            <div class="col-md-12">
                                <select name="update_genre_id" id="update_genre_id" data-placeholder="Chọn thể loại"
                                        class="form-control">
                                    <c:forEach items="${genres}" var="genre">
                                        <option value="${genre.getId()}">${genre.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="year_update">Năm hoàn thành</label>
                            <input type="text" name="year_update" id="year_update" required class="form-control">
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_quantity">
                                Số lượng </label>
                            <div class="col-md-12">
                                <input class="form-control" id="update_quantity" name="update_quantity" type="number" required="">
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="update_price">
                                Giá/ngày </label>
                            <div class="col-md-12">
                                <input class="form-control" id="update_price" name="update_price" type="number" required="">
                            </div>
                        </div>

                        <div class="form-group row justify-content-center ">
                            <label class="col-md-11 form-control-label required btn btn-outline-primary-2" for="update_image">
                                Ảnh bìa
                            </label>
                            <div class="col-md-12">
                                <input hidden class="form-control" id="update_image" name="update_image" type="file" >
                            </div>
                        </div>
                        <div class="form-group row ">
                            <div class="col-md-12 d-flex justify-content-center">
                                <img id="update_previewImage" style="width: 400px" >
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <div class="col-md-12">
                                <input class="form-control" id="update_soft_file" name="update_soft_file" type="file" accept="application/pdf">
                            </div>
                        </div>
                        <div class="container">
                            <div class="form-group row align-items-center ">
                                <button class="btn btn-outline-primary-2 btn-block" id="submit_update" type="submit">
                                    Cập nhật
                                </button>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    const contextPath = '${pageContext.request.contextPath}'
    function showMyModal(id, name, description,author,genre,quantity,price,book_cover,soft_file, year) {
        $("#update_title").val(name)
        $("#id").val(id)
        $("#update_price").val(price)
        $("#update_author_id").val(author)
        $("#update_genre_id").val(genre)
        $("#update_description").val(description)
        $("#update_quantity").val(quantity)
        $("#update_previewImage").attr("src", contextPath + book_cover)
        $("#year_update").val(year)
    }
    $(document).ready(function () {
        document.getElementById('image').addEventListener('change', function (e) {
            var file = e.target.files[0];
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('previewImage').setAttribute('src', e.target.result);
                document.getElementById('previewImage').removeAttribute('hidden');
            }
            reader.readAsDataURL(file);
        });
        document.getElementById('update_image').addEventListener('change', function (e) {
            var file = e.target.files[0];
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('update_previewImage').setAttribute('src', e.target.result);
                document.getElementById('update_previewImage').removeAttribute('hidden');
            }
            reader.readAsDataURL(file);
        });
        $("#editModal").on("hidden.bs.modal", function () {
            $("#update_title").val("")
            $("#id").val("")
            $("#update_description").val("")
            $("#update_author_id").val("")
            $("#update_genre_id").val("")
            $("#update_quantity").val("")
            $("#update_image").val("")
            $("#update_soft_file").val("")
        });
    })
    $("#table").DataTable()
</script>