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

public class RentalController {
    @WebServlet("/admin/rentals")
    public static class viewRentals extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select rentals.*, users.name as user_name, books.title as book_title from rentals inner join users on rentals.user_id = users.id inner join books on rentals.book_id = books.id";
            String[] fields = new String[]{"id", "book_id", "user_id", "from_date", "to_date", "price", "received_book", "returned_book", "created_at", "user_name", "created_at", "book_title", "status"};
            ArrayList<MyObject> rentals = DB.getData(sql, fields);
            req.setAttribute("rentals", rentals);
            req.getRequestDispatcher("/views/admin/rental.jsp").forward(req, resp);
        }
    }
    @WebServlet("/admin/change-rental-status")
    public static class ChangeReceivedBook extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String type = req.getParameter("type");
            String sql;
            if (type.equals("returned_book")){
                sql = "update rentals set returned_book = (case when returned_book = 'true' then 'false' else 'true' end) where id = ?";
            } else {
                sql = "update rentals set received_book = (case when received_book = 'true' then 'false' else 'true' end) where id = ?";
            }
            boolean check = DB.executeUpdate(sql, new String[]{id});
            if (check){
                req.getSession().setAttribute("mess", "success|Thay đổi thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Thay đổi không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/rentals");
        }
    }
}
