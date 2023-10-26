package Filter;

import Database.MyObject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class AdminFilter implements Filter{
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        MyObject user = (MyObject) req.getSession().getAttribute("login");
        if (user.is_admin.equals("1")){
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("mess", "warning|Bạn không có quyền quản trị viên.");
            resp.sendRedirect("/login");
        }
    }
}
