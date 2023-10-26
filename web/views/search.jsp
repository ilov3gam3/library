<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-3">
    <div class="row">
        <div id="content-wrapper" class="col-12 col-lg-12">
            <section id="main" itemscope="">
                <div class="row">
                    <form action="${pageContext.request.contextPath}/search" method="get" class="col-12">
                        <div class="row">
                            <div class="col-md-3 form-group">
                                <label for="genre_id">Thể loại</label>
                                <select class="form-control" name="genre_id" id="genre_id">
                                    <option value="">Chọn thể loại</option>
                                    <% String genre_id = (request.getAttribute("genre_id_input") == null ? "" : request.getAttribute("genre_id_input").toString()); %>
                                    <% for (int i = 0; i < genres.size(); i++) { %>
                                        <option <%=genre_id.equals(genres.get(i).id) ? "selected" : ""%> value="<%=genres.get(i).id%>"><%= genres.get(i).name %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="author_id">Tác giả</label>
                                <select class="form-control" name="author_id" id="author_id">
                                    <option value="">Chọn tác giả</option>
                                    <% String author_id = (request.getAttribute("author_id_input") == null ? "" : request.getAttribute("author_id_input").toString()); %>
                                    <% for (int i = 0; i < authors.size(); i++) { %>
                                        <option <%=author_id.equals(authors.get(i).id) ? "selected" : ""%> value="<%=authors.get(i).id%>"><%= authors.get(i).name %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="year">Năm</label>
                                <select class="form-control" name="year" id="year">
                                    <option value="">Chọn Năm</option>
                                    <c:forEach items="${years}" var="year">
                                        <option ${year_input == year.getYear() ? "selected" : ""} value="${year.getYear()}">${year.getYear()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="keyword">Từ khóa</label>
                                <input value="${keyword_input}" type="text" class="form-control" id="keyword" name="keyword" placeholder="Nhập từ khóa bạn muốn tìm.">
                            </div>

                            <div class="col-md-1">
                                <button style="
    border-top-width: 0;
    border-left-width: 0;
    border-right-width: 0;
    padding-right: 0;
    padding-left: 0;
min-width: 70px;
margin-top: 36px;" type="submit" id="btn_search" class="btn btn-primary">Tìm</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div id="row-obh9n1ceb" class="gdz-row productbox-carousel">
                    <div class="container">
                        <div class="row">
                            <div id="column-a38iynsuw" class="layout-column col-lg-9 col-md-12 col-12 ">
                                <div id="addon-sh8v9eurj" class="addon-box">
                                    <h5 class="pb-heading title text-lg-left">
                                        Kết quả tìm kiếm
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
                                                            <span><%=books.get(i+j).author_name%></span>
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

                                                            <div id="review">
                                                                <div class="product-list-reviews no-review" data-id="129"
                                                                     data-url="https://prestashop17.joommasters.com/molla/index.php?fc=module&module=productcomments&controller=CommentGrade&id_lang=1">
                                                                    <div class="grade-stars small-stars"></div>
                                                                    <div class="comments-nb ratings-text"></div>
                                                                </div>
                                                            </div>


                                                            <div class="product-action">
                                                                <a href="#" class="ajax-add-to-cart product-btn  cart-button btn-icon"
                                                                   title="Add to cart" data-id-product="129" data-minimal-quantity="1"
                                                                   data-token="588a5a1eb02312add78ccb857e952842">
                                                                    <span>Add to cart</span>
                                                                </a>
                                                            </div>

                                                            <a href="#" class="addToWishlist btn-icon" title="Add to Wishlist"
                                                               onclick="WishlistCart('wishlist_block_list', 'add', '129', false, 1); return false;"
                                                               data-id-product="129">
                                                                <span>Add to Wishlist</span>
                                                            </a>
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
<%@ include file="/master/foot.jsp" %>
<%--<% if (user != null) {%>
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
<%}%>--%>
