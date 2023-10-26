<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-3">
    <div class="row">
        <div id="content-wrapper" class="col-12 col-lg-12">
            <section id="main" itemscope="">
                <div id="row-obh9n1ceb" class="gdz-row productbox-carousel">
                    <div class="container">
                        <div class="row">
                            <div id="column-a38iynsuw" class="layout-column col-lg-9 col-md-12 col-12 ">
                                <div id="addon-sh8v9eurj" class="addon-box">
                                    <h5 class="pb-heading title text-lg-left">
                                        Những sách ở ${location_name}
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
                                                           href="/views/home.jsp/prestashop17.joommasters.com/molla/index.php?id_category=55&controller=category&id_lang=1">
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
