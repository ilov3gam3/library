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

public class LateReturnController {
    @WebServlet("/admin/late-return")
    public static class LateIndex extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select late_returns.*, users.name as user_name, books.title as book_title, rentals.created_at as rent_at, rentals.to_date as to_date from late_returns inner join rentals on late_returns.rental_id = rentals.id inner join users on rentals.user_id = users.id inner join books on rentals.book_id = books.id";
            ArrayList<MyObject> late_returns = DB.getData(sql, new String[]{"id", "rental_id", "penalty_fee_date", "amount", "user_name", "book_title", "rent_at", "to_date"});
            req.setAttribute("late_returns", late_returns);
            int amount = 0;
            for (int i = 0; i < late_returns.size(); i++) {
                amount += Integer.parseInt(late_returns.get(i).amount);
            }
            req.setAttribute("amount", amount);
            req.getRequestDispatcher("/views/admin/late_free.jsp").forward(req, resp);
        }
    }
}
