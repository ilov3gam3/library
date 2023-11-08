<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/master/head.jsp" %>
<%@ page pageEncoding="utf-8" %>
<%
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  Date currentDate = new Date();
  ArrayList<MyObject> rentals = (ArrayList<MyObject>) request.getAttribute("rentals");
  Date row_from_date;
  Date row_to_date;
%>
<div class="container ">
  <div class="row col-12">
    <h3>Danh sách sách thuê</h3>
    <div id="more_info_block" class="tabs tab-center">
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a data-toggle="tab" href="#renting" class="nav-link active">
            Sách đang thuê
          </a>
        </li>
        <li class="nav-item">
          <a data-toggle="tab" href="#about_to_recieve" class="nav-link">
            Sắp tới hạn lấy sách
          </a>
        </li>
        <li class="nav-item">
          <a data-toggle="tab" href="#rent-history" class="nav-link">
            Sách đã thuê
          </a>
        </li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="renting" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th scope="col">Tên sách</th>
              <th scope="col">Hình ảnh</th>
              <th scope="col">Từ ngày</th>
              <th scope="col">Đến ngày</th>
              <th scope="col">Giá</th>
              <th scope="col">Đã nhận</th>
              <th scope="col">Đã trả</th>
              <th scope="col">Mượn lúc</th>
              <th class="col-1">Thao tác</th>
            </tr>
            </thead>
            <tbody>
              <% for (int i = 0; i < rentals.size(); i++) { %>
              <% row_from_date = dateFormat.parse(rentals.get(i).from_date); %>
              <% row_to_date = dateFormat.parse(rentals.get(i).to_date); %>
              <%if (row_to_date.after(currentDate) && row_from_date.before(currentDate) && rentals.get(i).status.equals("0")) {%>
                <tr>
                <td>
                  <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).book_id%>">
                    <%=rentals.get(i).book_title%>
                  </a>
                </td>
                <td>
                  <img src="${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>" style="width: 200px;" alt="">
                </td>
                <td><%=rentals.get(i).from_date%></td>
                <td><%=rentals.get(i).to_date%></td>
                <td><%=rentals.get(i).price%></td>
                <td class="text-center"><%=rentals.get(i).received_book.equals("1") ? "rồi" : "Chưa"%></td>
                <td class="text-center"><%=rentals.get(i).returned_book.equals("1") ? "rồi" : "Chưa"%></td>
                <td><%=rentals.get(i).created_at%></td>
                <td>
                  <a target="_blank" href="${pageContext.request.contextPath}<%=rentals.get(i).getSoft_file()%>">
                    <button type="submit" class="btn btn-primary">Đọc sách</button>
                  </a>
                    <button onclick="showReviewForm('<%=rentals.get(i).book_id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>')" class="btn btn-warning mt-1">Viết Đánh giá</button>
                </td>
              </tr>
              <%}%>
            <%  } %>
            </tbody>
          </table>
        </div>
        <div class="tab-pane" id="about_to_recieve" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th scope="col">Tên sách</th>
              <th scope="col">Hình ảnh</th>
              <th scope="col">Từ ngày</th>
              <th scope="col">Đến ngày</th>
              <th scope="col">Giá</th>
              <th scope="col">Đã nhận</th>
              <th scope="col">Đã trả</th>
              <th scope="col">Mượn lúc</th>
              <th class="col-1">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < rentals.size(); i++) { %>
            <% row_from_date = dateFormat.parse(rentals.get(i).from_date); %>
            <%if (row_from_date.after(currentDate) && rentals.get(i).status.equals("0")) {%>
            <tr>
              <td>
                <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).book_id%>">
                  <%=rentals.get(i).book_title%>
                </a>
              </td>
              <td>
                <img src="${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>" style="width: 200px;" alt="">
              </td>
              <td><%=rentals.get(i).from_date%></td>
              <td><%=rentals.get(i).to_date%></td>
              <td><%=rentals.get(i).price%></td>
              <td class="text-center"><%=rentals.get(i).received_book.equals("1") ? "rồi" : "Chưa"%></td>
              <td class="text-center"><%=rentals.get(i).returned_book.equals("1") ? "rồi" : "Chưa"%></td>
              <td><%=rentals.get(i).created_at%></td>
              <td>
                <button onclick="showReviewForm('<%=rentals.get(i).book_id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>')" class="btn btn-warning mt-1">Viết Đánh giá</button>
              </td>
            </tr>
            <%}%>
            <%  } %>
            </tbody>
          </table>
        </div>
        <div class="tab-pane" id="rent-history" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th scope="col">Tên sách 132</th>
              <th scope="col">Hình ảnh</th>
              <th scope="col">Từ ngày</th>
              <th scope="col">Đến ngày</th>
              <th scope="col">Giá</th>
              <th scope="col">Đã nhận</th>
              <th scope="col">Đã trả</th>
              <th scope="col">Mượn lúc</th>
              <th class="col-1">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < rentals.size(); i++) { %>
            <% row_to_date = dateFormat.parse(rentals.get(i).to_date); %>
            <%if (row_to_date.before(currentDate) || !rentals.get(i).status.equals("0")) {%>
            <tr>
              <td>
                <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).book_id%>">
                  <%=rentals.get(i).book_title%>
                </a>
              </td>
              <td>
                <img src="${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>" style="width: 200px;" alt="">
              </td>
              <td><%=rentals.get(i).from_date%></td>
              <td><%=rentals.get(i).to_date%></td>
              <td><%=rentals.get(i).price%></td>
              <td class="text-center"><%=rentals.get(i).received_book.equals("1") ? "rồi" : "Chưa"%></td>
              <td class="text-center"><%=rentals.get(i).returned_book.equals("1") ? "rồi" : "Chưa"%></td>
              <td><%=rentals.get(i).created_at%></td>
              <td>
                <button class="btn btn-warning mt-1" onclick="showReviewForm('<%=rentals.get(i).book_id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>',)">Viết Đánh giá</button>
              </td>
            </tr>
            <%}%>
            <%  } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Đánh giá sách</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="${pageContext.request.contextPath}/user/review-book" method="post" onsubmit="check_review_form(event)">
          <div class="container">
            <input type="hidden" id="book_id" name="book_id">
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="book_title">
                Tên sách</label>
              <div class="col-md-12">
                <input class="form-control" id="book_title" type="text" readonly="">
              </div>
            </div>
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required">
                Hình ảnh
              </label>
              <div class="col-md-12 d-flex justify-content-center">
                <div>
                  <img id="cover_image" src="" alt="" style="width: 400px">
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="review">Viết đánh giá</label>
              <textarea required class="form-control" name="review" id="review" style="width: 100%;" rows="12"></textarea>
            </div>
            <input type="hidden" id="rating" name="star_rate" value="">
            <div class="form-group d-flex justify-content-center">
                <div class="row">
                  <button type="button" onclick="changeRating(1)" id="1" style="border-top-width: 0;border-left-width: 0;border-right-width: 0;padding-right: 0;padding-left: 0;min-width: 70px;" class="btn btn-primary m-1">1&nbsp;<i class="fa fa-star-o" aria-hidden="true"></i></button>
                  <button type="button" onclick="changeRating(2)" id="2" style="border-top-width: 0;border-left-width: 0;border-right-width: 0;padding-right: 0;padding-left: 0;min-width: 70px;" class="btn btn-primary m-1">2&nbsp;<i class="fa fa-star-o" aria-hidden="true"></i></button>
                  <button type="button" onclick="changeRating(3)" id="3" style="border-top-width: 0;border-left-width: 0;border-right-width: 0;padding-right: 0;padding-left: 0;min-width: 70px;" class="btn btn-primary m-1">3&nbsp;<i class="fa fa-star-o" aria-hidden="true"></i></button>
                  <button type="button" onclick="changeRating(4)" id="4" style="border-top-width: 0;border-left-width: 0;border-right-width: 0;padding-right: 0;padding-left: 0;min-width: 70px;" class="btn btn-primary m-1">4&nbsp;<i class="fa fa-star-o" aria-hidden="true"></i></button>
                  <button type="button" onclick="changeRating(5)" id="5" style="border-top-width: 0;border-left-width: 0;border-right-width: 0;padding-right: 0;padding-left: 0;min-width: 70px;" class="btn btn-primary m-1">5&nbsp;<i class="fa fa-star-o" aria-hidden="true"></i></button>
                </div>
            </div>
            <div class="container">
              <div class="form-group row align-items-center ">
                <button class="btn btn-outline-primary-2 btn-block" type="submit">
                  Gửi đánh giá
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
  function showReviewForm(book_id, title, img) {
    console.log("bookid", book_id)
    $("#book_id").val(book_id)
    $("#book_title").val(title)
    $("#cover_image").attr("src", img)
    $("#reviewModal").modal('show');
  }
  function check_review_form(e) {
    if ($("#rating").val() === ''){
      toastr.warning("Vui lòng đánh giá sao")
      e.preventDefault()
    }
  }
  function resetAllRating() {
    for (let i = 1; i < 6; i++) {
      $("#" + i).attr("class", "btn btn-primary m-1")
      $("#" + i).html(i + '&nbsp;<i class="fa fa-star-o" aria-hidden="true">');
    }
  }
  function changeRating(x) {
    $("#rating").val(x)
    resetAllRating()
    for (let i = 1; i < x+1; i++) {
      $("#" + i).attr("class", "btn btn-warning m-1")
      $("#" + i).html(i + '&nbsp;<i class="fa fa-star" aria-hidden="true">');
    }
  }
</script>
