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


    <title>Molla - Prestashop eCommerce</title>
    <meta name="description" content="Shop powered by PrestaShop">
    <meta name="keywords" content="">


    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%--    <link rel="icon" type="image/vnd.microsoft.icon" href="https://prestashop17.joommasters.com/molla/img/favicon.ico?1594094704">--%>
    <%--    <link rel="shortcut icon" type="image/x-icon" href="https://prestashop17.joommasters.com/molla/img/favicon.ico?1594094704">--%>


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/line-awesome.min.css">
    <%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/theme-70a65c39.css">--%>
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
        var added_to_wishlist = "The product was successfully added to your wishlist.";
        var gdzSetting = {
            "carousel_lazyload": "0",
            "product_content_layout": "thumbs-left",
            "product_thumbs_show": "3",
            "shop_grid_column": "3",
            "footer_block_collapse": "0",
            "right_icon": "icon-right_light",
            "left_icon": "icon-left_light"
        };
        var login_required = "You must be logged in to manage your wishlist.";
        var mywishlist_url = "http://127.0.0.1:5000/api";
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
        var psemailsubscription_subscription = "https:\/\/prestashop17.joommasters.com\/molla\/index.php?fc=module&module=ps_emailsubscription&controller=subscription&id_lang=1";
        var psr_icon_color = "#F19D76";
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
                                <p class="text-h3"><a href="tel:#"><i class="icon-phone"></i>Call: +0123 456 789</a></p>
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
                                                   href="${pageContext.request.contextPath}/user/profile">Tài khoản của
                                                    bạn</a>
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/user/recharge-balance">Nạp số dư
                                                </a>
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/user/upgrade-vip">Nâng cấp lên tài khoản vip
                                                </a>
                                                <a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
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
                                            <li class="menu-item mega sub-home menu-align-center" data-id="376"
                                                data-level="0" data-title="1" data-class="sub-home" data-align="center">
                                                <a href="index.php" target="_self"><span>Home</span><em
                                                        class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu"
                                                     data-width="1158" style="width:1158px">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-12" data-width="12">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="399"
                                                                            data-level="1" data-title="0">
                                                                            <div class="mod-content">
                                                                                <div class="megamenu demo menu"
                                                                                     style="display: block;">
                                                                                    <div class="menu-col">
                                                                                        <div class="menu-title">Choose
                                                                                            your demo
                                                                                        </div>

                                                                                        <div class="megamenu-action text-center">
                                                                                            <a href="#"
                                                                                               class="btn btn-outline-primary-2 view-all-demos"><span>View All Demos</span><i
                                                                                                    class="icon-long-arrow-right"></i></a>
                                                                                        </div>
                                                                                        <!-- End .text-center --></div>
                                                                                    <!-- End .menu-col --></div>
                                                                            </div>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="menu-item mega sub-shop" data-id="379" data-level="0"
                                                data-title="1" data-class="sub-shop"><a
                                                    href="https://prestashop17.joommasters.com/molla/index.php?id_category=10&controller=category&id_lang=1"
                                                    target="_self"><span>Shop</span><em class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu" data-width="694"
                                                     style="width:694px">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-4" data-width="4">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item group" data-id="410"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Shop with sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="411"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_list=list"
                                                                                target="_self"><span>Shop list</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="412"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=2"
                                                                                target="_self"><span>Shop Grid 2 Columns</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="413"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=3"
                                                                                target="_self"><span>Shop Grid 3 Columns</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="414"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=4"
                                                                                target="_self"><span>Shop Grid 4 Columns</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="415"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_category=14&controller=category&id_lang=1"
                                                                                target="_self"><span>Shop Market</span></a>
                                                                        </li>
                                                                        <li class="menu-item group" data-id="416"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Shop no sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="417"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_layout=no-sidebar&shop_grid_column=4"
                                                                                target="_self"><span>Shop Boxed No Sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="418"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_layout=no-sidebar&shop_grid_column=6&shop_width=0"
                                                                                target="_self"><span>Shop Fullwidth No Sidebar</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="mega-col-nav col-sm-4" data-width="4">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item group" data-id="419"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Product Category</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="420"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_layout=left-sidebar"
                                                                                target="_self"><span>Left sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="421"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_layout=right-sidebar"
                                                                                target="_self"><span>Right sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item group" data-id="422"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Shop Pages</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="423"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=1-2-1-2"
                                                                                target="_self"><span>Grid 1-2-1-2</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="424"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=2-1-2-1"
                                                                                target="_self"><span>Grid 2-1-2-1</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="425"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=1-3-1-3"
                                                                                target="_self"><span>Grid 1-3-1-3</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="426"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_category=10&controller=category&id_lang=1&shop_grid_column=3-1-3-1"
                                                                                target="_self"><span>Grid 3-1-3-1</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="mega-col-nav col-sm-4 col-banner" data-width="4"
                                                                 data-class="col-banner">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="428"
                                                                            data-level="1" data-title="0">
                                                                            <div class="mod-content">
                                                                                <div class="banner banner-overlay"><a
                                                                                        href="#"
                                                                                        class="banner banner-menu"> <img
                                                                                        src="${pageContext.request.contextPath}/assets/banner-1.jpg"
                                                                                        alt="Banner"/> <span
                                                                                        class="banner-content banner-content-top"> <span
                                                                                        class="banner-title text-white">Last <br/>Chance<br/><span><strong>Sale</strong></span> </span> </span>
                                                                                </a></div>
                                                                            </div>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="menu-item mega sub-product" data-id="388" data-level="0"
                                                data-title="1" data-class="sub-product"><a
                                                    href="https://prestashop17.joommasters.com/molla/index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1"
                                                    target="_self"><span>Product</span><em class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu" data-width="694"
                                                     style="width:694px">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-4" data-width="4">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item group" data-id="429"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Product Details</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="430"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1"
                                                                                target="_self"><span>Standard Product</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="510"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=22&rewrite=flow-slim-armchair&controller=product&id_lang=1"
                                                                                target="_self"><span>Virtual Product</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="433"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=25&rewrite=garden-armchair&controller=product&id_lang=1"
                                                                                target="_self"><span>Pack of Product</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="434"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=23&rewrite=butler-stool-ladder&controller=product&id_lang=1"
                                                                                target="_self"><span>Product color swatch</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="432"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=31&rewrite=cushion-set-3-pieces&controller=product&id_lang=1"
                                                                                target="_self"><span>Product with video</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="511"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=53&rewrite=dress-with-a-belt&controller=product&id_lang=1"
                                                                                target="_self"><span>Product with Custom tab</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="512"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=40&rewrite=sony-alpha-a5100-mirrorless-camera&controller=product&id_lang=1"
                                                                                target="_self"><span>Sold Out</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="513"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_product=23&rewrite=butler-stool-ladder&controller=product&id_lang=1"
                                                                                target="_self"><span>On Sale</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="mega-col-nav col-sm-4" data-width="4">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item group" data-id="509"
                                                                            data-level="1" data-group="1"
                                                                            data-title="1"><a href="#"
                                                                                              target="_self"><span>Product layouts</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="431"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_content_layout=thumbs-left"
                                                                                target="_self"><span>Thumbs left</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="435"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_content_layout=thumbs-right"
                                                                                target="_self"><span>Thumbs right</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="514"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_content_layout=sticky-info"
                                                                                target="_self"><span>Sticky Info</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="436"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=24&id_product_attribute=65&rewrite=petite-table-lamp&controller=product&id_lang=1&product_content_layout=thumbs-gallery"
                                                                                target="_self"><span>Gallery</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="437"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_content_layout=3-columns"
                                                                                target="_self"><span>3 columns</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="515"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_page_layout=left-sidebar"
                                                                                target="_self"><span>Left sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="516"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_page_layout=right-sidebar"
                                                                                target="_self"><span>Right sidebar</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="517"
                                                                            data-level="1" data-title="1"><a
                                                                                href="index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1&product_page_layout=no-sidebar"
                                                                                target="_self"><span>No sidebar</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="mega-col-nav col-sm-4 col-banner" data-width="4"
                                                                 data-class="col-banner">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="438"
                                                                            data-level="1" data-title="0">
                                                                            <div class="mod-content">
                                                                                <div class="banner banner-overlay"><a
                                                                                        href="#"> <img
                                                                                        src="${pageContext.request.contextPath}/assets/banner-2.jpg"
                                                                                        alt="Banner"/> <span
                                                                                        class="banner-content banner-content-bottom"> <span
                                                                                        class="banner-title text-white">New Trends<br/><span><strong>spring 2019</strong></span></span> </span>
                                                                                </a></div>
                                                                            </div>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="menu-item mega" data-id="389" data-level="0" data-title="1"><a
                                                    href="https://prestashop17.joommasters.com/molla/index.php?id_cms=4&controller=cms&id_lang=1"
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
                                            <li class="menu-item mega" data-id="400" data-level="0" data-title="1"><a
                                                    href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&category_slug=sport&post_id=29&controller=post&id_lang=1"
                                                    target="_self"><span>Blog</span><em class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-12" data-width="12">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="407"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&category_slug=mart&post_id=40&controller=post&id_lang=1"
                                                                                target="_self"><span>Classic</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="455"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&category_id=1&controller=category&id_lang=1"
                                                                                target="_self"><span>Listing</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="456"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&controller=categories&id_lang=1"
                                                                                target="_self"><span>Categories</span></a>
                                                                        </li>
                                                                        <li class="menu-item mega" data-id="518"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&category_id=9&controller=category&id_lang=1"
                                                                                target="_self"><span>Category single</span></a>
                                                                            <div class="nav-child dropdown-menu mega-dropdown-menu">
                                                                                <div class="mega-dropdown-inner">
                                                                                    <div class="row">
                                                                                        <div class="mega-col-nav col-sm-12"
                                                                                             data-width="12">
                                                                                            <div class="mega-inner">
                                                                                                <ul class="mega-nav">
                                                                                                    <li class="menu-item"
                                                                                                        data-id="519"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_id=9&controller=category&id_lang=1&page_layout=left"
                                                                                                           target="_self"><span>Left sidebar</span></a>
                                                                                                    </li>
                                                                                                    <li class="menu-item"
                                                                                                        data-id="520"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_id=9&controller=category&id_lang=1&page_layout=right"
                                                                                                           target="_self"><span>Right sidebar</span></a>
                                                                                                    </li>
                                                                                                    <li class="menu-item"
                                                                                                        data-id="521"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_id=9&controller=category&id_lang=1&page_layout=no"
                                                                                                           target="_self"><span>No sidebar</span></a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                        <li class="menu-item mega" data-id="459"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&post_id=14&controller=post&id_lang=1"
                                                                                target="_self"><span>Single Post</span></a>
                                                                            <div class="nav-child dropdown-menu mega-dropdown-menu">
                                                                                <div class="mega-dropdown-inner">
                                                                                    <div class="row">
                                                                                        <div class="mega-col-nav col-sm-12"
                                                                                             data-width="12">
                                                                                            <div class="mega-inner">
                                                                                                <ul class="mega-nav">
                                                                                                    <li class="menu-item"
                                                                                                        data-id="461"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_slug=furniture&post_id=30&controller=post&page_layout=right"
                                                                                                           target="_self"><span>Right sidebar</span></a>
                                                                                                    </li>
                                                                                                    <li class="menu-item"
                                                                                                        data-id="462"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_slug=furniture&post_id=30&controller=post&page_layout=no"
                                                                                                           target="_self"><span>No sidebar</span></a>
                                                                                                    </li>
                                                                                                    <li class="menu-item"
                                                                                                        data-id="460"
                                                                                                        data-level="2"
                                                                                                        data-title="1">
                                                                                                        <a href="index.php?fc=module&module=gdz_blog&category_slug=furniture&post_id=30&controller=post&page_layout=left"
                                                                                                           target="_self"><span>Left sidebar</span></a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                        <li class="menu-item" data-id="457"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&tag=furniture&controller=tag&id_lang=1"
                                                                                target="_self"><span>Tag</span></a></li>
                                                                        <li class="menu-item" data-id="458"
                                                                            data-level="1" data-title="1"><a
                                                                                href="//prestashop17.joommasters.com/molla/index.php?fc=module&module=gdz_blog&archive=2020-12&controller=archive&id_lang=1"
                                                                                target="_self"><span>Archive</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="menu-item mega" data-id="408" data-level="0" data-title="1"><a
                                                    href="https://prestashop17.joommasters.com/molla/index.php?id_cms=6&controller=cms&id_lang=1"
                                                    target="_self"><span>Elements</span><em class="caret"></em></a>
                                                <div class="nav-child dropdown-menu mega-dropdown-menu">
                                                    <div class="mega-dropdown-inner">
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-12" data-width="12">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="409"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=6&controller=cms&id_lang=1"
                                                                                target="_self"><span>Typography</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="mega-col-nav col-sm-12" data-width="12">
                                                                <div class="mega-inner">
                                                                    <ul class="mega-nav">
                                                                        <li class="menu-item" data-id="465"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=16&controller=cms&id_lang=1"
                                                                                target="_self"><span>Titles</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="466"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=17&controller=cms&id_lang=1"
                                                                                target="_self"><span>Buttons</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="467"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=18&controller=cms&id_lang=1"
                                                                                target="_self"><span>Accordions</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="468"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=19&controller=cms&id_lang=1"
                                                                                target="_self"><span>Tabs</span></a>
                                                                        </li>
                                                                        <li class="menu-item" data-id="469"
                                                                            data-level="1" data-title="1"><a
                                                                                href="https://prestashop17.joommasters.com/molla/index.php?id_cms=20&controller=cms&id_lang=1"
                                                                                target="_self"><span>Icon Boxs</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                            <div class="layout-column col-auto col-right">
                                <div class="text d-flex align-items-center"><i class="fa fa-lightbulb-o"></i>
                                    <p>Clearance<span class="highlight"> Up to 30% Off</span></p>
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
                        <%--                        <style id="pagebuilder-frontend-stylesheet" type="text/css">--%>
                        <%--                            #row-dhw8p8enl {} @media (max-width:991px) { #row-dhw8p8enl { }} @media (max-width:575px) { #row-dhw8p8enl { }}#column-zwkfnrf8s{} @media (max-width:991px) { #column-zwkfnrf8s { }} @media (max-width:575px) { #column-zwkfnrf8s { }}#row-i5oou8rez {} @media (max-width:991px) { #row-i5oou8rez { }} @media (max-width:575px) { #row-i5oou8rez { }}#column-rifrtujuf{} @media (max-width:991px) { #column-rifrtujuf { }} @media (max-width:575px) { #column-rifrtujuf { }} #addon-xn7737f39 .pb-spacer-inner{ height:20px;} @media (max-width:991px) { #addon-xn7737f39 .pb-spacer-inner{ height:20px;} } @media (max-width:575px) { #addon-xn7737f39 .pb-spacer-inner{ height:20px;} }#row-cbgtkl9u3 {} @media (max-width:991px) { #row-cbgtkl9u3 { }} @media (max-width:575px) { #row-cbgtkl9u3 { }}#column-swsitjal1{} @media (max-width:991px) { #column-swsitjal1 { }} @media (max-width:575px) { #column-swsitjal1 { }}#addon-ce6c4eqdc .pb-banner-text {top: 0px;left: 40px;text-align:left;}#addon-ce6c4eqdc .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  }#addon-ce6c4eqdc .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       font-size:40px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       line-height:50px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   }#addon-ce6c4eqdc .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        color:--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    }@media (max-width:991px) {--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-title {--%>
                        <%--                                    font-size:30px;--%>
                        <%--                                    line-height:35px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-title {--%>
                        <%--                                    font-size:30px;--%>
                        <%--                                    line-height:35px;--%>
                        <%--                                }--%>
                        <%--                                #addon-ce6c4eqdc .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#column-agi747c3c{} @media (max-width:991px) { #column-agi747c3c { }} @media (max-width:575px) { #column-agi747c3c { }}#addon-9uvpqfyna .pb-banner-text {top: 25px;left: 40px;text-align:left;}#addon-9uvpqfyna .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                                font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                color:#ffffff--%>
                        <%--                                                                                                                                                                                                                            }#addon-9uvpqfyna .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                 font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                 line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                 color:#ffffff--%>
                        <%--                                                                                                                                                                                                                             }#addon-9uvpqfyna .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                  font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                  line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                  color:--%>
                        <%--                                                                                                                                                                                                                              }@media (max-width:991px) {--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9uvpqfyna .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#column-o4xhr90y6{} @media (max-width:991px) { #column-o4xhr90y6 { }} @media (max-width:575px) { #column-o4xhr90y6 { }}#addon-77nx3txla .pb-banner-text {top: 0px;left: 30px;text-align:left;}#addon-77nx3txla .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                               font-size:14px;--%>
                        <%--                                                                                                                                                                                                                               line-height:21px;--%>
                        <%--                                                                                                                                                                                                                               color:#ffffff--%>
                        <%--                                                                                                                                                                                                                           }#addon-77nx3txla .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                color:#ffffff--%>
                        <%--                                                                                                                                                                                                                            }#addon-77nx3txla .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                 font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                 line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                 color:--%>
                        <%--                                                                                                                                                                                                                             }@media (max-width:991px) {--%>
                        <%--                                #addon-77nx3txla .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-77nx3txla .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-77nx3txla .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            } #addon-kknbu0r4f .pb-spacer-inner{ height:20px;} @media (max-width:991px) { #addon-kknbu0r4f .pb-spacer-inner{ height:40px;} } @media (max-width:575px) { #addon-kknbu0r4f .pb-spacer-inner{ height:30px;} }#addon-9hybhk8fh .pb-banner-text {top: 0px;left: 30px;text-align:left;}#addon-9hybhk8fh .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                                                                                                                     font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                     line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                     color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                 }#addon-9hybhk8fh .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                                                                                                      font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                      line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                      color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                  }#addon-9hybhk8fh .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                                                                                                       font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                       line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                       color:--%>
                        <%--                                                                                                                                                                                                                                                                                                                   }@media (max-width:991px) {--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-9hybhk8fh .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#row-6lllqhkxu {padding-top:25px;padding-bottom:25px;} @media (max-width:991px) { #row-6lllqhkxu { }} @media (max-width:575px) { #row-6lllqhkxu { }}#column-4lfbrt40h{} @media (max-width:991px) { #column-4lfbrt40h { }} @media (max-width:575px) { #column-4lfbrt40h { }}#addon-5rhyxkq7p .pb-service-box {text-align:left;}#addon-5rhyxkq7p .pb-service-icon i{font-size:34px;}#addon-5rhyxkq7p .pb-service-icon img{width:25%;}#column-2y1kdp964{} @media (max-width:991px) { #column-2y1kdp964 { }} @media (max-width:575px) { #column-2y1kdp964 { }}#addon-rrcffktlp .pb-service-box {text-align:left;}#addon-rrcffktlp .pb-service-icon i{font-size:34px;}#addon-rrcffktlp .pb-service-icon img{width:25%;}#column-rma1buzfv{} @media (max-width:991px) { #column-rma1buzfv { }} @media (max-width:575px) { #column-rma1buzfv { }}#addon-i5j08rk6d .pb-service-box {text-align:left;}#addon-i5j08rk6d .pb-service-icon i{font-size:34px;}#addon-i5j08rk6d .pb-service-icon img{width:25%;}#column-acjkqul12{} @media (max-width:991px) { #column-acjkqul12 { }} @media (max-width:575px) { #column-acjkqul12 { }}#addon-381rl0da0 .pb-service-box {text-align:left;}#addon-381rl0da0 .pb-service-icon i{font-size:34px;}#addon-381rl0da0 .pb-service-icon img{width:25%;}#row-dlwmhtm0z {background-color:#f8f8f8;padding-top:51px;padding-bottom:44px;} @media (max-width:991px) { #row-dlwmhtm0z { }} @media (max-width:575px) { #row-dlwmhtm0z { }}#column-i8iorhy4b{} @media (max-width:991px) { #column-i8iorhy4b { }} @media (max-width:575px) { #column-i8iorhy4b { }}#addon-eeieeg3ez .pb-heading{color: ;text-align: center;font-size: 24px;}@media (max-width:991px) {--%>
                        <%--                                #addon-eeieeg3ez .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-eeieeg3ez .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }#column-79i6ye0wq{} @media (max-width:991px) { #column-79i6ye0wq { }} @media (max-width:575px) { #column-79i6ye0wq { }}#column-qpb72cal9{margin-top:2px;} @media (max-width:991px) { #column-qpb72cal9 { }} @media (max-width:575px) { #column-qpb72cal9 { }}#addon-hihkn1g36 .row {margin-left: -10px;margin-right: -10px;}#addon-hihkn1g36 .row > div {padding-left: 10px;padding-right: 10px;}#row-ugg1c8gdt {margin-top:51px;} @media (max-width:991px) { #row-ugg1c8gdt { }} @media (max-width:575px) { #row-ugg1c8gdt { }}#column-c4o9841vm{} @media (max-width:991px) { #column-c4o9841vm { }} @media (max-width:575px) { #column-c4o9841vm { }}#addon-o5c1kd3vz .pb-heading{color: ;text-align: center;font-size: 24px;}@media (max-width:991px) {--%>
                        <%--                                #addon-o5c1kd3vz .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-o5c1kd3vz .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }#column-i8r6yjj6q{} @media (max-width:991px) { #column-i8r6yjj6q { }} @media (max-width:575px) { #column-i8r6yjj6q { }}#column-ta7172iga{margin-top:22px;} @media (max-width:991px) { #column-ta7172iga { }} @media (max-width:575px) { #column-ta7172iga { }}#column-48puem1g8{margin-top:2px;} @media (max-width:991px) { #column-48puem1g8 { }} @media (max-width:575px) { #column-48puem1g8 { }}#addon-uwv1niuuw .row {margin-left: -10px;margin-right: -10px;}#addon-uwv1niuuw .row > div {padding-left: 10px;padding-right: 10px;}#row-h8x1776es {margin-top:67px;} @media (max-width:991px) { #row-h8x1776es { }} @media (max-width:575px) { #row-h8x1776es { }}#column-sru36d93w{} @media (max-width:991px) { #column-sru36d93w { }} @media (max-width:575px) { #column-sru36d93w { }}#addon-v0za8537a .pb-banner-text {top: 0px;left: 40px;text-align:left;}#addon-v0za8537a .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  }#addon-v0za8537a .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       color:#ffffff--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   }#addon-v0za8537a .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        color:--%>
                        <%--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    }@media (max-width:991px) {--%>
                        <%--                                #addon-v0za8537a .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-v0za8537a .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-v0za8537a .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#column-95xbvfte1{} @media (max-width:991px) { #column-95xbvfte1 { }} @media (max-width:575px) { #column-95xbvfte1 { }}#addon-zodu7zusf .pb-banner-text {top: 0px;left: 40px;text-align:left;}#addon-zodu7zusf .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                               font-size:14px;--%>
                        <%--                                                                                                                                                                                                                               line-height:21px;--%>
                        <%--                                                                                                                                                                                                                               color:#ffffff--%>
                        <%--                                                                                                                                                                                                                           }#addon-zodu7zusf .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                color:#ffffff--%>
                        <%--                                                                                                                                                                                                                            }#addon-zodu7zusf .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                 font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                 line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                 color:--%>
                        <%--                                                                                                                                                                                                                             }@media (max-width:991px) {--%>
                        <%--                                #addon-zodu7zusf .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-zodu7zusf .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-zodu7zusf .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#column-t4wjn72kp{} @media (max-width:991px) { #column-t4wjn72kp { }} @media (max-width:575px) { #column-t4wjn72kp { }}#addon-d632qyolq .pb-banner-text {top: 0px;left: 40px;text-align:left;}#addon-d632qyolq .pb-banner-subtitle {--%>
                        <%--                                                                                                                                                                                                                               font-size:14px;--%>
                        <%--                                                                                                                                                                                                                               line-height:21px;--%>
                        <%--                                                                                                                                                                                                                               color:#ffffff--%>
                        <%--                                                                                                                                                                                                                           }#addon-d632qyolq .pb-banner-title {--%>
                        <%--                                                                                                                                                                                                                                font-size:24px;--%>
                        <%--                                                                                                                                                                                                                                line-height:30px;--%>
                        <%--                                                                                                                                                                                                                                color:#ffffff--%>
                        <%--                                                                                                                                                                                                                            }#addon-d632qyolq .pb-banner-desc {--%>
                        <%--                                                                                                                                                                                                                                 font-size:14px;--%>
                        <%--                                                                                                                                                                                                                                 line-height:21px;--%>
                        <%--                                                                                                                                                                                                                                 color:--%>
                        <%--                                                                                                                                                                                                                             }@media (max-width:991px) {--%>
                        <%--                                #addon-d632qyolq .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-desc {--%>
                        <%--                                    font-size:12px;--%>
                        <%--                                    line-height:18px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-d632qyolq .pb-banner-text {--%>
                        <%--                                    top: 20px;--%>
                        <%--                                    left: 20px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-subtitle {--%>
                        <%--                                    font-size:14px;--%>
                        <%--                                    line-height:21px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-title {--%>
                        <%--                                    font-size:24px;--%>
                        <%--                                    line-height:30px;--%>
                        <%--                                }--%>
                        <%--                                #addon-d632qyolq .pb-banner-desc {--%>
                        <%--                                    font-size:10px;--%>
                        <%--                                    line-height:15px;--%>
                        <%--                                }--%>
                        <%--                            }#row-obh9n1ceb {margin-top:40px;} @media (max-width:991px) { #row-obh9n1ceb { }} @media (max-width:575px) { #row-obh9n1ceb { }}#column-a38iynsuw{} @media (max-width:991px) { #column-a38iynsuw { }} @media (max-width:575px) { #column-a38iynsuw { }}#addon-sh8v9eurj .pb-heading{color: ;text-align: center;font-size: 24px;}@media (max-width:991px) {--%>
                        <%--                                #addon-sh8v9eurj .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-sh8v9eurj .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }#column-zccnpjra1{} @media (max-width:991px) { #column-zccnpjra1 { }} @media (max-width:575px) { #column-zccnpjra1 { }}#column-mdcq0qomx{margin-top:3px;} @media (max-width:991px) { #column-mdcq0qomx { }} @media (max-width:575px) { #column-mdcq0qomx { }}#addon-64c94fifg .row {margin-left: -10px;margin-right: -10px;}#addon-64c94fifg .row > div {padding-left: 10px;padding-right: 10px;}#row-x91ezwue6 {background-color:#f8f8f8;padding-top:46px;padding-bottom:51px;margin-top:30px;} @media (max-width:991px) { #row-x91ezwue6 { }} @media (max-width:575px) { #row-x91ezwue6 { }}#column-kvq8yps29{margin-bottom:25px;} @media (max-width:991px) { #column-kvq8yps29 { }} @media (max-width:575px) { #column-kvq8yps29 { }}#addon-lslgvhxfs .pb-heading{color: ;text-align: center;font-size: 24px;}@media (max-width:991px) {--%>
                        <%--                                #addon-lslgvhxfs .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-lslgvhxfs .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }#column-euwx3z980{} @media (max-width:991px) { #column-euwx3z980 { }} @media (max-width:575px) { #column-euwx3z980 { }}#row-t1roqf33w {padding-top:60px;padding-bottom:70px;} @media (max-width:991px) { #row-t1roqf33w { }} @media (max-width:575px) { #row-t1roqf33w { }}#column-hgqhnftfg{margin-bottom:14px;} @media (max-width:991px) { #column-hgqhnftfg { }} @media (max-width:575px) { #column-hgqhnftfg { }}#addon-th0cj01jl .gdz-icon-box {text-align:center;}#addon-th0cj01jl .gdz-icon-box i{font-size:45px;}#addon-th0cj01jl .gdz-icon-box img{width:25%;}#column-5xgr5me01{margin-bottom:5px;} @media (max-width:991px) { #column-5xgr5me01 { }} @media (max-width:575px) { #column-5xgr5me01 { }}#addon-srnbead6v .pb-heading{color: ;text-align: center;font-size: 24px;}@media (max-width:991px) {--%>
                        <%--                                #addon-srnbead6v .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-srnbead6v .pb-heading {--%>
                        <%--                                    font-size: 22px;--%>
                        <%--                                }--%>
                        <%--                            }#column-rv50wu6id{margin-bottom:9px;} @media (max-width:991px) { #column-rv50wu6id { }} @media (max-width:575px) { #column-rv50wu6id { }}#addon-dnvw91jnk .pb-text-content{color: ;text-align: center;font-size: 14px;}@media (max-width:991px) {--%>
                        <%--                                #addon-dnvw91jnk .pb-text-content {--%>
                        <%--                                    font-size: 14px;--%>
                        <%--                                }--%>
                        <%--                            }@media (max-width:575px) {--%>
                        <%--                                #addon-dnvw91jnk .pb-text-content {--%>
                        <%--                                    font-size: 14px;--%>
                        <%--                                }--%>
                        <%--                            }#column-yfhwli0z7{} @media (max-width:991px) { #column-yfhwli0z7 { }} @media (max-width:575px) { #column-yfhwli0z7 { }}--%>
                        <%--                        </style>--%>
