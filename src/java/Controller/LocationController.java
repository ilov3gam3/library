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
            String sql = "select * from locations";
            String[] fields = new String[]{"id", "floor", "room", "bookshelf", "shelf"};
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

}
