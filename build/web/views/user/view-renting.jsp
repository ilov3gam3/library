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
                  <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).id%>">
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
                  <form action="${pageContext.request.contextPath}/user/view-pdf" method="post">
                    <input type="hidden" name="rent_id" value="<%=rentals.get(i).id%>">
                    <button type="submit" class="btn btn-primary">Đọc sách</button>
                  </form>
                    <button onclick="showReviewForm('<%=rentals.get(i).id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>')" class="btn btn-warning mt-1">Viết Đánh giá</button>
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
                <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).id%>">
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
                <button onclick="showReviewForm('<%=rentals.get(i).id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>')" class="btn btn-warning mt-1">Viết Đánh giá</button>
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
                <a href="${pageContext.request.contextPath}/view-book?id=<%=rentals.get(i).id%>">
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
                <button class="btn btn-warning mt-1" onclick="showReviewForm('<%=rentals.get(i).id%>', '<%=rentals.get(i).book_title%>', '${pageContext.request.contextPath}<%=rentals.get(i).cover_image%>')">Viết Đánh giá</button>
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
        <form action="${pageContext.request.contextPath}/user/review-book" method="post" onsubmit="check_review_form()">
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
              <textarea class="form-control" name="review" id="review" style="width: 100%;" rows="12"></textarea>
            </div>
            <div class="form-group">
                <input type="hidden" name="star_rate" id="star_rate">
                <input class="star star-5" id="star-5" type="radio" name="star" onclick="$('#star_rate').val((6-1))"/>
                <label class="star star-5" for="star-5"></label>
                <input class="star star-4" id="star-4" type="radio" name="star" onclick="$('#star_rate').val((6-2))"/>
                <label class="star star-4" for="star-4"></label>
                <input class="star star-3" id="star-3" type="radio" name="star" onclick="$('#star_rate').val((6-3))"/>
                <label class="star star-3" for="star-3"></label>
                <input class="star star-2" id="star-2" type="radio" name="star" onclick="$('#star_rate').val((6-4))"/>
                <label class="star star-2" for="star-2"></label>
                <input class="star star-1" id="star-1" type="radio" name="star" onclick="$('#star_rate').val((6-5))"/>
                <label class="star star-1" for="star-1"></label>
              <style>
                @import url(https://fonts.googleapis.com/css?family=Roboto:500,100,300,700,400);
                *{
                  margin: 0;
                  padding: 0;
                  font-family: roboto;
                }
                .cont{
                  width: 93%;
                  max-width: 350px;
                  text-align: center;
                  margin: 4% auto;
                  padding: 30px 0;
                  color: #EEE;
                  border-radius: 5px;
                  border: thin solid #444;
                  overflow: hidden;
                }

                hr{
                  margin: 20px;
                  border: none;
                  border-bottom: thin solid rgba(255,255,255,.1);
                }

                div.title{
                  font-size: 2em;
                }

                h1 span{
                  font-weight: 300;
                  color: #Fd4;
                }

                div.stars{
                  width: 270px;
                  display: inline-block;
                }

                input.star{
                  display: none;
                }

                label.star {
                  float: right;
                  padding: 10px;
                  font-size: 36px;
                  color: #444;
                  transition: all .2s;
                }

                input.star:checked ~ label.star:before {
                  content:'\f005';
                  color: #FD4;
                  transition: all .25s;
                }


                input.star-5:checked ~ label.star:before {
                  color:#FE7;
                  text-shadow: 0 0 20px #952;
                }

                input.star-1:checked ~ label.star:before {
                  color: #F62;
                }

                label.star:hover{
                  transform: rotate(-15deg) scale(1.3);
                }

                label.star:before{
                  content:'\f006';
                  font-family: FontAwesome;
                }

                .rev-box{
                  overflow: hidden;
                  height: 0;
                  width: 100%;
                  transition: all .25s;
                }

                textarea.review{
                  border: none;
                  width: 100%;
                  max-width: 100%;
                  height: 100px;
                  padding: 10px;
                  box-sizing: border-box;
                  color: #EEE;
                }

                label.review{
                  display: block;
                  transition:opacity .25s;
                }
                input.star:checked ~ .rev-box{
                  height: 125px;
                  overflow: visible;
                }
              </style>
            </div>
            <div class="container">
              <div class="form-group row align-items-center ">
                <button class="btn btn-outline-primary-2 btn-block" id="rent_button" type="submit">
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
    $("#book_id").val(book_id)
    $("#book_title").val(title)
    $("#cover_image").attr("src", img)
    $("#reviewModal").modal('show');
  }
  function check_review_form() {
    if ($("#star_rate").val() === ''){
      toastr.warning("Vui lòng đánh giá sao")
    }
  }
</script>
