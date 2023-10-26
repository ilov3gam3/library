<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-3">
  <div class="row">
    <div id="content-wrapper" class="col-12 col-lg-12">
      <section id="main" itemscope="" >
        <div class="row product-detail default">
          <div class="pb-left-column col-lg-6 col-md-6 col-sm-6 col-xs-12 mb-2 mb-md-0">
            <div class="pd-left-content">
              <section class="page-content" id="content">
                <div class="images-container thumbs-left vertical-thumbs">
                  <div class="col-md-12 d-flex justify-content-center">
                    <img class=""
                         src="${pageContext.request.contextPath}${author.getImage()}"
                         alt="" title="" style="width: 100%; max-height:600px;border: 2px solid #000;object-fit: contain">
                  </div>
                </div>
              </section>
            </div>
          </div>
          <div class="pb-right-column col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <h1 itemprop="name" class="product-name">${author.getName()}</h1>
            <div class="rating">
            </div>
            <div class="product-prices content_price">
              <div itemprop="price" class="price new">Sinh vào ${author.getDob()}</div>
            </div>
            <div class="product-prices content_price">
              <div itemprop="price" class="price new">Quốc tịch ${author.getNationality()}</div>
            </div>
            <div class="product-information">
              <div class="product-desc"><p>Mô tả: ${author.getBiography()}</p></div>
            </div>
          </div>
        </div>
        <div id="row-obh9n1ceb" class="gdz-row productbox-carousel">
          <div class="container">
            <div class="row">
              <div id="column-a38iynsuw" class="layout-column col-lg-9 col-md-12 col-12 ">
                <div id="addon-sh8v9eurj" class="addon-box">
                  <h5 class="pb-heading title text-lg-left">
                    Những sách của ${author.getName()}
                  </h5>
                </div>
              </div>
              <div id="column-mdcq0qomx" class="layout-column col-lg-12 col-md-12 col-12 ">
                <div id="addon-64c94fifg" class="addon-box">
                  <div class="pb-filter-products">
                    <% ArrayList<MyObject> books = (ArrayList<MyObject>) request.getAttribute("books");%>
                    <% for (int i = 0; i < books.size(); i+=6) { %>
                    <div class="filter-products owl-carousel customs" data-items="6" data-lg="6" data-md="6"
                         data-sm="3" data-xs="2" data-nav="false" data-dots="false" data-auto="false"
                         data-rewind="false" data-slidebypage="1" data-margin="20">
                      <% for (int j = 0; j < 6; j++) {%>
                      <%if (i+j == books.size()) break;%>
                      <div class="item">
                        <div class="product-miniature js-product-miniature thumbnail-container productbox-12 customs"
                             data-id-product="129" data-id-product-attribute="0" itemscope
                        >
                          <div class="product-preview">
                            <a href="${pageContext.request.contextPath}/view-book?id=<%=books.get(i+j).id%>"
                               class="product-image blur-image">
                              <img class="img-responsive product-img1"
                                   src="${pageContext.request.contextPath}<%=books.get(i+j).cover_image%>"
                              />
                            </a>
                          </div>
                          <div class="product-info">
                            <a class="category-name"
                               href="${pageContext.request.contextPath}/view-author?id=<%=books.get(i+j).author_id%>">
                              by
                              <span>${author.getName()}</span>
                            </a>

                            <h3 class="product-title" itemprop="name"><a class="product-link"
                                                                         href="${pageContext.request.contextPath}/view-book?id=<%=books.get(i+j).id%>"><%=books.get(i+j).title%></a>
                            </h3>


                            <div class="content_price">

						<span class="price new has-discount">
							<%=books.get(i+j).price%>đ/ngày
						</span>
                            </div>

                            <div class="product-short-desc">
                              <p>Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae
                                luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing.
                                Sed lectus.</p>
                            </div>
                            <div class="product-footer">
                              <% if (user != null) {%>
                              <div class="product-action">
                                <button data-toggle="modal" data-target="#rentModal" onclick="showRentModal('<%=books.get(i+j).getId()%>', '<%=books.get(i+j).getTitle()%>', '<%=books.get(i+j).getCover_image()%>', '<%=books.get(i+j).getPrice()%>')" class="btn btn-outline-warning btn-block mb-1"><i class="fa fa-money" aria-hidden="true"></i>Thuê ngay</button>
                              </div>
                              <div class="product-action">
                                <button onclick="showFavorModal('<%=books.get(i+j).getId()%>', '<%=books.get(i+j).getTitle()%>', '<%=books.get(i+j).getCover_image()%>')" data-toggle="modal" data-target="#addFavoriteModal" class="btn btn-outline-success btn-block"><i class="fa fa-heart-o" aria-hidden="true"></i>Yêu thích</button>
                              </div>
                              <%} else {%>
                              <div class="product-action">
                                <button onclick="toastr_login()" class="btn btn-outline-warning btn-block mb-1"><i class="fa fa-money" aria-hidden="true"></i>Thuê ngay</button>
                              </div>
                              <div class="product-action">
                                <button onclick="toastr_login()" class="btn btn-outline-success btn-block"><i class="fa fa-heart-o" aria-hidden="true"></i>Yêu thích</button>
                              </div>
                              <%}%>
                            </div>
                          </div>
                          <div class="product-actions">
                            <div class="content_price">
                              <span class="price new has-discount">$30.88</span>
                              <span class="old price">$32.50</span>
                            </div>
                            <a href="#" data-link-action="quickview" title="Quick View"
                               class="btn-icon quick-view">
                              <span>Quick View</span>
                            </a>
                            <a href="#" class="ajax-add-to-cart product-btn  cart-button btn-icon"
                               title="Add to cart" data-id-product="129" data-minimal-quantity="1"
                               data-token="588a5a1eb02312add78ccb857e952842">
                              <span>Add to cart</span>
                            </a>
                          </div>
                        </div>
                      </div>
                      <%} %>
                    </div>
                    <% } %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</div>
<div class="modal fade" id="addFavoriteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Thêm vào yêu thích</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="${pageContext.request.contextPath}/user/add-favorite" method="post">
          <div class="container">
            <input type="hidden" name="book_id" id="book_id_add_favor">
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="book_title">
                Tên sách </label>
              <div class="col-md-12">
                <input class="form-control" id="book_title_add_favor" name="name_update" type="text" disabled>
              </div>
            </div>
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required">
                Hình ảnh
              </label>
              <div class="col-md-12 d-flex justify-content-center">
                <div>
                  <img id="book_img_add_favor" src="" alt="" style="max-height: 400px">
                </div>
              </div>
            </div>

            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="note">
                Ghi chú
              </label>
              <div class="col-md-12">
                <textarea class="form-control" name="note" id="note" style="width: 100%" rows="8" required></textarea>
              </div>
            </div>
            <div class="container">
              <div class="form-group row align-items-center ">
                <button class="btn btn-outline-primary-2 btn-block" id="submit_update" type="submit">
                  Thêm vào yêu thích
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="rentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Thuê sách</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="${pageContext.request.contextPath}/user/rent-book" method="post">
          <div class="container">
            <input type="hidden" id="book_id_rent" name="book_id">
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="book_title">
                Tên sách bạn sẽ thuê </label>
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
                  <img id="cover_image" src="" alt="" style="max-height: 400px">
                </div>
              </div>
            </div>
            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="from_date">
                Từ ngày </label>
              <div class="col-md-12">
                <input class="form-control" type="date" name="from_date" id="from_date">
              </div>
            </div>

            <div class="form-group row align-items-center ">
              <label class="col-md-12 form-control-label required" for="to_date">
                Đến ngày </label>
              <div class="col-md-12">
                <input class="form-control" type="date" name="to_date" id="to_date">
              </div>
            </div>

            <div class="form-group row align-items-center ml-2">
              <p id="calculated_price" hidden=""></p>
            </div>

            <div class="container">
              <div class="form-group row align-items-center ">
                <button class="btn btn-outline-primary-2 btn-block" id="rent_button" type="submit">
                  Thuê ngay
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
<% if (user != null) {%>
<script>
  var contextPath = '${pageContext.request.contextPath}'
  var account_balance = '<%=user.getAccount_balance()%>'
  var book_price = 0
  var from_date = ''
  var to_date = ''
  var price_to_pay = 0
  function showFavorModal(id,title, cover_image) {
    $("#book_id_add_favor").val(id);
    $("#book_img_add_favor").attr("src",contextPath + cover_image)
    $("#book_title_add_favor").val(title)
  }
  function showRentModal(id, name, cover_image, price) {
    $("#book_id_rent").val(id)
    $("#book_title").val(name)
    $("#cover_image").attr("src", contextPath + cover_image)
    book_price = price
  }
  $("#from_date").on('input', function (){
    from_date = $("#from_date").val();
    if (to_date !== ''){
      calDays()
    }
  })
  $("#to_date").on('input', function (){
    to_date = $("#to_date").val();
    if (from_date !== ''){
      calDays()
    }
  })

  $("#rentModal").on('hidden.bs.modal', function (){
    $("#book_id").val('')
    $("#book_title").val('')
    $("#cover_image").attr("src", '')
    book_price = 0

  })
  function calDays() {
    const date1 = new Date(from_date);
    const date2 = new Date(to_date);
    const timeDifference = Math.abs(date2.getTime() - date1.getTime());
    days_rent = Math.ceil(timeDifference / (1000 * 3600 * 24)) + 1;
    price_to_pay = days_rent * book_price
    var text_to_show = "Số tiền bạn phải trả là : " + days_rent + " * " + book_price + " = " + price_to_pay
    $("#calculated_price").removeAttr("hidden")
    if ( price_to_pay > account_balance){
      text_to_show += " <span class='text-danger'>(Lưu ý không đủ số dư)</span>"
      $("#rent_button").attr("disabled", true)
    } else {
      $("#rent_button").attr("disabled", false)
    }
    $("#calculated_price").html(text_to_show)

  }
</script>
<%} else {%>
<script>
  function toastr_login() {
    toastr.warning("Vui lòng đăng nhập để sử dụng tính năng này.", "Cảnh báo")
  }
</script>
<%}%>
