package Controller;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ReviewController extends HttpServlet {
    @WebServlet("/user/review-book")
    public static class UserReviewBook extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String book_id = req.getParameter("book_id");
            String review = req.getParameter("review");
            String star_rate = req.getParameter("star_rate");
            LocalDateTime currentTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedTime = currentTime.format(formatter);
            String sql = "insert into reviews(book_id, user_id, content, rating, created_at) values (?, ?, ?, ?, ?)";
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            String[] vars = new String[]{book_id, user.id, review, star_rate, formattedTime};
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.getSession().setAttribute("mess", "success|Review thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Review không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/user/review-book");
        }
    }
}
