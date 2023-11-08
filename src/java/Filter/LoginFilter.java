package Filter;

import Database.MyObject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

//@WebFilter(urlPatterns = {"/", "/", "/"})
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        MyObject user = (MyObject) req.getSession().getAttribute("login");
        if (user !=null){
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("mess", "warning|Vui lòng đăng nhập");
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
