<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/master/head.jsp" %>
<%@ page pageEncoding="utf-8" %>

<div class="container ">
    <div class="row col-12">
            <h3>User List</h3>
            <table border="1" class="table table-bordered table-striped col-12" id="table">
                <thead>
                <tr>
                    <th scope="col">Tên sách</th>
                    <th scope="col">Hình ảnh</th>
                    <th scope="col">Ghi chú</th>
                    <th class="col-1">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${favors}" var="favor">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath}/view-book?id=${favor.getBook_id()}">
                                    ${favor.getBook_title()}
                            </a>
                        </td>
                        <td>
                            <img src="${pageContext.request.contextPath}${favor.getCover_image()}" style="width: 200px;" alt="">
                        </td>
                        <td>${favor.getNote()}</td>
                        <td class="col-1">
                            <a href="${pageContext.request.contextPath}/user/delete-favor?id=${favor.getId()}">
                                <button class="btn btn-danger">Xóa</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    $("#table").DataTable()
    $("#table_wrapper").css({"width": "100%"})
</script>
