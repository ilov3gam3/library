package Controller;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;

public class AuthorController {

    @WebServlet("/admin/author")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 10,      // 10 MB
            maxRequestSize = 1024 * 1024 * 10  // 10 MB
    )
    public static class Author extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select * from authors";
            String[] field = new String[]{"id", "name","dob","nationality","biography","image"};
            ArrayList<MyObject> author_list = DB.getData(sql,field);
            req.setAttribute("authors", author_list);
            req.getRequestDispatcher("/views/admin/author.jsp").forward(req,resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String name = req.getParameter("name");
            String dob = req.getParameter("dob");
            String nationality = req.getParameter("nationality");
            String biography = req.getParameter("biography");
            Part filePart = req.getPart("image");
            String fileName = HandleFileUpload.getFileName(filePart);
            assert fileName != null;
            String newFileName = HandleFileUpload.generateUniqueFileName(fileName);
            String uploadDir = req.getServletContext().getRealPath("/") + "uploads";
            Path filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            String sql = "insert into authors(name, dob, nationality, biography, image) values (?,?,?,?,?)";
            String[] vars = new String[]{name, dob, nationality, biography, "/uploads/" + newFileName};
            if (DB.executeUpdate(sql, vars)){
                req.getSession().setAttribute("mess", "success|Thêm mới thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Thêm mới không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/author");
        }
    }
    @WebServlet("/admin/author/delete")
    public static class AuthorDelete extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String sql = "delete from authors where id = ?";
            String[] vars = new String[]{id};
            DB.executeUpdate(sql,vars);
            resp.sendRedirect("/admin/author");
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        }
    }
    @WebServlet("/admin/author/edit")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 10,      // 10 MB
            maxRequestSize = 1024 * 1024 * 10  // 10 MB
    )
    public static class AuthorUpdate extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String[] id = new String[]{req.getParameter("id")};
            String sql = "select * from authors where id = ?";
            String[] field = new String[]{"id","name","biography", "dob", "nationality", "image"};
            ArrayList<MyObject> genre_list = DB.getData(sql,id,field);
            if (DB.getData(sql,id,field).size()==0){
                req.getSession().setAttribute("mess","warning|Không tồn tại");
            }
            req.setAttribute("genre_list",genre_list);
            req.getRequestDispatcher("/views/admin/author.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            MyObject authors = new MyObject();
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            String dob = req.getParameter("dob");
            String description = req.getParameter("description");
            String nationality = req.getParameter("nationality");
            String biography = req.getParameter("biography");
            String image = req.getContextPath();
            String sql = "update authors set name = ?,dob = ?, description = ?, nationality = ?, biography = ? where id = ?";
            String[] vars = new String[]{name,dob,description,nationality,biography, id};
            boolean check = DB.executeUpdate(sql, vars);
            if (check) {
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
                authors.name = name;
                authors.description = description;
                authors.dob = dob;
                authors.nationality = nationality;
                authors.biography = biography;
            } else {
                req.getSession().setAttribute("mess", "error|Đã có lỗi xảy ra.");
            }
        }
    }
    @WebServlet("/view-author")
    public static class ViewAuthor extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String sql = "select * from authors where id = ?";
            ArrayList<MyObject> authors = DB.getData(sql, new String[]{id}, new String[]{"id", "name", "dob", "nationality", "biography", "image"});
            if (authors.size() == 0){
                req.getSession().setAttribute("mess", "warning|Tác giả không tồn tại");
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                sql = "select books.*, genre.name as genre_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id where author_id = ?";
                ArrayList<MyObject> books = DB.getData(sql, new String[]{id}, new String[]{"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "genre_name", "year"});
                req.setAttribute("author", authors.get(0));
                req.setAttribute("books", books);
                req.getRequestDispatcher("/views/view-author.jsp").forward(req, resp);
            }
        }
    }
}
