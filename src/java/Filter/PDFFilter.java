package Filter;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class PDFFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        String file_url = req.getRequestURI().replace(req.getContextPath(), "");
        MyObject user = (MyObject) req.getSession().getAttribute("login");
        if (user.is_admin.equals("1")){
            filterChain.doFilter(req, resp);
        } else {
            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String sql = "select rentals.* from rentals inner join books on rentals.book_id = books.id where books.soft_file = ? and user_id = ? and status != -1 and from_date <= ? and to_date >= ?";
            String[] vars = new String[]{file_url, user.id, formatter.format(currentDate), formatter.format(currentDate)};
            ArrayList<MyObject> list = DB.getData(sql, vars, new String[]{"id"});
            if (list.size() > 0){
                filterChain.doFilter(req, resp);
            } else {
                req.getSession().setAttribute("mess", "warning|Bạn không thể truy cập file này.");
                resp.sendRedirect(req.getContextPath() + "/user/renting");
            }
        }
    }
}
