package Controller;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class FavoriteController {
    @WebServlet("/user/add-favorite")
    public static class AddFavourite extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String book_id = req.getParameter("book_id");
            String note = req.getParameter("note");
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            String sql = "insert into favorites(user_id, book_id, note) values (?,?,?)";
            boolean check = DB.executeUpdate(sql, new String[]{user.id, book_id, note});
            if (check){
                req.getSession().setAttribute("mess","success|Đã thêm vào danh sách ưa thích.");
            } else {
                req.getSession().setAttribute("mess","warning|Đã có lỗi xảy ra, hoặc sách này đã nằm trong mục yêu thích của bạn.");
            }
            if (req.getRequestURI().contains("/view-book")){
                resp.sendRedirect(req.getContextPath() + "/view-book?id=" + book_id);
            } else {
                resp.sendRedirect(req.getContextPath());
            }
        }
    }
}
