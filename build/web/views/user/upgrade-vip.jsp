<%@ page import="Init.Config" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="breadcrumb page-header text-center">
    <div class="container">
        <h1 class="page-title">Nâng cấp lên tài khoản vip</h1>
    </div>
</div>
<div class="container mt-2">
    <div class="row col-12 d-flex justify-content-center">
        <div class="col-md-10 ">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="font-weight-bold">Quyền lợi khi lên tài khoản vip.</h3>
                    <h4><i class="fa fa-diamond" aria-hidden="true"></i>Thuê sách không cần trả phí</h4>
                    <h4><i class="fa fa-diamond" aria-hidden="true"></i>Được phép tải bản mềm của sách.</h4>
                    <h4><i class="fa fa-diamond" aria-hidden="true"></i>Bảo hành trọn đời</h4>
                    <h4><i class="fa fa-diamond" aria-hidden="true"></i>Mức giá ưu đãi chỉ <%=Config.vip_amount%>đ/tháng</h4>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-6">
                                <button onclick="choose_pack(1)" class="btn btn-block btn-outline-primary m-1" id="1">1 tháng</button><br>
                                <button onclick="choose_pack(3)" class="btn btn-block btn-outline-primary m-1" id="3">3 tháng <span class="text-danger">&ensp;(Giảm 10%)</span> </button><br>
                                <button onclick="choose_pack(6)" class="btn btn-block btn-outline-primary m-1" id="6">6 tháng <span class="text-danger">&ensp;(Giảm 15%)</span> </button><br>
                                <button onclick="choose_pack(9)" class="btn btn-block btn-outline-primary m-1" id="9">9 tháng <span class="text-danger">&ensp;(Giảm 20%)</span> </button><br>
                                <button onclick="choose_pack(12)" class="btn btn-block btn-outline-primary m-1" id="12">12 tháng <span class="text-danger">&ensp;(Giảm 25%)</span> </button>
                            </div>
                            <div class="col-6 text-center" id="text">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row col-12 d-flex justify-content-center">
        <form onsubmit="check_form(event)" action="${pageContext.request.contextPath}/user/upgrade-vip" method="post">
            <input type="hidden" name="months" id="months">
            <button class="btn btn-primary btn-block" id="upgrade">Nâng cấp ngay</button>
        </form>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    function notEnoughBalance() {
        toastr.warning("Tài khoản của bạn không đủ số dư, vui lòng nạp thêm.")
    }
    var vip_amount = <%=Config.vip_amount%>
    var account_balance = <%=user.account_balance%>
    function choose_pack(months) {
        $("#months").val(months)
        $("#1").attr("class", "btn btn-block btn-outline-primary m-1")
        $("#3").attr("class", "btn btn-block btn-outline-primary m-1")
        $("#6").attr("class", "btn btn-block btn-outline-primary m-1")
        $("#9").attr("class", "btn btn-block btn-outline-primary m-1")
        $("#12").attr("class", "btn btn-block btn-outline-primary m-1")

        $("#" + months).attr("class", "btn btn-block btn-primary m-1")
        var discount;
        switch (months){
            case 1:{
                discount = 0;
                break
            }
            case 3:{
                discount = 10;
                break
            }
            case 6:{
                discount = 15;
                break
            }
            case 9:{
                discount = 20;
                break
            }
            case 12:{
                discount = 25;
                break
            }
            default:{
                toastr.warning("Số tháng không hợp lệ.")
            }
        }
        var html = vip_amount + " x " + months + " x " + discount + "% = " + vip_amount * months * (1- discount/100) + "đ<br> Giảm được " + vip_amount * months * (discount/100) + 'đ';
        var have_to_pay = vip_amount * months * (1- discount/100)
        if (have_to_pay > account_balance){
            toastr.warning("Không đủ số dư")
            $("#upgrade").attr("disabled", true)
        } else {
            $("#upgrade").attr("disabled", false)
        }
        $("#text").html(html)
    }
    function check_form(e) {
        if ($("#months").val() === ''){
            e.preventDefault()
            toastr.warning("Vui lòng chọn 1 gói để nâng cấp.")
        }
    }
</script>