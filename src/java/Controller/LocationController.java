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

public class LocationController {
    @WebServlet("/admin/location")
    public static class LocationIndex extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select locations.*, count(books.id) as quantity from locations inner join books on locations.id = books.location_id group by locations.id, floor, room, bookshelf, shelf";
            String[] fields = new String[]{"id", "floor", "room", "bookshelf", "shelf", "quantity"};
            ArrayList<MyObject> locations = DB.getData(sql, fields);
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("/views/admin/locations.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String floor = req.getParameter("floor");
            String room = req.getParameter("room");
            String bookshelf = req.getParameter("bookshelf");
            String shelf = req.getParameter("shelf");
            String sql = "insert into locations(floor, room, bookshelf, shelf) values (?,?,?,?)";
            String[] vars = new String[]{floor, room, bookshelf, shelf};
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.getSession().setAttribute("mess", "success|Thêm thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Thêm không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/location");
        }
    }


    @WebServlet("/admin/view-books-in-location")
    public static class BooksInLocation extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String location_id = req.getParameter("location_id");
            ArrayList<MyObject> locations = DB.getData("select concat(N'Tầng ', locations.floor, N', phòng ', locations.room, N', kệ ', locations.bookshelf, N', ngăn ', locations.shelf) as location_name from locations where id = ?", new String[]{location_id}, new String[]{"location_name"});
            if (locations.size() != 1){
                req.getSession().setAttribute("mess", "error|Có lỗi xảy ra.");
                resp.sendRedirect(req.getContextPath() + "/admin/books");
            } else {
                String sql = "select books.*, authors.name as author_name, genre.name as genre_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id where location_id = ?";
                ArrayList<MyObject> books = DB.getData(sql, new String[]{location_id}, new String[]{"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "year"});
                req.setAttribute("books", books);
                req.setAttribute("location_name", locations.get(0).location_name);
                req.getRequestDispatcher("/views/admin/books-in-location.jsp").forward(req, resp);
            }
        }
    }
}
