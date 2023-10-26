package Controller;

import Database.DB;
import Database.MyObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class HomeController {
    @WebServlet("/index")
    public static class Home extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/home.jsp").forward(req,resp);
        }
    }

    @WebServlet("/database")
    public static class DatabaseManagement extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String catalog = null;
            try {
                catalog = DB.getConnection().getCatalog();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            req.setAttribute("catalog", catalog);
            req.getRequestDispatcher("/views/database.jsp").forward(req, resp);
        }
    }

    @WebServlet("/recreate-db")
    public static class RecreateDB extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sqlFilePath = getServletContext().getRealPath("/WEB-INF/init.sql");
            StringBuilder sqlContent = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new FileReader(sqlFilePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sqlContent.append(line).append("\n");
                }
            }
            boolean check = DB.executeUpdate(String.valueOf(sqlContent));
            if (check){
                req.getSession().setAttribute("mess", "success|Tạo thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Tạo không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/");
            /*String sql = "IF OBJECT_ID('favorites', 'U') IS NOT NULL drop table favorites\n" +
                    "\n" +
                    "IF OBJECT_ID('payments', 'U') IS NOT NULL drop table payments\n" +
                    "\n" +
                    "IF OBJECT_ID('rentals', 'U') IS NOT NULL drop table rentals\n" +
                    "\n" +
                    "IF OBJECT_ID('reviews', 'U') IS NOT NULL drop table reviews\n" +
                    "\n" +
                    "IF OBJECT_ID('books', 'U') IS NOT NULL drop table books\n" +
                    "\n" +
                    "IF OBJECT_ID('authors', 'U') IS NOT NULL drop table authors\n" +
                    "\n" +
                    "IF OBJECT_ID('genre', 'U') IS NOT NULL drop table genre\n" +
                    "\n" +
                    "IF OBJECT_ID('locations', 'U') IS NOT NULL drop table locations\n" +
                    "\n" +
                    "IF OBJECT_ID('users', 'U') IS NOT NULL drop table users\n" +
                    "\n" +
                    "IF OBJECT_ID('roles', 'U') IS NOT NULL drop table roles\n" +
                    "\n" +
                    "create table roles\n" +
                    "(\n" +
                    "    id   int primary key identity,\n" +
                    "    name nvarchar(255),\n" +
                    ")\n" +
                    "insert into roles(name)\n" +
                    "values ('user')\n" +
                    "insert into roles(name)\n" +
                    "values ('vip')\n" +
                    "insert into roles(name)\n" +
                    "values ('admin')\n" +
                    "create table users\n" +
                    "(\n" +
                    "    id              int primary key identity (1,1),\n" +
                    "    name            nvarchar(255),\n" +
                    "    email           varchar(255),\n" +
                    "    phone           varchar(255),\n" +
                    "    avatar          nvarchar(255),\n" +
                    "    dob             date,\n" +
                    "    address         nvarchar(255),\n" +
                    "    password        nvarchar(255),\n" +
                    "    is_verify       bit,\n" +
                    "    role_id         int references roles (id),\n" +
                    "    is_block        bit,\n" +
                    "    uuid            nvarchar(255),\n" +
                    "    gender          bit,\n" +
                    "    account_balance int\n" +
                    ")\n" +
                    "insert into users(name, email, phone, avatar, dob, address, password, is_verify, role_id, is_block, uuid, gender,\n" +
                    "                  account_balance)\n" +
                    "values (N'Quang Minh Trần', 'tranquangminh116@gmail.com', '+84763416782',\n" +
                    "        'https://lh3.googleusercontent.com/a/ACg8ocIt8XtJpqw1ntOyeAJF8XyacXD7_UdomYCc7OyZ4mN5vg=s96-c', '2002-08-05',\n" +
                    "        '123 y lan nguyen phi', '$2a$12$a79eEY5V5r/XozbHXF33J.P7nKU12qNCOoxAGcELc8Ms4THBxS1JS', 'true', '3', 'false',\n" +
                    "        null, 'true', '0')\n" +
                    "insert into users(name, email, phone, avatar, dob, address, password, is_verify, role_id, is_block, uuid, gender,\n" +
                    "                  account_balance)\n" +
                    "values (N'quangminh tran', 'tranquangminh050802@gmail.com', '+84763416782',\n" +
                    "        'https://lh3.googleusercontent.com/a/ACg8ocKc8rrWNpUt-tJuC0jmdgRj54faxF1Yfkc-hGwFlE24=s96-c', '2003-05-08',\n" +
                    "        N'123 Ỷ Lan Nguyên Phi, Quận Hải Châu, Thành Phố Đằ Nẵng.',\n" +
                    "        '$2a$12$hTiw6UVYXyNlb5EUWxOLAuWh6vnR.4/TsQT0b76DMT6M2iOUJUl96', 'true', '1', 'false', null, 'true', '0')\n" +
                    "create table genre\n" +
                    "(\n" +
                    "    id          int primary key identity (1,1),\n" +
                    "    name        nvarchar(255),\n" +
                    "    description nvarchar(max),\n" +
                    ")\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Tiểu thuyết',\n" +
                    "        N'Các câu chuyện hư cấu dài với cốt truyện phức tạp, nhân vật và bối cảnh.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Truyện ngắn',\n" +
                    "        N'Các câu chuyện hư cấu ngắn với ít nhân vật và cốt truyện đơn giản hơn tiểu thuyết.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Thơ',\n" +
                    "        N'Các bài thơ bày tỏ cảm xúc, suy nghĩ của tác giả thông qua ngôn từ đặc sắc.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Kịch',\n" +
                    "        N'Các vở kịch viết để diễn trên sân khấu, tập trung vào đối thoại và hành động của nhân vật.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Hồi ký',\n" +
                    "        N'Các câu chuyện về cuộc đời của một người nổi tiếng hay nhân vật lịch sử.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Truyện tranh',\n" +
                    "        N'Các câu chuyện được thể hiện bằng hình ảnh và chữ viết.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Sách giáo khoa', N'Sách dùng để học tập trong nhà trường.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Từ điển', N'Giải thích ý nghĩa của các từ ngữ.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Tôn giáo', N'Các sách về tôn giáo, kinh thánh.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Triết học', N'Các sách bàn về triết học, nhân sinh quan.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Lịch sử', N'Ghi chép các sự kiện lịch sử.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Chính trị', N'Các sách về lý luận, chính sách chính trị.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Kinh tế', N'Các sách về lý thuyết, chính sách kinh tế.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Khoa học', N'Các sách về khoa học tự nhiên và kỹ thuật.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Nghệ thuật', N'Sách về lịch sử, lý thuyết nghệ thuật.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Du ký', N'Mô tả các chuyến đi, khám phá của tác giả.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Hướng dẫn', N'Hướng dẫn cách làm một việc gì đó.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Tiểu sử', N'Cuc đời của một nhân vật nổi tiếng do người khác viết.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Kỹ năng', N'Các sách dạy kỹ năng mềm, kỹ năng sống.')\n" +
                    "insert into genre(name, description)\n" +
                    "values (N'Sách thiếu nhi', N'Sách viết cho lứa tuổi thiếu nhi.')\n" +
                    "create table authors\n" +
                    "(\n" +
                    "    id          int primary key identity (1,1),\n" +
                    "    name        nvarchar(255),\n" +
                    "    dob         date,\n" +
                    "    nationality nvarchar(255),\n" +
                    "    biography   nvarchar(max),\n" +
                    "    image       nvarchar(1000)\n" +
                    ")\n" +
                    "create table locations\n" +
                    "(\n" +
                    "    id        int primary key identity (1,1),\n" +
                    "    floor     nvarchar(100),\n" +
                    "    room      nvarchar(100),\n" +
                    "    bookshelf nvarchar(100),\n" +
                    "    shelf     nvarchar(100),\n" +
                    ")\n" +
                    "\n" +
                    "create table books\n" +
                    "(\n" +
                    "    id          int primary key identity (1,1),\n" +
                    "    title       nvarchar(255),\n" +
                    "    description nvarchar(max),\n" +
                    "    author_id   int foreign key references authors (id),\n" +
                    "    genre_id    int foreign key references genre (id),\n" +
                    "    quantity    int,\n" +
                    "    renting     int,\n" +
                    "    price       int,\n" +
                    "    cover_image nvarchar(255),\n" +
                    "    soft_file   nvarchar(255),\n" +
                    "    available   bit,\n" +
                    "    location_id int foreign key references locations (id)\n" +
                    ")\n" +
                    "create table favorites\n" +
                    "(\n" +
                    "    id      int primary key identity (1,1),\n" +
                    "    user_id int foreign key references users (id),\n" +
                    "    book_id int foreign key references books (id),\n" +
                    "    note    nvarchar(max),\n" +
                    "    UNIQUE (user_id, book_id)\n" +
                    ")\n" +
                    "create table payments\n" +
                    "(\n" +
                    "    id                    int primary key identity (1,1),\n" +
                    "    user_id               int foreign key references users (id),\n" +
                    "    amount                int,\n" +
                    "    vnp_BankCode          varchar(50),\n" +
                    "    vnp_TransactionNo     varchar(50),\n" +
                    "    vnp_TransactionStatus varchar(50),\n" +
                    "    vnp_OrderInfo         varchar(50),\n" +
                    "    vnp_TxnRef            varchar(50),\n" +
                    "    vnp_CardType          varchar(50),\n" +
                    "    vnp_BankTranNo        varchar(50),\n" +
                    "    create_order_at       datetime,\n" +
                    "    paid_at               datetime\n" +
                    ")\n" +
                    "\n" +
                    "\n" +
                    "create table reviews\n" +
                    "(\n" +
                    "    id         int primary key identity (1,1),\n" +
                    "    book_id    int foreign key references books (id),\n" +
                    "    user_id    int foreign key references users (id),\n" +
                    "    comment    nvarchar(max),\n" +
                    "    rating     int,\n" +
                    "    created_at datetime\n" +
                    ")\n" +
                    "create table rentals\n" +
                    "(\n" +
                    "    id            int primary key identity (1,1),\n" +
                    "    book_id       int foreign key references books (id),\n" +
                    "    user_id       int foreign key references users (id),\n" +
                    "    from_date     date,\n" +
                    "    to_date       date,\n" +
                    "    price         int,\n" +
                    "    received_book bit,\n" +
                    "    returned_book bit,\n" +
                    "    created_at    datetime\n" +
                    ")" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Tiểu thuyết', N'Các câu chuyện hư cấu dài với cốt truyện phức tạp, nhân vật và bối cảnh.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Truyện ngắn', N'Các câu chuyện hư cấu ngắn với ít nhân vật và cốt truyện đơn giản hơn tiểu thuyết.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Thơ', N'Các bài thơ bày tỏ cảm xúc, suy nghĩ của tác giả thông qua ngôn từ đặc sắc.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Kịch', N'Các vở kịch viết để diễn trên sân khấu, tập trung vào đối thoại và hành động của nhân vật.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Hồi ký', N'Các câu chuyện về cuộc đời của một người nổi tiếng hay nhân vật lịch sử.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Truyện tranh', N'Các câu chuyện được thể hiện bằng hình ảnh và chữ viết.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Sách giáo khoa', N'Sách dùng để học tập trong nhà trường.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Từ điển', N'Giải thích ý nghĩa của các từ ngữ.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Tôn giáo', N'Các sách về tôn giáo, kinh thánh.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Triết học', N'Các sách bàn về triết học, nhân sinh quan.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Lịch sử', N'Ghi chép các sự kiện lịch sử.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Chính trị', N'Các sách về lý luận, chính sách chính trị.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Kinh tế', N'Các sách về lý thuyết, chính sách kinh tế.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Khoa học', N'Các sách về khoa học tự nhiên và kỹ thuật.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Nghệ thuật', N'Sách về lịch sử, lý thuyết nghệ thuật.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Du ký', N'Mô tả các chuyến đi, khám phá của tác giả.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Hướng dẫn', N'Hướng dẫn cách làm một việc gì đó.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Tiểu sử', N'Cuc đời của một nhân vật nổi tiếng do người khác viết.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Kỹ năng', N'Các sách dạy kỹ năng mềm, kỹ năng sống.');\n" +
                    "INSERT INTO library.dbo.genre (name, description) VALUES (N'Sách thiếu nhi', N'Sách viết cho lứa tuổi thiếu nhi.');" +
                    "INSERT INTO library.dbo.locations (floor, room, bookshelf, shelf) VALUES (N'1', N'101', N'1', N'1');\n" +
                    "INSERT INTO library.dbo.locations (floor, room, bookshelf, shelf) VALUES (N'1', N'101', N'1', N'2');\n" +
                    "INSERT INTO library.dbo.locations (floor, room, bookshelf, shelf) VALUES (N'1', N'101', N'2', N'1');\n" +
                    "INSERT INTO library.dbo.locations (floor, room, bookshelf, shelf) VALUES (N'1', N'101', N'2', N'2');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'William Shakespeare', N'1564-04-26', N'British Indian Ocean Territory', N'William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là \"Thi sĩ của dòng sông Avon\".', N'/uploads/6d2ee971-f599-48ee-9492-69d291ad11f3.png');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Ernest Hemingway', N'1899-07-21', N'United States', N'Ernest Miller Hemingway là một tiểu thuyết gia người Mỹ, nhà văn viết truyện ngắn và là một nhà báo. Ông là một phần của cộng đồng những người xa xứ ở Paris trong thập niên 20 của thế kỷ XX và là một trong những cựu quân nhân trong Chiến tranh thế giới I, sau đó được biết đến qua \"Thế hệ đã mất\"', N'/uploads/8dd1ccf5-0a6d-46db-9c27-5b5927af0c84.jpg');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Lev Nikolayevich Tolstoy', N'1828-09-09', N'Russian Federation', N'Bá tước Lev Nikolayevich Tolstoy, là một tiểu thuyết gia người Nga, nhà triết học, người theo chủ nghĩa hoà bình, nhà cải cách giáo dục, người ăn chay, người theo chủ nghĩa vô chính phủ, tín hữu Cơ Đốc giáo, nhà tư tưởng đạo đức và là một thành viên có ảnh hưởng của gia đình Tolstoy.', N'/uploads/682a2235-fddd-421b-988a-4c831c131541.jpg');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Anh em nhà Grimm', N'1785-01-04', N'Germany', N'Hai anh em nhà Grimm: Jacob, Wilhelm là hai trong số chín người con của ông Philipp Wilhelm Grimm, sinh ra tại một thành phố thuộc bang Hessen nước Đức. Khi bước sang tuổi 20, hai anh em nhà Grimm đã nghiên cứu ngôn ngữ học và văn học dân gian. Hai anh em nhà Grimm đã đạt được thành tựu vô cùng to lớn trong lĩnh vực truyện cổ tích và dân gian. Những câu chuyện do anh em nhà Grimm kể lại thông qua cách kể của mình như Nàng Bạch Tuyết và bảy chú lùn, Công chúa ngủ trong rừng, Cô bé Lọ Lem, Cô bé quàng khăn đỏ, Bà chúa tuyết, Chú bé chăn cừu, Hansel và Gretel...đã trở nên vô cùng nổi tiếng và trường tồn qua thời gian. Những tác phẩm này có sức ảnh hưởng vô cùng sâu sắc tới văn hóa, truyện cổ tích của nhiều nước khác, được chuyển thể nhiều lần thành những bộ phim và cho tới nay vẫn được lưu trữ trong kho tàng Truyện cổ Grimm được các bậc cha mẹ kể lại cho con cái.', N'/uploads/ca816898-d355-4bf3-83fb-7939c00286b6.jpg');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Charles Dickens', N'1812-07-02', N'British Indian Ocean Territory', N'Charles Dickens sinh ra tại một vùng ngoại ô thành phố Postmouth, thuộc vùng Hampshire nước Anh, trong một gia đình công chức bình dân. Ông đã từng làm thư ký tốc ký cho một tòa án, rồi phóng viên cho tờ Morning Star và cũng là người sáng lập ra tờ Daily News năm 1846. Charles Dickens bắt đầu viết văn từ năm 1833 và tên tuổi của ông nhanh chóng lan tỏa khắp Châu Âu. Ông được coi như là tiểu thuyết gia vĩ đại nhất viết bằng tiếng Anh và là nhà văn nổi tiếng nhất thời đại Nữ hoàng Victoria.', N'/uploads/7291346d-406d-46a7-92cb-736b679b66b8.jpg');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Victor Hugo', N'1802-02-26', N'France', N'Trong lịch sử văn học Pháp, Victor Hugo chiếm một vị trí vô cùng quan trọng. Ông vừa là một nhà thơ, nhà văn, nhà viết kịch, vừa là một nhà tư tưởng, chính trị gia tiêu biểu ở Pháp trong thế kỷ 19. Các tác phẩm của ông trải dài và rộng ở nhiều lĩnh vực khác nhau như thơ trữ tình, kịch lãng mạn, tiểu thuyết xã hội và tiểu thuyết lãng mạn... Ông cũng là một nhân vật đại diện cho Chủ nghĩa lãng mạn ở Châu Âu. Các tác phẩm của Victor Hugo mang đậm tính \"Nghệ thuật vị nhân sinh\" với việc khắc họa rõ nét đời sống xã hội lúc bấy giờ, thể hiện tính đạo đức, tình yêu con người cũng như tư tưởng chính trị cấp tiến, dân chủ để chống lại tư tưởng phong kiến, bảo hoàng lúc bấy giờ đang phủ khắp nước Pháp và Châu Âu. Nhờ những đóng góp của mình không chỉ trong văn học mà còn trong nghệ thuật, tư tưởng, chính trị, Victor Hugo trở thành gương mặt nổi bật của thời ấy, khi qua đời ông đã được nhà nước cử lễ Quốc tang và thi hài ông được đưa vào điện Pantheon danh giá.', N'/uploads/0d013085-77fe-4eec-9dbf-aad8beee1285.jpg');\n" +
                    "INSERT INTO library.dbo.authors (name, dob, nationality, biography, image) VALUES (N'Mark Twain', N'1835-11-30', N'United States', N'Nếu như trong thế kỷ 19, ở Pháp có Victor Hugo, ở Anh có Charles Dickens, ở Nga có Lev Tolstoy thì ở Mỹ - quốc gia sinh sau đẻ muộn nhưng sau đó lại trở thành cường quốc hàng đầu thế giới về văn học, Mark Twain chính là vì tinh tú đầu tiên của nền văn học nước này. Mark Twain với phong cách trào phúng, châm biếm, lối văn đàm thoại, khả năng miêu tả tâm lý xã hội khéo léo, đã góp phần đấu tranh chống lại những hủ tục mê tín, tư tưởng phong kiến, áp bức thống trị và nhất là những chính sách phân biệt chủng tộc đối với người da đen ở Mỹ trong thời đại chế độ nô lệ ở nước này.', N'/uploads/f63b7280-ac9b-47a4-96bc-9d3b7d72d165.jpg');\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Romeo và Juliet', N'Romeo và Juliet là vở bi kịch về một mối tình lãng mạn mà oan trái, dựa trên sự việc có thật thời Trung Cổ. Tại thành Verona, hai dòng họ nhà Montague và Capulet có mối hận thù lâu đời. Thế nhưng trong một buổi dạ hội, Romeo và Juliet đã phải lòng nhau và yêu nhau sâu đậm. Mối hận thù giữa hai nhà càng tăng cao khi anh họ của Juliet giết chết người bạn thân của Romeo, Romeo trả thù và bị đày ải khỏi Verona. Trong khi đó, Juliet bị ép gả cho bá tước Paris. Để trốn đám cưới, Juliet uống một loại thuốc giả chết và nhờ một tu sĩ báo cho Romeo trở về cứu mình từ hầm mộ. Thế nhưng trước khi tu sĩ kịp báo cho Romeo, chàng đã nghe được tin về cái chết của Juliet và trở về giết Paris rồi tự sát. Khi Juliet tỉnh dậy, Romeo đã chết, quá đau đớn, nàng rút dao tự vẫn.', 1, 1, 30, 1, 3000, N'/uploads/56deb252-dabd-464c-b114-ca22bbbb1bfa.jpg', N'/uploads/94bf775e-ef9f-4735-a658-38a27001e7cc.pdf', 1, 1);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Hamlet', N'Hamlet (/ˈhæmlɪt/, tên đầy đủ là The Tragedy of Hamlet, Prince of Denmark) là vở bi - hài kịch của nhà văn, nhà soạn kịch người Anh William Shakespeare, có lẽ được sáng tác vào năm 1601. Cốt truyện của tác phẩm có nguồn gốc từ thể loại Saga (truyện dân gian) thời đại Trung cổ. Trên sân khấu Anh thời Phục Hưng đã từng diễn nhiều vở kịch cùng tên của nhiều tác giả. Người ta cho rằng Shakespeare sáng tác Hamlet có thể dựa trên Bi kịch lịch sử của François Belleforest hoặc trên vở kịch nay đã bị thất lạc Hamlet của Thomas Kyd (1558-1594), một vở kịch được gọi tên là Ur-Hamlet với ý nghĩa là vở \"Hamlet nguyên bản\".', 1, 1, 40, 1, 4000, N'/uploads/b56bb3f6-379a-43ee-81fd-e939ffded569.jpg', N'/uploads/05b5b6c3-ff74-4131-80ad-73c0ed047f3f.pdf', 1, 2);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'The Old Man And The Sea (Ông già và biển cả)', N'Bắt đầu ở đây. Bạn bắt đầu ở đây bởi vì, khi bạn đọc cuốn sách này lần đầu tiên, bạn còn quá trẻ. Hồi đó, bạn lo lắng về việc đạt điểm A trong bài văn của mình và bạn sẽ học đại học ở đâu và bạn sẽ mời ai để đi dạ hội cùng. Lần này, đừng tìm kiếm chủ đề hay suy nghĩ về ý nghĩa của màu sắc - như chính Hemingway đã nói, biển cả là biển cả, cá mập cũng chỉ là cá mập, và, “Tất cả những chủ nghĩa tượng trưng mà người ta nói đều là tồi tệ.” Hãy để hoàn cảnh của người đánh cá già, người tìm thấy người bạn thủy chung một thời của mình bị xé nát thành hư vô, vang vọng trong đầu bạn. Hãy biết rằng đó là cuốn tiểu thuyết cuối cùng của Hemingway được xuất bản trong cả cuộc đời ông, và hãy tận hưởng tác phẩm cuối cùng ấy. Mọi người khen ngợi, từ các nhà phê bình cho đến các đối thủ cạnh tranh, nó được chính Hemingway coi là tác phẩm hay nhất của ông. Đó là một cuốn sách ngắn, và xuất hiện trong nhiều danh sách tiểu thuyết ở  mọi thời đại (mặc dù thực tế rằng là về mặt kỹ thuật nó là một tiểu thuyết ngắn). Nhưng như một lời giới thiệu về Hemingway, có rất ít tác phẩm của ông đòi hỏi một chút cam kết, cũng như không có nhiều tác phẩm sẽ ở lại với bạn lâu như vậy.', 2, 2, 25, 0, 2500, N'/uploads/095ea21c-ba42-4220-8ad4-359678cfc508.jpg', N'/uploads/a41ee367-9edc-448e-85ef-359fb4acdba1.pdf', 1, 1);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'A Farewell To Arms (Giã từ vũ khí)', N'Tiếp cận cuốn tiểu thuyết Hemingway đầu tiên mà không sợ sệt, run rẩy. Arms được xuất bản vào năm 1929, là nỗ lực năm hai của nhà văn, và nó kể về một người lính Mỹ AWOL phục vụ trong quân đội Ý và cô y tá phong cách Florence Nightingale khi họ chạy trốn khỏi cuộc đại chiến. Tác phẩm có những cuộc vượt ngục liều lỉnh, trượt tuyết trên núi Alps và một cái kết bi thảm, và nó cũng vay mượn từ cuốn tự truyện của chính tác giả, mặc dù đã được thêu dệt và chỉnh sửa rất nhiều. Nó như một trong những tác phẩm quan trọng nhất trong chiến tranh thế giới thứ nhất, và điều đó không hề bị giảm bớt lại, nhưng nó còn thể hiện một nhà văn tự tin hơn, giành chiến thắng, mở rộng ra ảnh hưởng văn học và hư cấu của mình. Tóm lại, đừng gọi đó là sự trở lại. Nó đã được dựng lên và chuyển thể và chuyển thể thành phim, và nếu có một cuốn sách nào đó của Hemingway có thể được coi là đọc trên bãi biển (mặc dù phải thừa nhận rằng nó vẫn chứa đầy tính nghiêm trang), thì đây chính là nó. Hãy gói nó bên cạnh khăn tắm và kem chống nắng của bạn.', 2, 2, 36, 0, 5400, N'/uploads/171e13d8-c321-45f8-9fcc-c02cc39f57a0.jpg', N'/uploads/c2c6df1a-5a5f-43ef-9686-2e072c80413b.pdf', 1, 2);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Anna Karenina', N'Anna Karenina là một tiểu thuyết của nhà văn Nga Lev Nikolayevich Tolstoy, được đăng tải nhiều kỳ trên tờ báo Ruskii Vestnik từ năm 1873 đến năm 1877 trước khi xuất bản thành ấn phẩm hoàn chỉnh. Anna Karenina được xem như là một đỉnh cao của tiểu thuyết hiện thực.', 3, 1, 35, 0, 1800, N'/uploads/1f2209ee-23b4-4c49-b83b-72648982ee66.jpg', N'/uploads/de432079-0aa5-44ae-bf84-69eb4e61edd9.pdf', 1, 3);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'The War and Peace (Chiến tranh và hòa bình)', N'Lev Tolstoy cũng đã từng băn khoăn: \"Thú thật tôi hoàn toàn không biết một trăm năm sau liệu có ai đọc các tác phẩm của tôi không...\" (Thư ông gửi cho một nhà nghiên cứu người Anh ngày 27-12-1878).Lenin đã giải đáp nỗi băn khoăn đó: \"Tolstoy đã mất rồi và nước Nga trước cách mạng đã chìm vào dĩ vãng. Nhưng trong di sản của ông có cái không chìm vào dĩ vãng, có cái thuộc về tương lai. Di sản đó, giai cấp vô sản Nga đón lấy và nghiên cứu nó. \"Chiến Tranh Và Hòa Bình của Tolstoy chính là loại tác phẩm thuộc về tương lai. Năm 1960, một nhà văn Pháp đã nói rất hay về sức sống của tác phẩm Tolstoy: \"Khi đọc lại Chiến Tranh Và Hòa Bình tôi cảm thấy trước mắt tôi không phải là một giai đoạn đã qua mà là bí mật đã mất\".', 3, 5, 32, 0, 3500, N'/uploads/4759d9c3-9da0-40ed-b144-4699b710cf92.jpg', N'/uploads/b683ea1f-ffca-44e6-97d6-8f50832bcc8a.pdf', 1, 4);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Những Cuộc Phiêu Lưu Của Tom Sawyer', N'Những cuộc phiêu lưu của Tom Sawyer là một quyển tiểu thuyết được nhà văn Mark Twain viết với bút pháp độc đáo, miêu tả tâm lý, cử chỉ, hành động của một chú bé sống tại một ngôi làng nghèo bên sông Mississippi. Tác giả đã miêu tả xuất sắc tính cách, tâm lý, hành động của chú bé thông minh, nghịch ngợm nhưng dũng cảm và có một tấm lòng nhân hậu giàu tình nghĩa. Cuốn tiểu thuyết đã được chuyển thể thành trên dưới 20 bộ phim của nhiều quốc gia, trong đó có ba bản phim nổi bật của Mỹ vào các năm 1938, 1973, 1995 (tựa đề Tom and Huck).', 7, 2, 13, 0, 2700, N'/uploads/349019f0-ac2a-467e-977f-4f139d01f4b6.jpg', N'/uploads/ec1707c3-9158-425f-9374-7ca909714862.pdf', 1, 2);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Những Cuộc Phiêu Lưu Của Huckleberry Finn', N'Những cuộc phiêu lưu của Huckleberry Finn (tiếng Anh: Adventures of Huckleberry Finn) là tiểu thuyết được xuất bản năm 1884 của nhà văn Mỹ Mark Twain. Nó được viết trong ngôi thứ nhất, là một trong những tiểu thuyết Mỹ đầu tiên dùng phương ngữ để viết. Những cuộc phiêu lưu của Huckleberry Finn thường được đánh giá là một trong những tác phẩm vĩ đại nhất trong nền văn học Hoa Kỳ. Huckleberry Finn được xem là cuốn tiếp theo của quyển Những cuộc phiêu lưu của Tom Sawyer, xuất bản năm 1876. Nhân vật kể chuyện, Huckleberry Finn, là bạn của Tom Sawyer. Câu chuyện kể về những cuộc phiêu lưu của Huckleberry Finn trên dòng sông Mississippi với người bạn là Jim, một nô lệ đang chạy thoát. Quyển sách miêu tả những cảnh vật trên dòng sông và châm biếm những quan điểm ở miền Nam Hoa Kỳ thời tiền chiến, đặc biệt là quan điểm kỳ thị chủng tộc. Hình ảnh Huck và Jim trên chiếc bè chạy theo dòng sông, đi đến tự do, là một trong những hình ảnh bất hủ nhất trong văn học Hoa Kỳ.', 7, 2, 19, 0, 2400, N'/uploads/26dae3e7-5da0-481e-9593-c7f4ec817800.webp', N'/uploads/4ffa67b9-cc00-4d3a-b98a-6e78851c6e19.pdf', 1, 2);\n" +
                    "INSERT INTO library.dbo.books (title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id) VALUES (N'Great Expectations (Ước vọng lớn lao, 1861)', N'Great Expectations là một tiểu thuyết giáo dục nhân cách. Tác phẩm là sự mô tả quá trình trưởng thành của cậu bé mồ côi Pip. Cuốn tiểu thuyết được đăng hàng kì trên tạp chí văn học All the Year Round từ ngày 1/12/1860 đến tháng 8/1961. Vào tháng 10/1861, nhà xuất bản Chapman and Hall đã xuất bản thành một bộ tiểu thuyết gồm 3 tập. Great Expectations là cuốn tiểu thuyết sinh động, phản ánh các sự kiện, các mối quan tâm của nhà văn và mối quan hệ giữa xã hội và con người. Great Expectations quy tụ đầy đủ các sắc thái trong nền văn hóa bình dân: một quý bà Havisham giàu có nhưng rất khó tính và tàn nhẫn, một cô gái Estella xinh đẹp nhưng lạnh lùng, một người thợ rèn Joe tốt bụng và hào phóng, một bác Pumblechook hiền lành… Xuyên suốt câu chuyện, chủ đề chủ yếu mà nhà văn muốn đề cập tới là: giàu có và nghèo đói, tình yêu và sự cự tuyệt, và chiến thắng cuối cùng của cái thiện trước cái ác. Tác phẩm trở nên phổ biến và được giảng dạy ở các trường học tại Anh. Great Expectations được dịch ra rất nhiều ngôn ngữ và được chuyển thể thành phim.', 1, 1, 23, 0, 1900, N'/uploads/f32b7360-3e76-47b7-b3d9-91869ed19529.jpg', N'/uploads/9cb94a2d-34e0-4fac-ae1e-326d802dda6d.pdf', 1, 3);\n";
            boolean check = DB.executeUpdate(sql);
            if (check){
                req.getSession().setAttribute("mess", "success|Tạo thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Tạo không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/");*/
        }
    }
}
