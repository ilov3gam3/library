<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-3">
    <div class="row">
        <div id="content-wrapper" class="col-12 col-lg-12">
            <section id="main" itemscope="">
                <div class="row product-detail default">
                    <div class="pb-left-column col-lg-6 col-md-6 col-sm-6 col-xs-12 mb-2 mb-md-0">
                        <div class="pd-left-content">
                            <section class="page-content" id="content">
                                <div class="images-container thumbs-left vertical-thumbs">
                                    <div class="col-md-12 d-flex justify-content-center">
                                        <img class=""
                                             src="${pageContext.request.contextPath}${book.getCover_image()}"
                                             alt="" title=""
                                             style="width: 100%; max-height:600px;border: 2px solid #000;object-fit: contain">
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
                            <div itemprop="price" class="price new">Giá thuê: ${book.getPrice()}đ/ngày</div>
                            <br>
                            <div itemprop="price" class="price new text-danger">Miễn phí với tài khoản vip</div>
                        </div>
                        <div class="product-information">

                            <div class="product-desc"><p>Mô tả: ${book.getDescription()}</p></div>
                            <div class="product-desc"><p>Đang mượn: ${book.getRenting()}/${book.getQuantity()} cuốn</p>
                            </div>
                            <div class="product-desc"><p>Hoàn thành năm: ${book.getYear()}</p></div>

                            <div class="product-actions">
                                <% if (user != null) {%>
                                    <% if (user.vip_sub_id != null) {%>
                                        <% if (Integer.parseInt(((MyObject) request.getAttribute("book")).renting) >= Integer.parseInt(((MyObject) request.getAttribute("book")).quantity) ) {%>
                                            <button class="btn btn-primary mr-2" onclick="toastr.warning('Không còn đủ sách trong kho.')">
                                                Thuê
                                            </button>
                                        <%} else {%>
                                            <button class="btn btn-primary mr-2" data-toggle="modal" data-target="#rentModalVip">
                                                Thuê
                                            </button>
                                         <%}%>
                                        <button class="btn btn-outline-dark ml-2" ${book.getFavor() == null ? "data-toggle='modal' data-target='#addFavoriteModal'" : "onclick='already_favor()'"} >
                                            Thêm vào yêu thích
                                        </button>
                                    <% } else {%>
                                        <% if (Integer.parseInt(((MyObject) request.getAttribute("book")).renting) >= Integer.parseInt(((MyObject) request.getAttribute("book")).quantity) ) {%>
                                            <button class="btn btn-primary mr-2" onclick="toastr.warning('Không còn đủ sách trong kho.')">
                                                Thuê
                                            </button>
                                        <%} else {%>
                                            <button class="btn btn-primary mr-2" data-toggle="modal" data-target="#rentModal">
                                                Thuê
                                            </button>
                                        <%}%>
                                        <button class="btn btn-outline-dark ml-2" ${book.getFavor() == null ? "data-toggle='modal' data-target='#addFavoriteModal'" : "onclick='already_favor()'"} >
                                            Thêm vào yêu thích
                                        </button>
                                    <% }%>
                                    <%} else {%>
                                        <button class="btn btn-primary mr-2" onclick="toastr_login()">Thuê</button>
                                        <button class="btn btn-outline-dark ml-2" onclick="toastr_login()">Thêm vào yêu thích
                                        </button>
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
                                Đánh giá ${reviews_number}
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
                                <%--<h3>Reviews (0)</h3>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12" id="product-comments-list"
                                         data-list-comments-url="https://prestashop17.joommasters.com/molla/index.php?id_product=129&amp;fc=module&amp;module=productcomments&amp;controller=ListComments&amp;id_lang=1"
                                         data-update-comment-usefulness-url="https://prestashop17.joommasters.com/molla/index.php?fc=module&amp;module=productcomments&amp;controller=UpdateCommentUsefulness&amp;id_lang=1"
                                         data-report-comment-url="https://prestashop17.joommasters.com/molla/index.php?fc=module&amp;module=productcomments&amp;controller=ReportComment&amp;id_lang=1"
                                         data-comment-item-prototype="
">
                                        <div id="empty-product-comment" class="product-comment-list-item" style="">
                                            No customer reviews for the moment.
                                        </div>
                                    </div>
                                </div>--%>
                                <c:forEach items="${reviews}" var="review">
                                    <div class="d-flex flex-column comment-section">
                                        <div class="bg-white p-2">
                                            <div class="d-flex flex-row user-info"><img class="rounded-circle"
                                                                                        src="${pageContext.request.contextPath}${review.getAvatar()}"
                                                                                        width="40px" height="40px" style="object-fit: cover">
                                                <div class="d-flex flex-column justify-content-start ml-2"><span
                                                        class="d-block font-weight-bold name">${review.getName()} <span style="color: black">(${review.getRating()}/5)</span></span><span
                                                        class="date text-black-50">${review.getCreated_at()}</span>
                                                </div>
                                            </div>
                                            <div class="mt-2">
                                                <p class="comment-text">${review.getContent()}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <style>
                                        .date {
                                            font-size: 11px
                                        }
                                        .comment-text {
                                            font-size: 12px
                                        }

                                        .fs-12 {
                                            font-size: 12px
                                        }

                                        .shadow-none {
                                            box-shadow: none
                                        }

                                        .name {
                                            color: #007bff
                                        }

                                        .cursor:hover {
                                            color: blue
                                        }

                                        .cursor {
                                            cursor: pointer
                                        }

                                        .textarea {
                                            resize: none
                                        }
                                    </style>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
<div class="modal fade" id="addFavoriteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
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
                                <input class="form-control" id="name_update" name="name_update" type="text" required=""
                                       value="${book.getTitle()}">
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required">
                                Hình ảnh
                            </label>
                            <div class="col-md-12 d-flex justify-content-center">
                                <div>
                                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt=""
                                         style="max-height: 400px">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="note">
                                Ghi chú
                            </label>
                            <div class="col-md-12">
                                <textarea class="form-control" name="note" id="note" style="width: 100%" rows="8"
                                          required></textarea>
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
<div class="modal fade" id="rentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
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
                                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt=""
                                         style="max-height: 400px">
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
<div class="modal fade" id="rentModalVip" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thuê sách dành cho tài khoản vip</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/vip/rent-book" method="post">
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
                                    <img src="${pageContext.request.contextPath}${book.getCover_image()}" alt=""
                                         style="max-height: 400px">
                                </div>
                            </div>
                        </div>
                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="from_date_vip">
                                Từ ngày </label>
                            <div class="col-md-12">
                                <input required class="form-control" type="date" name="from_date" id="from_date_vip">
                            </div>
                        </div>

                        <div class="form-group row align-items-center ">
                            <label class="col-md-12 form-control-label required" for="to_date_vip">
                                Đến ngày </label>
                            <div class="col-md-12">
                                <input required class="form-control" type="date" name="to_date" id="to_date_vip">
                            </div>
                        </div>
                        <div class="container">
                            <div class="form-group row align-items-center ">
                                <button id="rent_button_vip" class="btn btn-outline-primary-2 btn-block" type="submit">
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
    var is_vip = '<%=user.vip_sub_id == null ? "" : user.vip_sub_id%>'
    var account_balance = '<%=user.getAccount_balance()%>'
    var book_price = '${book.getPrice()}'
    var from_date = ''
    var from_date_vip = ''
    var to_date = ''
    var to_date_vip = ''
    var price_to_pay = 0
    let days_rent = 0;
    if (is_vip !== '') {
        console.log("vip")
    } else {
        console.log("not vip")
    }
    $("#from_date").on('input', function () {
        from_date = $("#from_date").val();
        var date = new Date(from_date);
        var currentDate = new Date();
        currentDate.setHours(0,0,0,0)
        if (date < currentDate) {
            toastr.warning("Ngày bắt đầu mượn phải sau ngày hiện tại.")
            $("#from_date").val(""); // Clear the input
            from_date = ''
            $("#rent_button").attr("disabled", true)
        } else {
            if (to_date !== '') {
                calDays()
            }
        }
    })
    $("#to_date").on('input', function () {
        to_date = $("#to_date").val();
        if (from_date !== '') {
            var tempDate1 = new Date(from_date)
            var tempDate2 = new Date(to_date)
            if (tempDate2 < tempDate1) {
                toastr.warning("Ngày bắt kết thúc phải sau ngày bắt đầu mượn.")
                $("#rent_button").attr("disabled", true)
                $("#calculated_price").attr("hidden", true)
            } else {
                calDays()
            }
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
        if (price_to_pay > account_balance) {
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

    $("#from_date_vip").on('input', function () {
        from_date_vip = $("#from_date_vip").val();
        var date = new Date(from_date_vip);
        var currentDate = new Date();
        currentDate.setHours(0,0,0,0)
        if (date < currentDate) {
            toastr.warning("Ngày bắt đầu mượn phải sau ngày hiện tại.")
            $("#from_date_vip").val(""); // Clear the input
            from_date = ''
            $("#rent_button_vip").attr("disabled", true)
        }
    })
    $("#to_date_vip").on('input', function () {
        to_date_vip = $("#to_date_vip").val();
        if (from_date_vip !== '') {
            var tempDate1 = new Date(from_date_vip)
            var tempDate2 = new Date(to_date_vip)
            if (tempDate2 < tempDate1) {
                toastr.warning("Ngày bắt kết thúc phải sau ngày bắt đầu mượn.")
                $("#rent_button_vip").attr("disabled", true)
            } else {
                $("#rent_button_vip").attr("disabled", false)

            }
        }
    })
</script>
<%} else {%>
<script>
    function toastr_login() {
        toastr.warning("Vui lòng đăng nhập để sử dụng tính năng này.", "Cảnh báo")
    }
</script>
<%}%>
