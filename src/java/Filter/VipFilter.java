package Filter;

import Database.MyObject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class VipFilter implements Filter{
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        MyObject user = (MyObject) req.getSession().getAttribute("login");
        if (user.getRole_name().equals("vip")){
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("mess", "warning|Tài khoản của bạn không phải là tài khoản vip");
            resp.sendRedirect("/login");
        }
    }
}
