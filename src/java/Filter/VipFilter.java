package Filter;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class VipFilter implements Filter{
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        MyObject user = (MyObject) req.getSession().getAttribute("login");
        Date currentDate = Calendar.getInstance().getTime();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sql = "select users.*, vip_subscriptions.id as vip_sub_id from users left join vip_subscriptions on users.id = vip_subscriptions.user_id and vip_subscriptions.from_date < ? and to_date > ? where users.id = ?";
        String[] vars = new String[]{dateFormat.format(currentDate), dateFormat.format(currentDate), user.id};
        ArrayList<MyObject> users = DB.getData(sql, vars, new String[]{"vip_sub_id"});
        if (users.size() != 1){
            req.getSession().setAttribute("mess", "warning|Lỗi hệ thống.");
            resp.sendRedirect("/login");
        } else {
            System.out.println("users.get(0).vip_sub_id : " + users.get(0).vip_sub_id);
            if (users.get(0).vip_sub_id != null){
                System.out.println("có vip");
                chain.doFilter(request, response);
            } else {
                System.out.println("không có vip");
                req.getSession().setAttribute("mess", "warning|Tài khoản của bạn không phải là tài khoản vip");
                resp.sendRedirect(req.getContextPath() + "/login");
            }
        }
    }
}
