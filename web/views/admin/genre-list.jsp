<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <div class="row">
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/admin/admin-panel">
                <button class="btn btn-primary">Quay về trang quản trị</button>
            </a>
            <h3 class="mt-2">Thêm Thể Loại Sách.</h3>
            <form action="${pageContext.request.contextPath}/admin/genre" method="post">
                <div class="form-group row align-items-center ">
                    <label class="col-md-12 form-control-label required" for="name">
                        Tên </label>
                    <div class="col-md-12">
                        <input class="form-control" id="name" name="name" type="text" required="">
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
                    <button class="btn btn-outline-primary-2 btn-block" id="submit" type="submit">
                        Thêm thể loại
                    </button>
                </div>
            </form>
        </div>
        <div class="col-md-8 text-center">
            <h3>Genre List</h3>
            <table class="table table-bordered table-striped" id="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th class="col-4">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${genre_list}" var="genre" >
                    <tr>
                        <td>${genre.id}</td>
                        <td>${genre.name}</td>
                        <td>${genre.description}</td>
                        <td class="col-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <a style="width: 100%"
                                       href="${pageContext.request.contextPath}/admin/genre/delete?id=${genre.id}">
                                        <button class="btn btn-danger btn-block" style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;">Xóa
                                        </button>
                                    </a>
                                </div>
                                <div class="col-md-6">
                                        <button type="button" onclick="showMyModal('${genre.id}', '${genre.name}', '${genre.description}')" data-toggle="modal" data-target="#editModal" class="btn btn-warning btn-block" style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;">Sửa
                                        </button>
                                </div>
                            </div>
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
                <h5 class="modal-title" id="exampleModalLabel">Cỉnh sửa</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/genre/edit" method="post">
                    <div class="container">
                        <input type="hidden" name="id" id="id">
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="name_update">
                                Tên </label>
                            <div class="col-md-12">
                                <input class="form-control" id="name_update" name="name_update" type="text" required="">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="description_update">
                                Mô tả
                            </label>
                            <div class="col-md-12">
                            <textarea class="form-control" name="description_update" id="description_update" rows="8" style="width: 100%"
                                  required></textarea>
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
    function showMyModal(id, name, description) {
        $("#name_update").val(name)
        $("#id").val(id)
        $("#description_update").val(description)
    }
$(document).ready(function () {
    $("#submit").on('click', function (e) {
            var toastr_text = ""
            if ($("#name").val() === "") {
                toastr_text += "Tên";
            }
            if ($("#description").val() === "") {
                if (toastr_text === "") {
                    toastr_text += "Mô tả";
                } else {
                    toastr_text += ", mô tả";
                }
            }
            if (toastr_text !== "") {
                e.preventDefault()
                toastr.warning(toastr_text + " không được để trống.")
            }
        })
    $("#submit_update").on('click', function (e) {
        var toastr_text = ""
        if ($("#name_update").val() === "") {
            toastr_text += "Tên";
        }
        if ($("#description_update").val() === "") {
            if (toastr_text === "") {
                toastr_text += "Mô tả";
            } else {
                toastr_text += ", mô tả";
            }
        }
        if (toastr_text !== "") {
            e.preventDefault()
            toastr.warning(toastr_text + " không được để trống.")
        }
    })
    $('#table').DataTable();
    $("#editModal").on("hidden.bs.modal", function () {
        $("#name_update").val("")
        $("#id").val("")
        $("#description_update").val("")
    });
});
</script>