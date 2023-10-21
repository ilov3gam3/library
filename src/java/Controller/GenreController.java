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

public class GenreController {


    @WebServlet("/admin/genre")
    public static class Genre extends HttpServlet{

        public static boolean checkGenreExist(String genreName){
            return DB.getData("select * from genre where name = ? ", new String[]{genreName},new String[]{"id"}).size()==0;
        }
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select * from genre";
            String[] field = new String[]{"id","name","description"};
            ArrayList<MyObject> genre_list = DB.getData(sql,field);
            req.setAttribute("genre_list",genre_list);
            req.getRequestDispatcher("/views/admin/genre-list.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            boolean check_genreName = checkGenreExist(name);
            if (check_genreName){
                String sql = "insert into genre(name,description) values(?,?) ";
                String[] vars = {name,description};
                boolean check_add = DB.executeUpdate(sql,vars);
                if (check_add){
                    req.getSession().setAttribute("mess", "success|Thêm thể loại thành công.");
                } else {
                    req.getSession().setAttribute("mess", "error|Thêm thể loại không thành công.");
                }
            }else{
                req.getSession().setAttribute("mess","warning|Tên Thể Loại đã được sử dụng");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/genre");
        }
    }

    @WebServlet("/admin/genre/delete")
    public static class GenreDelete extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String sql = "delete from genre where id = ?";
            String[] vars = new String[]{id};
            boolean check = DB.executeUpdate(sql,vars);
            if (check){
                req.getSession().setAttribute("mess", "success|Xóa thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Đã có lỗi xảy ra.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/genre");

        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        }
    }

    @WebServlet("/admin/genre/edit")
    public static class GenreEdit extends HttpServlet{
        /*@Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String[] id = new String[]{req.getParameter("id")};
            String sql = "select * from genre where id = ?";
            String[] field = new String[]{"id","name","description"};
            ArrayList<MyObject> genre_list = DB.getData(sql,id,field);
            req.setAttribute("genre_list",genre_list);
            req.getRequestDispatcher("/views/admin/genre-list.jsp").forward(req, resp);
        }*/

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name_update");
            String description = req.getParameter("description_update");
            String sql = "update genre set name = ?, description = ? where id = ?";
            String[] vars = new String[]{name,description, String.valueOf(id)};
            if (DB.executeUpdate(sql,vars)){
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Cập nhật không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/genre");
        }
    }
}
