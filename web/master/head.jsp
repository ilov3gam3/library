<%@ page import="Database.MyObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Database.DB" %>
<%@ page contentType="text/html;" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% MyObject user = (MyObject) session.getAttribute("login"); %>
<% ArrayList<MyObject> genres = DB.getData("select genre.*, count(books.id) as quantity from genre left join books on genre.id = books.genre_id group by genre.id, name, genre.description", new String[]{"id", "name", "description", "quantity"}); %>
<% ArrayList<MyObject> authors = DB.getData("select authors.*, count(books.id) as work from authors left join books on authors.id = books.author_id group by authors.id, name, dob, nationality, biography, image", new String[]{"id", "name", "dob", "nationality", "biography", "image", "work"}); %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Sách vui</title>
    <meta name="description" content="Shop powered by PrestaShop">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/line-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/logo.png">
    <link rel="stylesheet"
          href="https://prestashop17.joommasters.com/molla/themes/jms_molla/assets/cache/theme-70a65c39.css"
          type="text/css" media="all">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
          integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <style>
        .toast-message {
            font-size: 14px; /* Change the font size to your desired value */
        }

        .toast-title {
            font-size: 17px; /* Change the font size to your desired value */
        }

        #toast-container > .toast {
            width: 350px;
        }

        body {
            font: normal 300 1.4rem/1.86 "Arial", sans-serif;
            color: #666;
            background-color: #fff;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            overflow-x: hidden
        }
        .chosen-select form-control chosen{
            width: 100%;
        }
    </style>
    <script type="text/javascript">
        var gdzSetting = {
            "carousel_lazyload": "0",
            "product_content_layout": "thumbs-left",
            "product_thumbs_show": "3",
            "shop_grid_column": "3",
            "footer_block_collapse": "0",
            "right_icon": "icon-right_light",
            "left_icon": "icon-left_light"
        };
        var prestashop = {
            "cart": {
                "products": [],
                "totals": {
                    "total": {"type": "total", "label": "Total", "amount": 0, "value": "$0.00"},
                    "total_including_tax": {
                        "type": "total",
                        "label": "Total (tax incl.)",
                        "amount": 0,
                        "value": "$0.00"
                    },
                    "total_excluding_tax": {
                        "type": "total",
                        "label": "Total (tax excl.)",
                        "amount": 0,
                        "value": "$0.00"
                    }
                },
                "subtotals": {
                    "products": {"type": "products", "label": "Subtotal", "amount": 0, "value": "$0.00"},
                    "discounts": null,
                    "shipping": {"type": "shipping", "label": "Shipping", "amount": 0, "value": ""},
                    "tax": null
                },
                "products_count": 0,
                "summary_string": "0 items",
                "vouchers": {"allowed": 1, "added": []},
                "discounts": [],
                "minimalPurchase": 0,
                "minimalPurchaseRequired": ""
            },
            "currency": {"name": "US Dollar", "iso_code": "USD", "iso_code_num": "840", "sign": "$"},
            "customer": {
                "lastname": null,
                "firstname": null,
                "email": null,
                "birthday": null,
                "newsletter": null,
                "newsletter_date_add": null,
                "optin": null,
                "website": null,
                "company": null,
                "siret": null,
                "ape": null,
                "is_logged": false,
                "gender": {"type": null, "name": null},
                "addresses": []
            },
            "language": {
                "name": "English (English)",
                "iso_code": "en",
                "locale": "en-US",
                "language_code": "en-us",
                "is_rtl": "0",
                "date_format_lite": "m\/d\/Y",
                "date_format_full": "m\/d\/Y H:i:s",
                "id": 1
            },
            "page": {
                "title": "",
                "canonical": null,
                "meta": {
                    "title": "Molla - Prestashop eCommerce",
                    "description": "Shop powered by PrestaShop",
                    "keywords": "",
                    "robots": "index"
                },
                "page_name": "index",
                "body_classes": {
                    "lang-en": true,
                    "lang-rtl": false,
                    "country-US": true,
                    "currency-USD": true,
                    "layout-full-width": true,
                    "page-index": true,
                    "tax-display-disabled": true
                },
                "admin_notifications": []
            },
            "shop": {
                "name": "Molla - Prestashop eCommerce",
                "logo": "https:\/\/prestashop17.joommasters.com\/molla\/img\/logo.png",
                "stores_icon": "https:\/\/prestashop17.joommasters.com\/molla\/img\/logo_stores.png",
                "favicon": "https:\/\/prestashop17.joommasters.com\/molla\/img\/favicon.ico"
            },
            "urls": {
                "base_url": "https:\/\/prestashop17.joommasters.com\/molla\/",
                "current_url": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_page=20&header_layout=1&footer_layout=1&productbox_type=product-12",
                "shop_domain_url": "https:\/\/prestashop17.joommasters.com",
                "img_ps_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/",
                "img_cat_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/c\/",
                "img_lang_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/l\/",
                "img_prod_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/",
                "img_manu_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/m\/",
                "img_sup_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/su\/",
                "img_ship_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/s\/",
                "img_store_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/st\/",
                "img_col_url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/co\/",
                "img_url": "https:\/\/prestashop17.joommasters.com\/molla\/themes\/jms_molla\/assets\/img\/",
                "css_url": "https:\/\/prestashop17.joommasters.com\/molla\/themes\/jms_molla\/assets\/css\/",
                "js_url": "https:\/\/prestashop17.joommasters.com\/molla\/themes\/jms_molla\/assets\/js\/",
                "pic_url": "https:\/\/prestashop17.joommasters.com\/molla\/upload\/",
                "pages": {
                    "address": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=address",
                    "addresses": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=addresses",
                    "authentication": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=authentication",
                    "cart": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=cart",
                    "category": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=category",
                    "cms": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=cms",
                    "contact": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=contact",
                    "discount": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=discount",
                    "guest_tracking": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=guest-tracking",
                    "history": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=history",
                    "identity": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=identity",
                    "index": "https:\/\/prestashop17.joommasters.com\/molla\/index.php",
                    "my_account": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=my-account",
                    "order_confirmation": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order-confirmation",
                    "order_detail": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order-detail",
                    "order_follow": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order-follow",
                    "order": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order",
                    "order_return": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order-return",
                    "order_slip": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order-slip",
                    "pagenotfound": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=pagenotfound",
                    "password": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=password",
                    "pdf_invoice": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=pdf-invoice",
                    "pdf_order_return": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=pdf-order-return",
                    "pdf_order_slip": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=pdf-order-slip",
                    "prices_drop": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=prices-drop",
                    "product": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=product",
                    "search": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=search",
                    "sitemap": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=sitemap",
                    "stores": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=stores",
                    "supplier": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=supplier",
                    "register": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=authentication&create_account=1",
                    "order_login": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?controller=order&login=1"
                },
                "alternative_langs": {
                    "en-us": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_page=20&header_layout=1&footer_layout=1&productbox_type=product-12&id_lang=1",
                    "fr-fr": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_page=20&header_layout=1&footer_layout=1&productbox_type=product-12&id_lang=4"
                },
                "theme_assets": "\/molla\/themes\/jms_molla\/assets\/",
                "actions": {"logout": "https:\/\/prestashop17.joommasters.com\/molla\/index.php?mylogout="},
                "no_picture_image": {
                    "bySize": {
                        "cart_default": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-cart_default.jpg",
                            "width": 80,
                            "height": 80
                        },
                        "small_default": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-small_default.jpg",
                            "width": 100,
                            "height": 100
                        },
                        "medium_default": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-medium_default.jpg",
                            "width": 200,
                            "height": 200
                        },
                        "home_default_200x300": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-home_default_200x300.jpg",
                            "width": 200,
                            "height": 300
                        },
                        "home_default_200x310": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-home_default_200x310.jpg",
                            "width": 200,
                            "height": 310
                        },
                        "home_default": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-home_default.jpg",
                            "width": 400,
                            "height": 400
                        },
                        "large_default": {
                            "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-large_default.jpg",
                            "width": 900,
                            "height": 900
                        }
                    },
                    "small": {
                        "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-cart_default.jpg",
                        "width": 80,
                        "height": 80
                    },
                    "medium": {
                        "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-home_default_200x300.jpg",
                        "width": 200,
                        "height": 300
                    },
                    "large": {
                        "url": "https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/en-default-large_default.jpg",
                        "width": 900,
                        "height": 900
                    },
                    "legend": ""
                }
            },
            "configuration": {
                "display_taxes_label": false,
                "display_prices_tax_incl": true,
                "is_catalog": false,
                "show_prices": true,
                "opt_in": {"partner": true},
                "quantity_discount": {"type": "discount", "label": "Unit discount"},
                "voucher_enabled": 1,
                "return_enabled": 0
            },
            "field_required": [],
            "breadcrumb": {
                "links": [{
                    "title": "Home",
                    "url": "https:\/\/prestashop17.joommasters.com\/molla\/index.php"
                }], "count": 1
            },
            "link": {"protocol_link": "https:\/\/", "protocol_content": "https:\/\/"},
            "time": 1696869134,
            "static_token": "588a5a1eb02312add78ccb857e952842",
            "token": "3367e315b494490ea07cb7f7cf815c81",
            "debug": false
        };
    </script>
</head>
<body id="index"
      class="lang-en country-us currency-usd layout-full-width page-index tax-display-disabled demo_20  carousel-nav-2">


<div class="main-site">
    <header id="header">
        <div id="desktop-header" class="header-1 ">
            <div class="header-intro-clearance">
                <div id="header-top" class=" header-top">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="layout-column col col-left">
                                <p class="text-h1">Special collection already available. <a href="#">Read more ...</a>
                                </p>
                                <p class="text-h3"><a href="tel:#"><i class="icon-phone"></i>Liên hệ: 0327786417</a></p>
                            </div>
                            <div class="layout-column col-auto col-right">
                                <% if (user != null) { %>
                                    <% if (user.is_admin.equals("1")) {%>
                                    <div class="row align-items-center no-margin top-menu">
                                        <div class="user-info btn-group align-items-center">
                                            <% if (user.avatar.startsWith("http")) {%>
                                                <img src="<%=user.avatar%>"
                                                     style="width: 40px; height: 40px; object-fit: cover;border-radius: 50%;"
                                                     alt="">
                                            <% } else { %>
                                                <img src="${pageContext.request.contextPath}<%=user.avatar%>"
                                                     style="width: 40px; height: 40px; object-fit: cover;border-radius: 50%;"
                                                     alt="">
                                            <% } %>
                                            <div class="dropdown">
                                                <p id="admin_dropdown" data-toggle="dropdown" aria-haspopup="true"
                                                   aria-expanded="false" class="ml-2" style="cursor: pointer"><span
                                                        class="text-danger">Quản trị viên</span> <%=user.name%>
                                                </p>
                                                <div class="dropdown-menu" aria-labelledby="admin_dropdown">
                                                    <a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/user/profile">Tài khoản của
                                                        bạn</a>
                                                    <a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/admin/admin-panel">Trang
                                                        quản trị</a>
                                                    <a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <% } else {%>
                                        <div class="row align-items-center no-margin top-menu">
                                    <div class="user-info btn-group align-items-center">
                                        <% if (user.avatar.startsWith("http")) {%>
                                        <img src="<%=user.avatar%>"
                                             style="width: 40px; height: 40px; object-fit: cover;border-radius: 50%;"
                                             alt="">
                                        <% } else { %>
                                        <img src="${pageContext.request.contextPath}<%=user.avatar%>"
                                             style="width: 40px; height: 40px; object-fit: cover;border-radius: 50%;"
                                             alt="">
                                        <% } %>
                                        <div class="dropdown">
                                            <p id="user_dropdown" data-toggle="dropdown" aria-haspopup="true"
                                               aria-expanded="false" class="ml-2" style="cursor: pointer"><span
                                                    class="text-primary">Xin chào</span> <%=user.name%> <%=user.vip_sub_id != null ? "(vip)" : ""%>
                                            </p>
                                            <p><span
                                                    class="text-primary"> &nbsp; Số dư: <%=user.account_balance%></span>
                                            </p>
                                            <div class="dropdown-menu" aria-labelledby="user_dropdown">
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/user/recharge-balance">Nạp số dư
                                                </a>
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/user/upgrade-vip">Nâng cấp lên tài khoản vip
                                                </a>
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/user/transaction">Giao dịch của bạn
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    <%}%>
                                <%} else {%>
                                    <div class="row align-items-center no-margin top-menu">
                                        <div class="user-info btn-group">
                                            <a href="${pageContext.request.contextPath}/register">
                                                <button class="btn btn-outline-dark mr-2">Đăng kí</button>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/login">
                                                <button class="btn btn-primary ml-2">Đăng nhập</button>
                                            </a>
                                        </div>
                                    </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
                <% if (!request.getRequestURI().contains("/auth/") && !request.getRequestURI().contains("/admin")) { %>
                <div id="header-middle" class="header-middle">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="layout-column col-auto header-left">

                                <a href="${pageContext.request.contextPath}/">
                                    <img
                                            class="logo img-responsive"
                                            src="${pageContext.request.contextPath}/assets/logo-20.png"
                                            alt="Molla - Prestashop eCommerce" style="width: 105px"
                                    />
                                </a>
                            </div>
                            <div class="layout-column header-center">
                                <div id="search-form" class="search-form">
                                    <form method="get"
                                          action="${pageContext.request.contextPath}/search"
                                          class="search-box">
                                        <div class="input-group">
                                            <input id="keyword" type="text" name="keyword" placeholder="Search product ..."
                                                   class="form-control"/>
                                            <button type="submit" class="button-search">
                                                <i class="icon-search"></i>
                                            </button>
                                        </div>
                                    </form>
                                    <div class="search-result-area"></div>
                                </div>
                            </div>
                            <div class="layout-column col-auto header-right">
                                <div class="row">
                                    <div style="padding: 10px" class="account">
                                        <a href="${pageContext.request.contextPath}/user/profile"
                                           title="Login/Register">
                                            <i class="icon-user"></i>
                                            <span class="text">Account</span>
                                        </a>
                                    </div>
                                    <div style="padding: 10px" id="wishlist_block" class="wishlist col-auto">
                                        <a href="${pageContext.request.contextPath}/user/favorite-list">
                                            <i class="icon-heart-o"></i>
                                            <span class="text">Ưa thích</span>
                                        </a>
                                    </div>
                                    <div style="padding: 10px" class="wishlist col-auto">
                                        <a href="${pageContext.request.contextPath}/user/renting">
                                            <i class="fa fa-book" aria-hidden="true"></i>
                                            <span class="text">Sách thuê</span>
                                        </a>
                                    </div>
                                    <div style="padding: 10px" id="" class="wishlist col-auto">
                                        <a href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out"></i>
                                            <span class="text">Đăng xuất</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-wrapper header-bottom  header-sticky sticky-slide">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="layout-column col-auto col-left">
                                <div class="vermenu d-flex align-items-center">
                                    <a href="#" class="vermenu-btn align-items-center">
                                        Thể loại
                                    </a>
                                    <div class="menu-dropdown navbar">
                                        <div class="gdz-megamenu navbar">
                                            <ul class="nav level0">
                                                <% for (int i = 0; i < genres.size(); i++) { %>
                                                    <li class="menu-item" data-id="385" data-level="0" data-title="1">
                                                        <a href="${pageContext.request.contextPath}/search?genre_id=<%=genres.get(i).id%>" target="_self"><span><%= genres.get(i).name %> (<%=genres.get(i).quantity%>)</span>
                                                        </a>
                                                    </li>
                                                <% } %>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="layout-column position-static col col-center">
                                <div id="hor-menu" class="  align-left">
                                    <div class="gdz-megamenu navbar">
                                        <ul class="nav level0">
                                            <li class="menu-item mega"><a
                                                    href="${pageContext.request.contextPath}/views/web-inf.jsp"
                                            ><span>Trang chủ</span></a>
                                            </li>
                                            <li class="menu-item mega"><a
                                                    href="${pageContext.request.contextPath}/"
                                                    target="_self"><span>Tác giả</span><em class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-12" data-width="12">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <% for (int i = 0; i < authors.size(); i++) { %>
                                                                            <li class="menu-item"
                                                                                data-level="1" data-title="1"><a
                                                                                    href="${pageContext.request.contextPath}/view-author?id=<%=authors.get(i).id%>"
                                                                                    target="_self"><span><%=authors.get(i).name%> (<%=authors.get(i).work%>)</span></a>
                                                                            </li>
                                                                        <% } %>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="menu-item mega"><a
                                                    href="${pageContext.request.contextPath}/views/contact.jsp"
                                            ><span>Liên hệ</span></a>
                                            </li>
                                            <li class="menu-item mega"><a
                                                    href="${pageContext.request.contextPath}/views/web-inf.jsp"
                                                    ><span>Thông tin về website</span></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="layout-column col-auto col-right">
                                <div class="text d-flex align-items-center">
                                    <p><span class="highlight"> Đăng kí vip hưởng ưu đãi đến 25%</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </header>
    <div id="wrapper">
        <div class="row">
            <div id="content-wrapper">
                <section id="main">
                    <section id="content" class="page-home">
