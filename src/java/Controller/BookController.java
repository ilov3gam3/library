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

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
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
            ArrayList<MyObject> books = DB.getData(sql, new String[]{"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "location_name", "year"});
            req.setAttribute("books", books);
            req.setAttribute("genres", genres);
            req.setAttribute("authors", authors);
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("/views/admin/book.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String title = req.getParameter("title").replace("'", "`").replace("\"", "`").replace("\n", "").strip();
            String description = req.getParameter("description").replace("'", "`").replace("\"", "`").replace("\n", "").strip();
            String author_id = req.getParameter("author_id");
            String genre_ids = req.getParameter("genre_id");
            String location_id = req.getParameter("location_id");
            String quantity = req.getParameter("quantity");
            String price = req.getParameter("price");
            String year = req.getParameter("year");
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
            uploadDir = req.getServletContext().getRealPath("/") + "pdfs";
            filePath = Paths.get(uploadDir, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            String soft_file = "/pdfs/" + newFileName;

            String sql = "insert into books(title, description, author_id, genre_id, quantity, cover_image, soft_file, available,price, renting,location_id, year) values (?,?,?,?,?,?,?,?,?,0,?, ?)";
            String[] vars = new String[]{title, description, author_id, genre_ids, quantity, cover_image, soft_file, "true",price, location_id, year};
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
                fields = new String[] {"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "renting", "year"};
            } else {
                vars = new String[]{user.id, req.getParameter("id")};
                sql = "select books.*, authors.name as author_name, genre.name as genre_name, favorites.id as favor from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id left join favorites on books.id = favorites.book_id and favorites.user_id = ? where books.id =  ?";
                fields = new String[] {"id", "title", "description", "author_id", "genre_id", "quantity", "cover_image","price", "soft_file", "available", "author_name", "genre_name", "favor", "renting", "year"};
            }

            ArrayList<MyObject> books = DB.getData(sql, vars, fields);

            if (books.size() == 0){
                req.getSession().setAttribute("mess", "warning|Sách này không tồn tại.");
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                book = books.get(0);
                sql = "select reviews.*, users.name as name, users.avatar as avatar from reviews inner join users on reviews.user_id = users.id where book_id = ? order by id desc";
                ArrayList<MyObject> reviews = DB.getData(sql, new String[]{book.id}, new String[]{"id", "book_id", "user_id", "content", "rating", "created_at", "name", "avatar"});
                req.setAttribute("book", book);
                req.setAttribute("reviews", reviews);
                req.setAttribute("reviews_number", reviews.size());
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
                        System.out.println("hết sách");
                        req.getSession().setAttribute("mess", "warning|Đã hết sách trong kho.");
                    } else {
                        int have_to_pay = rent_days * Integer.parseInt(book.price);
                        if (have_to_pay > Integer.parseInt(user.account_balance)){
                            req.getSession().setAttribute("mess", "warning|Không đủ số dư.");
                        } else {
                            LocalDateTime currentTime = LocalDateTime.now();
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            String formattedTime = currentTime.format(formatter);
                            String sql = "insert into rentals(book_id, user_id, from_date, to_date, price, received_book, returned_book, created_at, status) values (?, ?, ?, ?, ?, ?, ?, ?, 0);update books set renting = renting + 1 where id = ?;update users set account_balance = account_balance - ? where id = ?";
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
            String year = req.getParameter("year_update");
            String quantity = req.getParameter("update_quantity");
            String price = req.getParameter("update_price");
            Part filePart = req.getPart("update_image");
            String fileName = "";
            String newFileName = "";
            String uploadDir = "";
            String soft_file;
            Path filePath;
            String cover_image;
            if (filePart !=null && filePart.getSize() > 0){
                fileName = HandleFileUpload.getFileName(filePart);
                assert fileName != null;
                newFileName = HandleFileUpload.generateUniqueFileName(fileName);
                uploadDir = req.getServletContext().getRealPath("/") + "uploads";
                filePath = Paths.get(uploadDir, newFileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                cover_image = "/uploads/" + newFileName;
            } else {
                cover_image = "";
            }

            filePart = req.getPart("update_soft_file");
            if (filePart !=null && filePart.getSize() > 0){
                fileName = HandleFileUpload.getFileName(filePart);
                assert fileName != null;
                newFileName = HandleFileUpload.generateUniqueFileName(fileName);
                uploadDir = req.getServletContext().getRealPath("/") + "pdfs";
                filePath = Paths.get(uploadDir, newFileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                soft_file = "/pdfs/" + newFileName;
            } else {
                soft_file = "";
            }
            String sql = "UPDATE books\n" +
                    "SET title = ?,\n" +
                    "    description = ?,\n" +
                    "    author_id = ?,\n" +
                    "    genre_id = ?,\n" +
                    "    quantity = ?,\n" +
                    "    cover_image = IIF(? = '', cover_image, ?),\n" +
                    "    soft_file = IIF(? = '', soft_file, ?),\n" +
                    "    available = ?,\n" +
                    "    price = ?\n," +
                    "   year = ?" +
                    "WHERE id = ?";
            String[] vars = new String[]{title, description, author_id, genre_ids, quantity, cover_image,cover_image, soft_file,soft_file, "true",price,year, String.valueOf(id)};
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.setAttribute("mess", "success|Cập nhật sách thành công");
            } else {
                req.setAttribute("mess", "error|Cập nhật sách không thành công");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/book");
        }
    }

    @WebServlet("/user/renting")
    public static class UserViewRenting extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select rentals.*, books.title as book_title, books.cover_image as cover_image, books.soft_file as soft_file from rentals inner join books on rentals.book_id = books.id where user_id = ? order by id desc";
            String[] fields = new String[]{"id", "book_id", "user_id", "from_date", "to_date", "price", "received_book", "returned_book", "created_at", "book_title", "cover_image", "soft_file", "status"};
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            ArrayList<MyObject> rentals = DB.getData(sql, new String[]{user.id}, fields);
            System.out.println(rentals);
            req.setAttribute("rentals", rentals);
            req.getRequestDispatcher("/views/user/view-renting.jsp").forward(req, resp);
        }
    }

    @WebServlet("/search")
    public static class SearchBook extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String keyword = req.getParameter("keyword") == null || req.getParameter("keyword").equals("") ? null : req.getParameter("keyword");
            String genre_id = req.getParameter("genre_id") == null || req.getParameter("genre_id").equals("") ? null : req.getParameter("genre_id");
            String author_id = req.getParameter("author_id") == null || req.getParameter("author_id").equals("") ? null : req.getParameter("author_id");
            String year = req.getParameter("year") == null || req.getParameter("year").equals("") ? null  : req.getParameter("year");
            if (keyword == null && genre_id == null && author_id == null && year == null){
                String sql = "select books.*, authors.name as author_name, genre.name as genre_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id";
                String[] fields = new String[]{"id", "title", "description", "quantity", "renting", "cover_image", "author_name", "genre_name", "renting", "price"};
                ArrayList<MyObject> books = DB.getData(sql,fields);
                req.setAttribute("books", books);
                req.getRequestDispatcher("/views/search.jsp").forward(req, resp);
            } else {
                String sql = "select books.*, authors.name as author_name, genre.name as genre_name from books inner join authors on books.author_id = authors.id inner join genre on books.genre_id = genre.id where ";
                sql += keyword == null ? "" : "title like ? or books.description like ?";
                sql += sql.endsWith("where ") ? (genre_id == null ? "" : "genre_id = ?") : (genre_id == null ? "" : "and genre_id = ?");
                sql += sql.endsWith("where ") ? (author_id == null ? "" : "author_id = ?") : (author_id == null ? "" : "and author_id = ?");
                sql += sql.endsWith("where ") ? (year == null ? "" : "year = ?") : (year == null ? "" : "and year = ?");
                String[] nonNullStrings = new String[5];
                int count = 0;
                if (keyword != null) {
                    nonNullStrings[count] = "%" + keyword + "%";
                    count++;
                }
                if (keyword != null) {
                    nonNullStrings[count] = "%" + keyword + "%";
                    count++;
                }
                if (genre_id != null) {
                    nonNullStrings[count] = genre_id;
                    count++;
                }
                if (author_id != null) {
                    nonNullStrings[count] = author_id;
                    count++;
                }
                if (year != null) {
                    nonNullStrings[count] = year;
                    count++;
                }
                String[] vars = new String[count];
                System.arraycopy(nonNullStrings, 0, vars, 0, count);
                String[] fields = new String[]{"id", "title", "description", "quantity", "renting", "cover_image", "author_name", "genre_name", "renting", "price"};
                ArrayList<MyObject> books = DB.getData(sql, vars, fields);
                req.setAttribute("books", books);
                req.setAttribute("keyword_input", keyword);
                req.setAttribute("genre_id_input", genre_id);
                req.setAttribute("author_id_input", author_id);
                ArrayList<MyObject> years = DB.getData("select year from books group by year", new String[]{"year"});
                req.setAttribute("years", years);
                req.setAttribute("year_input", year);
                req.getRequestDispatcher("/views/search.jsp").forward(req, resp);
            }
        }
    }

    @WebServlet("/vip/rent-book")
    public static class VipRentBook extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String book_id = req.getParameter("book_id");
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            String sql = "insert into rentals(book_id, user_id, from_date, to_date, price, received_book, returned_book, created_at, status) values (?, ?, ?, ?, ?, ?, ?, ?, 0);update books set renting = renting + 1 where id = ?;";
            LocalDateTime currentTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedTime = currentTime.format(formatter);
            String[] vars = new String[]{book_id, user.id, req.getParameter("from_date"), req.getParameter("to_date"), "0", "false", "false",formattedTime, book_id} ;
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                req.getSession().setAttribute("mess", "success|Thuê sách thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Thuê sách không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/view-book?id=" + book_id);
        }
    }

    @WebServlet("/user/view-pdf")
    public static class ViewPdf extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String rent_id = req.getParameter("book_id");
            String user_id = ((MyObject)req.getSession().getAttribute("login")).id;
            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            ArrayList<MyObject> rentals = DB.getData("select * from rentals where id = ? and status != -1 and from_date < ? and to_date > ? and user_id = ?", new String[]{rent_id, formatter.format(currentDate), formatter.format(currentDate), user_id}, new String[]{"id", "book_id"});
            if (rentals.size() !=1){
                req.getSession().setAttribute("mess", "warning|Bạn không thể truy cập file này.");
                resp.sendRedirect(req.getContextPath() + "/user/renting");
            } else {
                ArrayList<MyObject> books = DB.getData("select * from books where id = ?", new String[]{rentals.get(0).book_id}, new String[]{"soft_file"});
                if (books.size() != 1){
                    req.getSession().setAttribute("mess", "warning|Sách không tồn tại.");
                    resp.sendRedirect(req.getContextPath() + "/user/renting");
                } else {
                    String pdf_path = books.get(0).soft_file ;
                    byte[] pdf_bytes = Files.readAllBytes(Paths.get(getServletContext().getRealPath(pdf_path)));
                    resp.setContentType("application/pdf");
                    resp.setHeader("Content-Disposition", "inline; filename=book");
                    resp.getOutputStream().write(pdf_bytes);
                }
            }
        }
    }

    @WebServlet("/admin/find-book-location")
    public static class FindLocation extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/admin/find-book-location.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String name_id = req.getParameter("name_id");
            String sql ;
            String[] vars;
            try {
                int id = Integer.parseInt(name_id);
                sql = "select books.*, concat(N'Tầng ', locations.floor, N', phòng ', locations.room, N', kệ ', locations.bookshelf, N', ngăn ', locations.shelf) as location_name from books inner join locations on books.location_id = locations.id where books.id = ?";
                vars = new String[]{name_id};
            } catch (NumberFormatException e){
                sql = "select books.*, concat(N'Tầng ', locations.floor, N', phòng ', locations.room, N', kệ ', locations.bookshelf, N', ngăn ', locations.shelf) as location_name from books inner join locations on books.location_id = locations.id where title like ?";
                vars = new String[]{"%" + name_id + "%"};
            }
            String[] fields = new String[]{"id", "title", "location_name"};
            ArrayList<MyObject> books = DB.getData(sql, vars, fields);
            req.setAttribute("books", books);
            req.getRequestDispatcher("/views/admin/find-book-location.jsp").forward(req, resp);
        }
    }
}
