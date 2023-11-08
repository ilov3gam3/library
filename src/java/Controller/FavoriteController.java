package Controller;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

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
                resp.sendRedirect(req.getContextPath() + "/");
            }
        }
    }

    @WebServlet("/user/favorite-list")
    public static class UserViewFavorList extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select favorites.*, books.title as book_title, books.cover_image as cover_image from favorites inner join books on favorites.book_id = books.id where user_id = ?";
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            String[] vars = new String[]{user.id};
            String[] fields = new String[]{"id", "book_id", "book_title", "cover_image", "note"};
            ArrayList<MyObject> favors = DB.getData(sql, vars, fields);
            req.setAttribute("favors", favors);
            req.getRequestDispatcher("/views/user/favor_list.jsp").forward(req, resp);
        }
    }

    @WebServlet("/user/delete-favor")
    public static class UserDeleteFavor extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String sql = "delete favorites where id = ?";
            boolean check = DB.executeUpdate(sql, new String[]{id});
            if (check){
                req.getSession().setAttribute("mess", "success|Xóa thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Xóa không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/user/favorite-list");
        }
    }
}
