<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
  <div class="container">
    <h1 class="page-title text-primary">${message_success}</h1>
    <h1 class="page-title text-danger">${message_error  }</h1>
    <h3 id="countdown"></h3>
    <h3>Hoặc là nhấn vô <a href="${pageContext.request.contextPath}/login">đây</a> để tới trang đăng nhập ngay.</h3>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
  window.onload = function() {
    window.setTimeout(function () {
      location.href = "${pageContext.request.contextPath}/";
    }, 10000);
    let timeLeft = 10;
    const x = setInterval(function() {
      document.getElementById("countdown").innerHTML = "Bạn sẽ được chuyển hướng đến trang chủ trong: "+ timeLeft + " giây.";
      timeLeft--;
      if (timeLeft < 0) {
        clearInterval(x);
        document.getElementById("countdown").innerHTML = "0";
      }
    }, 1000);
  };
</script>