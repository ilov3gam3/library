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

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;

public class BookController {
    @WebServlet("/admin/book")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 30,      // 10 MB
            maxRequestSize = 1024 * 1024 * 30  // 10 MB
    )
    public static class BookIndex extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<MyObject> genres = DB.getData("select * from genre", new String[]{"id", "name", "description"});
            ArrayList<MyObject> authors = DB.getData("select * from authors", new String[]{"id", "name", "dob", "nationality", "biography", "image"});
            ArrayList<MyObject> locations = DB.getData("select * from locations", new String[]{"id", "floor", "room", "bookshelf", "shelf"});
            String sql = "select books.*, authors.name as author_name, genre.name as genre_name,concat(N'Tầng ', locations.floor, N', phòng ', locations.room, N', kệ ', locations.bookshelf, N', ngăn ', locations.shelf) as location_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id inner join locations on books.location_id = locations.id";
            ArrayList<MyObject> books = DB.getData(sql, new String[]{"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "location_name"});
            req.setAttribute("books", books);
            req.setAttribute("genres", genres);
            req.setAttribute("authors", authors);
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("/views/admin/book.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String author_id = req.getParameter("author_id");
            String genre_ids = req.getParameter("genre_id");
            String location_id = req.getParameter("location_id");
            String quantity = req.getParameter("quantity");
            String price = req.getParameter("price");
            Part filePart = req.getPart("image");
            String fileName = HandleFileUpload.getFileName(filePart);
            assert fileName != null;
            String newFileName = HandleFileUpload.generateUniqueFileName(fileName);
            String uploadDir = req.getServletContext().getRealPath("/") + "uploads";
            Path filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            String cover_image = "/uploads/" + newFileName;

            filePart = req.getPart("soft_file");
            fileName = HandleFileUpload.getFileName(filePart);
            assert fileName != null;
            newFileName = HandleFileUpload.generateUniqueFileName(fileName);
            uploadDir = req.getServletContext().getRealPath("/") + "uploads";
            filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            String soft_file = "/uploads/" + newFileName;

            String sql = "insert into books(title, description, author_id, genre_id, quantity, cover_image, soft_file, available,price, renting,location_id) values (?,?,?,?,?,?,?,?,?,0,?)";
            String[] vars = new String[]{title, description, author_id, genre_ids, quantity, cover_image, soft_file, "true",price, location_id};
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.setAttribute("mess", "success|Thêm sách thành công");
            } else {
                req.setAttribute("mess", "error|Thêm sách không thành công");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/book");
        }
    }

    @WebServlet("/view-book")
    public static class ViewBookDetail extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            MyObject book;
            String sql;
            String[] vars;
            String[] fields = null;
            if (user == null){
                vars = new String[]{req.getParameter("id")};
                sql = "select books.*, authors.name as author_name, genre.name as genre_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id where books.id = ?";
                fields = new String[] {"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "renting"};
            } else {
                vars = new String[]{user.id, req.getParameter("id")};
                sql = "select books.*, authors.name as author_name, genre.name as genre_name, favorites.id as favor from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id left join favorites on books.id = favorites.book_id and favorites.user_id = ? where books.id =  ?";
                fields = new String[] {"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "favor", "renting"};
            }

            ArrayList<MyObject> books = DB.getData(sql, vars, fields);

            if (books.size() == 0){
                req.getSession().setAttribute("mess", "warning|Sách này không tồn tại.");
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                book = books.get(0);
                req.setAttribute("book", book);
                req.getRequestDispatcher("/views/user/book-detail.jsp").forward(req, resp);
            }


        }
    }

    @WebServlet("/user/rent-book")
    public static class UserRent extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String book_id = req.getParameter("book_id");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date from_date = sdf.parse(req.getParameter("from_date"));
                Date to_date = sdf.parse(req.getParameter("to_date"));
                if (to_date.after(from_date)){
                    MyObject user = (MyObject) req.getSession().getAttribute("login");
                    int rent_days = (int) ((to_date.getTime() - from_date.getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    MyObject book = DB.getData("select * from books where id = ?", new String[]{book_id}, new String[]{"id", "price", "quantity", "renting"}).get(0);
                    if (Integer.parseInt(book.renting) >= Integer.parseInt(book.quantity)){
                        req.getSession().setAttribute("mess", "warning|Đã hết sách trong kho.");
                    } else {
                        int have_to_pay = rent_days * Integer.parseInt(book.price);
                        if (have_to_pay > Integer.parseInt(user.account_balance)){
                            req.getSession().setAttribute("mess", "warning|Không đủ số dư.");
                        } else {
                            LocalDateTime currentTime = LocalDateTime.now();
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            String formattedTime = currentTime.format(formatter);
                            String sql = "insert into rentals(book_id, user_id, from_date, to_date, price, received_book, returned_book, created_at) values (?, ?, ?, ?, ?, ?, ?, ?);update books set renting = renting + 1 where id = ?;update users set account_balance = account_balance - ? where id = ?";
                            String[] vars = new String[]{book_id, user.id, req.getParameter("from_date"), req.getParameter("to_date"), String.valueOf(have_to_pay), "false", "false",formattedTime, book_id, String.valueOf(have_to_pay), user.id} ;
                            boolean check = DB.executeUpdate(sql,  vars);
                            if (check){
                                user.account_balance = String.valueOf(Integer.parseInt(user.account_balance) - have_to_pay);
                                req.getSession().setAttribute("login", user);
                                req.getSession().setAttribute("mess", "success|Thuê sách thành công.");
                            } else {
                                req.getSession().setAttribute("mess", "error|Có lỗi xảy ra.");
                            }
                        }
                    }
                } else {
                    req.getSession().setAttribute("mess", "warning|Ngày bắt đầu phải trước ngày kết thúc.");
                }

            } catch (ParseException e) {
                e.printStackTrace();
                req.getSession().setAttribute("mess", "error|Có lỗi xảy ra.");
            }
            resp.sendRedirect(req.getContextPath() + "/view-book?id=" + book_id);
        }
    }

    @WebServlet("/admin/book/edit")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 10,      // 10 MB
            maxRequestSize = 1024 * 1024 * 10  // 10 MB
    )
    public static class BookUpdate extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String title = req.getParameter("update_title");
            String description = req.getParameter("update_description");
            String author_id = req.getParameter("update_author_id");
            String genre_ids = req.getParameter("update_genre_id");
            String quantity = req.getParameter("update_quantity");
            String price = req.getParameter("update_price");
            Part filePart = req.getPart("update_image");
            String fileName = HandleFileUpload.getFileName(filePart);
            assert fileName != null;
            String newFileName = HandleFileUpload.generateUniqueFileName(fileName);
            String uploadDir = req.getServletContext().getRealPath("/") + "uploads";
            Path filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            String cover_image = "/uploads/" + newFileName;

            filePart = req.getPart("update_soft_file");
            fileName = HandleFileUpload.getFileName(filePart);
            assert fileName != null;
            newFileName = HandleFileUpload.generateUniqueFileName(fileName);
            uploadDir = req.getServletContext().getRealPath("/") + "uploads";
            filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            String soft_file = "/uploads/" + newFileName;
            String sql = "UPDATE books\n" +
                    "SET title = ?,\n" +
                    "    description = ?,\n" +
                    "    author_id = ?,\n" +
                    "    genre_id = ?,\n" +
                    "    quantity = ?,\n" +
                    "    cover_image = ?,\n" +
                    "    soft_file = ?,\n" +
                    "    available = ?,\n" +
                    "    price = ?\n" +
                    "WHERE id = ?";
            String[] vars = new String[]{title, description, author_id, genre_ids, quantity, cover_image, soft_file, "true",price, String.valueOf(id)};
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.setAttribute("mess", "success|Cập nhật sách thành công");
            } else {
                req.setAttribute("mess", "error|Cập nhật sách không thành công");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/book");
        }
    }
}
