<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-3">
    <div class="row">
        <div id="content-wrapper" class="col-12 col-lg-12">
            <section id="main" itemscope="" itemtype="https://schema.org/Product">
                <meta itemprop="url"
                      content="https://prestashop17.joommasters.com/molla/index.php?id_product=129&amp;rewrite=becoming&amp;controller=product&amp;id_lang=1">
                <div class="row product-detail default">
                    <div class="pb-left-column col-lg-6 col-md-6 col-sm-6 col-xs-12 mb-2 mb-md-0">
                        <div class="pd-left-content">
                            <section class="page-content" id="content">
                                <div class="images-container thumbs-left vertical-thumbs">
                                    <%--<div class="js-qv-mask mask">
                                        <div id="gal1"
                                             class="product-images js-qv-product-images slick-thumbs slick-initialized slick-slider slick-vertical">
                                            <div class="slick-list draggable" style="height: 351px;">
                                                <div class="slick-track"
                                                     style="opacity: 1; height: 117px; transform: translate3d(0px, 0px, 0px);">
                                                    <div class="thumb-container selected slick-slide slick-current slick-active"
                                                         data-image="${pageContext.request.contextPath}${book.getCover_image()}"
                                                         data-zoom-image="${pageContext.request.contextPath}${book.getCover_image()}"
                                                         data-slick-index="0" aria-hidden="false" style="width: 107px;"
                                                         tabindex="0">
                                                        <img class="thumb js-thumb  selected "
                                                             data-image-medium-src="${pageContext.request.contextPath}${book.getCover_image()}"
                                                             data-image-large-src="${pageContext.request.contextPath}${book.getCover_image()}"
                                                             src="${pageContext.request.contextPath}${book.getCover_image()}"
                                                             alt="" title="" itemprop="image">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="col-md-12 d-flex justify-content-center">
                                        <img class=""
                                             src="${pageContext.request.contextPath}${book.getCover_image()}"
                                             alt="" title="" style="width: 100%; max-height:600px;border: 2px solid #000;object-fit: contain">
<%--                                        <div class="zoom-icon hidden-xs" data-toggle="modal"
                                             data-target="#product-modal">
                                            <i class="icon-arrows"></i>
                                        </div>--%>
                                    </div>

                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="pb-right-column col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <h1 itemprop="name" class="product-name">${book.getTitle()}</h1>
                        <div class="rating">
                        </div>
                        <div class="product-prices content_price">
                            <div itemprop="price" class="price new">Giá thuê: ${book.getPrice()}đ/ngày</div><br>
                            <div itemprop="price" class="price new text-danger">Miễn phí với tài khoản vip</div>
                        </div>
                        <div class="product-information">

                            <div class="product-desc"><p>Mô tả: ${book.getDescription()}</p></div>
                            <div class="product-desc"><p>Đang mượn: ${book.getRenting()}/${book.getQuantity()} cuốn</p></div>

                            <div class="product-actions">
                                <% if (user != null) {%>
                                    <button class="btn btn-primary mr-2" data-toggle="modal" data-target="#rentModal">Thuê</button>
                                    <button class="btn btn-outline-dark ml-2" ${book.getFavor() == null ? "data-toggle='modal' data-target='#addFavoriteModal'" : "onclick='already_favor()'"} >Thêm vào yêu thích</button>
                                <%} else {%>
                                    <button class="btn btn-primary mr-2" onclick="toastr_login()">Thuê</button>
                                    <button class="btn btn-outline-dark ml-2" onclick="toastr_login()">Thêm vào yêu thích</button>
                                <%}%>
                            </div>

                        </div>
                    </div>
                </div>
                <div id="more_info_block" class="tabs tab-center">

                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a data-toggle="tab" href="#description" class="nav-link active">
                                Mô tả
                            </a>
                        </li>
                        <li class="nav-item">
                            <a data-toggle="tab" href="#review-nav" class="nav-link">
                                Đánh giá
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="description" role="tabpanel" aria-labelledby="description-tab">

                            <div class="product-description">
                                <div class="product-desc-content">
                                    <p>${book.getDescription()}</p>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane" id="review-nav" role="tabpanel" aria-labelledby="review-tab">
                            <div id="product-comments">
                                <h3>Reviews (0)</h3>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12" id="product-comments-list"
                                         data-list-comments-url="https://prestashop17.joommasters.com/molla/index.php?id_product=129&amp;fc=module&amp;module=productcomments&amp;controller=ListComments&amp;id_lang=1"
                                         data-update-comment-usefulness-url="https://prestashop17.joommasters.com/molla/index.php?fc=module&amp;module=productcomments&amp;controller=UpdateCommentUsefulness&amp;id_lang=1"
                                         data-report-comment-url="https://prestashop17.joommasters.com/molla/index.php?fc=module&amp;module=productcomments&amp;controller=ReportComment&amp;id_lang=1"
                                         data-comment-item-prototype="<div class=&quot;product-comment-list-item row&quot; data-product-comment-id=&quot;@COMMENT_ID@&quot; data-product-id=&quot;@PRODUCT_ID@&quot;>
  <div class=&quot;col-md-3 col-sm-3 comment-infos&quot;>
    <div class=&quot;grade-stars&quot;></div>
    <div class=&quot;comment-date&quot;>
      @COMMENT_DATE@
    </div>
    <div class=&quot;comment-author&quot;>
      By @CUSTOMER_NAME@
    </div>
  </div>

  <div class=&quot;col-md-9 col-sm-9 comment-content&quot;>
    <h4>@COMMENT_TITLE@</h4>
    <p>@COMMENT_COMMENT@</p>
    <div class=&quot;comment-buttons btn-group&quot;>
              <a class=&quot;useful-review&quot;>
          <i class=&quot;icon-thumbs-up&quot;></i>
          <span class=&quot;useful-review-value&quot;>@COMMENT_USEFUL_ADVICES@</span>
        </a>
        <a class=&quot;not-useful-review&quot;>
          <i class=&quot;icon-thumbs-down&quot;></i>
          <span class=&quot;not-useful-review-value&quot;>@COMMENT_NOT_USEFUL_ADVICES@</span>
        </a>
            <a class=&quot;report-abuse&quot; title=&quot;Report abuse&quot;>
        <i class=&quot;fa fa-flag&quot;></i>
      </a>
    </div>
  </div>
</div>
">
                                        <div id="empty-product-comment" class="product-comment-list-item" style="">
                                            No customer reviews for the moment.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="report-comment-confirmation" class="modal fade product-comment-modal" role="dialog"
                                 aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>
                                                Report comment
                                            </h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12"
                                                     id="report-comment-confirmation-message">
                                                    Are you sure that you want to report this comment?
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12 post-comment-buttons">
                                                    <button type="button"
                                                            class="btn btn-comment-inverse btn-comment-huge refuse-button"
                                                            data-dismiss="modal" aria-label="No">
                                                        No
                                                    </button>
                                                    <button type="button"
                                                            class="btn btn-comment btn-comment-huge confirm-button"
                                                            data-dismiss="modal" aria-label="Yes">
                                                        Yes
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="report-comment-posted" class="modal fade product-comment-modal" role="dialog"
                                 aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>
                                                Report sent
                                            </h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12" id="report-comment-posted-message">
                                                    Your report has been submitted and will be considered by a
                                                    moderator.
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12 post-comment-buttons">
                                                    <button type="button" class="btn btn-comment btn-comment-huge"
                                                            data-dismiss="modal" aria-label="OK">
                                                        OK
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="report-comment-post-error" class="modal fade product-comment-modal" role="dialog"
                                 aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>
                                                Your report cannot be sent
                                            </h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12"
                                                     id="report-comment-post-error-message">

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12 post-comment-buttons">
                                                    <button type="button" class="btn btn-comment btn-comment-huge"
                                                            data-dismiss="modal" aria-label="OK">
                                                        OK
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="post-product-comment-modal" class="modal fade product-comment-modal" role="dialog"
                                 aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>Write your review</h2>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="post-product-comment-form"
                                                  action="https://prestashop17.joommasters.com/molla/index.php?id_product=129&amp;fc=module&amp;module=productcomments&amp;controller=PostComment&amp;id_lang=1"
                                                  method="POST">
                                                <div class="row">
                                                    <div class="col-4">

                                                        <ul class="product-flags">
                                                            <li class="product-flag on-sale">On sale</li>
                                                            <li class="product-flag discount">-5%</li>
                                                        </ul>


                                                        <div class="product-cover">
                                                            <img class="js-qv-product-cover"
                                                                 src="https://prestashop17.joommasters.com/molla/img/p/5/8/1/581-medium_default.jpg"
                                                                 alt="" title="" style="width:100%;" itemprop="image">
                                                        </div>

                                                    </div>
                                                    <div class="col-8">
                                                        <h3>Becoming</h3>

                                                        <div itemprop="description"><p>Sed egestas, ante et vulputate
                                                            volutpat, eros pede semper est, vitae luctus metus libero eu
                                                            augue. Morbi purus libero, faucibus adipiscing. Sed...</p>
                                                        </div>

                                                    </div>
                                                    <div class="col-12">
                                                        <ul id="criterions_list">
                                                            <li>
                                                                <div class="criterion-rating">
                                                                    <label>Quality:</label>
                                                                    <div class="grade-stars" data-grade="3"
                                                                         data-input="criterion[1]">
                                                                        <div class="star-content star-empty clearfix"></div>
                                                                        <div class="star-content star-full clearfix">
                                                                            <div class="star star-on"></div>
                                                                            <div class="star star-on"></div>
                                                                            <div class="star star-on"></div>
                                                                            <div class="star"></div>
                                                                            <div class="star"></div>
                                                                        </div>
                                                                        <input type="number" name="criterion[1]"
                                                                               id="criterion[1]" style="display: none;">
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-8 col-sm-8">
                                                        <label class="form-label" for="comment_title">Title<sup
                                                                class="required">*</sup></label>
                                                    </div>
                                                    <div class="col-md-4 col-sm-4">
                                                        <label class="form-label" for="customer_name">Your name<sup
                                                                class="required">*</sup></label>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-8 col-sm-8">
                                                        <input name="comment_title" type="text" value="">
                                                    </div>
                                                    <div class="col-md-4 col-sm-4">
                                                        <input name="customer_name" type="text" value="">
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12">
                                                        <label class="form-label" for="comment_content">Review<sup
                                                                class="required">*</sup></label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12">
                                                        <textarea name="comment_content"></textarea>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6 col-sm-6">
                                                        <p class="required"><sup>*</sup> Required fields</p>
                                                    </div>
                                                    <div class="col-md-6 col-sm-6 post-comment-buttons">
                                                        <button type="button" class="btn btn-outline-gray"
                                                                data-dismiss="modal" aria-label="Cancel">
                                                            Cancel
                                                        </button>
                                                        <button type="submit" class="btn btn-outline-gray btn-comment">
                                                            Send
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="product-comment-posted-modal" class="modal fade product-comment-modal"
                                 role="dialog" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>
                                                Review sent
                                            </h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12"
                                                     id="product-comment-posted-modal-message">
                                                    Your comment has been submitted and will be available once approved
                                                    by a moderator.
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12 post-comment-buttons">
                                                    <button type="button" class="btn btn-comment btn-comment-huge"
                                                            data-dismiss="modal" aria-label="OK">
                                                        OK
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="product-comment-post-error" class="modal fade product-comment-modal" role="dialog"
                                 aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2>
                                                Your review cannot be sent
                                            </h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12"
                                                     id="product-comment-post-error-message">

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12  col-sm-12 post-comment-buttons">
                                                    <button type="button" class="btn btn-comment btn-comment-huge"
                                                            data-dismiss="modal" aria-label="OK">
                                                        OK
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
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
                        <input type="hidden" name="book_id" id="id" value="${book.getId()}">
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="name_update">
                                Tên sách </label>
                            <div class="col-md-12">
                                <input class="form-control" id="name_update" name="name_update" type="text" required="" value="${book.getTitle()}">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required">
                                Hình ảnh
                            </label>
                            <div class="col-md-12 d-flex justify-content-center">
                                <div>
                                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt="" style="max-height: 400px">
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
                        <input type="hidden" name="book_id" value="${book.getId()}">
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="name_update">
                                Tên sách bạn sẽ thuê </label>
                            <div class="col-md-12">
                                <input class="form-control" type="text" readonly="" value="${book.getTitle()}">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required">
                                Hình ảnh
                            </label>
                            <div class="col-md-12 d-flex justify-content-center">
                                <div>
                                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt="" style="max-height: 400px">
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
    var account_balance = '<%=user.getAccount_balance()%>'
    var book_price = '${book.getPrice()}'
    var from_date = ''
    var to_date = ''
    var price_to_pay = 0
    let days_rent = 0;
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
    function already_favor() {
        toastr.info("Sách này đã ở trong danh sách yêu thích của bạn rồi.", "Thông báo.")
    }
</script>
<%} else {%>
<script>
    function toastr_login() {
        toastr.warning("Vui lòng đăng nhập để sử dụng tính năng này.", "Cảnh báo")
    }
</script>
<%}%>
