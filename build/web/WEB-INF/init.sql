-- IF OBJECT_ID('favorites', 'U') IS NOT NULL drop table favorites
-- IF OBJECT_ID('payments', 'U') IS NOT NULL drop table payments
-- IF OBJECT_ID('rentals', 'U') IS NOT NULL drop table rentals
-- IF OBJECT_ID('reviews', 'U') IS NOT NULL drop table reviews
-- IF OBJECT_ID('books', 'U') IS NOT NULL drop table books
-- IF OBJECT_ID('authors', 'U') IS NOT NULL drop table authors
-- IF OBJECT_ID('genre', 'U') IS NOT NULL drop table genre
-- IF OBJECT_ID('locations', 'U') IS NOT NULL drop table locations
-- IF OBJECT_ID('vip_subscriptions', 'U') IS NOT NULL drop table vip_subscriptions
-- IF OBJECT_ID('users', 'U') IS NOT NULL drop table users
create table authors
(
    id          int identity
        primary key,
    name        nvarchar(255),
    dob         date,
    nationality nvarchar(255),
    biography   nvarchar(max),
    image       nvarchar(1000)
)
create table genre
(
    id          int identity
        primary key,
    name        nvarchar(255),
    description nvarchar(max)
)
create table locations
(
    id        int identity
        primary key,
    floor     nvarchar(100),
    room      nvarchar(100),
    bookshelf nvarchar(100),
    shelf     nvarchar(100)
)
create table books
(
    id          int identity
        primary key,
    title       nvarchar(255),
    description nvarchar(max),
    author_id   int
        references authors,
    genre_id    int
        references genre,
    quantity    int,
    renting     int,
    price       int,
    cover_image nvarchar(255),
    soft_file   nvarchar(255),
    available   bit,
    location_id int
        references locations,
    year        nvarchar(100)
)
create table users
(
    id              int identity
        primary key,
    name            nvarchar(255),
    email           varchar(255),
    phone           varchar(255),
    avatar          nvarchar(255),
    dob             date,
    address         nvarchar(255),
    password        nvarchar(255),
    is_verify       bit,
    is_admin bit,
    is_block        bit,
    uuid            nvarchar(255),
    gender          bit,
    account_balance int
)
create table vip_subscriptions
(
    id                    int primary key identity (1,1),
    user_id               int foreign key references users (id),
    from_date        datetime,
    to_date datetime,
    price                 int,
    discount nvarchar(50),
)
create table favorites
(
    id      int identity
        primary key,
    user_id int
        references users,
    book_id int
        references books,
    note    nvarchar(max),
    unique (user_id, book_id)
)
create table payments
(
    id                    int identity
        primary key,
    user_id               int
        references users,
    amount                int,
    vnp_BankCode          varchar(50),
    vnp_TransactionNo     varchar(50),
    vnp_TransactionStatus varchar(50),
    vnp_OrderInfo         varchar(50),
    vnp_TxnRef            varchar(50),
    vnp_CardType          varchar(50),
    vnp_BankTranNo        varchar(50),
    create_order_at       datetime,
    paid_at               datetime
)
create table rentals
(
    id            int identity
        primary key,
    book_id       int
        references books,
    user_id       int
        references users,
    from_date     date,
    to_date       date,
    price         int,
    received_book bit,
    returned_book bit,
    created_at    datetime,
    status        int default 0
)
create table reviews
(
    id         int identity
        primary key,
    book_id    int
        references books,
    user_id    int
        references users,
    content    nvarchar(max),
    rating     int,
    created_at datetime
)
create table late_returns(
                             id         int identity primary key,
                             rental_id int foreign key references rentals(id),
                             penalty_fee_date date,
                             amount int,
)
SET IDENTITY_INSERT authors ON;
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (1, N'William Shakespeare', N'1564-04-26', N'British Indian Ocean Territory', N'William Shakespeare là một nhà văn và nhà viết kịch Anh, được coi là nhà văn vĩ đại nhất của Anh và là nhà viết kịch đi trước thời đại. Ông còn được vinh danh là nhà thơ tiêu biểu của nước Anh và là `Thi sĩ của dòng sông Avon`.', N'/uploads/6d2ee971-f599-48ee-9492-69d291ad11f3.png');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (2, N'Ernest Hemingway', N'1899-07-21', N'United States', N'Ernest Miller Hemingway là một tiểu thuyết gia người Mỹ, nhà văn viết truyện ngắn và là một nhà báo. Ông là một phần của cộng đồng những người xa xứ ở Paris trong thập niên 20 của thế kỷ XX và là một trong những cựu quân nhân trong Chiến tranh thế giới I, sau đó được biết đến qua `Thế hệ đã mất`', N'/uploads/8dd1ccf5-0a6d-46db-9c27-5b5927af0c84.jpg');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (3, N'Lev Nikolayevich Tolstoy', N'1828-09-09', N'Russian Federation', N'Bá tước Lev Nikolayevich Tolstoy, là một tiểu thuyết gia người Nga, nhà triết học, người theo chủ nghĩa hoà bình, nhà cải cách giáo dục, người ăn chay, người theo chủ nghĩa vô chính phủ, tín hữu Cơ Đốc giáo, nhà tư tưởng đạo đức và là một thành viên có ảnh hưởng của gia đình Tolstoy.', N'/uploads/682a2235-fddd-421b-988a-4c831c131541.jpg');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (4, N'Anh em nhà Grimm', N'1785-01-04', N'Germany', N'Hai anh em nhà Grimm: Jacob, Wilhelm là hai trong số chín người con của ông Philipp Wilhelm Grimm, sinh ra tại một thành phố thuộc bang Hessen nước Đức. Khi bước sang tuổi 20, hai anh em nhà Grimm đã nghiên cứu ngôn ngữ học và văn học dân gian. Hai anh em nhà Grimm đã đạt được thành tựu vô cùng to lớn trong lĩnh vực truyện cổ tích và dân gian. Những câu chuyện do anh em nhà Grimm kể lại thông qua cách kể của mình như Nàng Bạch Tuyết và bảy chú lùn, Công chúa ngủ trong rừng, Cô bé Lọ Lem, Cô bé quàng khăn đỏ, Bà chúa tuyết, Chú bé chăn cừu, Hansel và Gretel...đã trở nên vô cùng nổi tiếng và trường tồn qua thời gian. Những tác phẩm này có sức ảnh hưởng vô cùng sâu sắc tới văn hóa, truyện cổ tích của nhiều nước khác, được chuyển thể nhiều lần thành những bộ phim và cho tới nay vẫn được lưu trữ trong kho tàng Truyện cổ Grimm được các bậc cha mẹ kể lại cho con cái.', N'/uploads/ca816898-d355-4bf3-83fb-7939c00286b6.jpg');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (5, N'Charles Dickens', N'1812-07-02', N'British Indian Ocean Territory', N'Charles Dickens sinh ra tại một vùng ngoại ô thành phố Postmouth, thuộc vùng Hampshire nước Anh, trong một gia đình công chức bình dân. Ông đã từng làm thư ký tốc ký cho một tòa án, rồi phóng viên cho tờ Morning Star và cũng là người sáng lập ra tờ Daily News năm 1846. Charles Dickens bắt đầu viết văn từ năm 1833 và tên tuổi của ông nhanh chóng lan tỏa khắp Châu Âu. Ông được coi như là tiểu thuyết gia vĩ đại nhất viết bằng tiếng Anh và là nhà văn nổi tiếng nhất thời đại Nữ hoàng Victoria.', N'/uploads/7291346d-406d-46a7-92cb-736b679b66b8.jpg');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (6, N'Victor Hugo', N'1802-02-26', N'France', N'Trong lịch sử văn học Pháp, Victor Hugo chiếm một vị trí vô cùng quan trọng. Ông vừa là một nhà thơ, nhà văn, nhà viết kịch, vừa là một nhà tư tưởng, chính trị gia tiêu biểu ở Pháp trong thế kỷ 19. Các tác phẩm của ông trải dài và rộng ở nhiều lĩnh vực khác nhau như thơ trữ tình, kịch lãng mạn, tiểu thuyết xã hội và tiểu thuyết lãng mạn... Ông cũng là một nhân vật đại diện cho Chủ nghĩa lãng mạn ở Châu Âu. Các tác phẩm của Victor Hugo mang đậm tính `Nghệ thuật vị nhân sinh` với việc khắc họa rõ nét đời sống xã hội lúc bấy giờ, thể hiện tính đạo đức, tình yêu con người cũng như tư tưởng chính trị cấp tiến, dân chủ để chống lại tư tưởng phong kiến, bảo hoàng lúc bấy giờ đang phủ khắp nước Pháp và Châu Âu. Nhờ những đóng góp của mình không chỉ trong văn học mà còn trong nghệ thuật, tư tưởng, chính trị, Victor Hugo trở thành gương mặt nổi bật của thời ấy, khi qua đời ông đã được nhà nước cử lễ Quốc tang và thi hài ông được đưa vào điện Pantheon danh giá.', N'/uploads/0d013085-77fe-4eec-9dbf-aad8beee1285.jpg');
INSERT INTO authors (id, name, dob, nationality, biography, image) VALUES (7, N'Mark Twain', N'1835-11-30', N'United States', N'Nếu như trong thế kỷ 19, ở Pháp có Victor Hugo, ở Anh có Charles Dickens, ở Nga có Lev Tolstoy thì ở Mỹ - quốc gia sinh sau đẻ muộn nhưng sau đó lại trở thành cường quốc hàng đầu thế giới về văn học, Mark Twain chính là vì tinh tú đầu tiên của nền văn học nước này. Mark Twain với phong cách trào phúng, châm biếm, lối văn đàm thoại, khả năng miêu tả tâm lý xã hội khéo léo, đã góp phần đấu tranh chống lại những hủ tục mê tín, tư tưởng phong kiến, áp bức thống trị và nhất là những chính sách phân biệt chủng tộc đối với người da đen ở Mỹ trong thời đại chế độ nô lệ ở nước này.', N'/uploads/f63b7280-ac9b-47a4-96bc-9d3b7d72d165.jpg');
SET IDENTITY_INSERT authors OFF;
-- ======================================================================================
SET IDENTITY_INSERT genre ON;
INSERT INTO genre (id, name, description) VALUES (1, N'Tiểu thuyết', N'Các câu chuyện hư cấu dài với cốt truyện phức tạp, nhân vật và bối cảnh.');
INSERT INTO genre (id, name, description) VALUES (2, N'Truyện ngắn', N'Các câu chuyện hư cấu ngắn với ít nhân vật và cốt truyện đơn giản hơn tiểu thuyết.');
INSERT INTO genre (id, name, description) VALUES (3, N'Thơ', N'Các bài thơ bày tỏ cảm xúc, suy nghĩ của tác giả thông qua ngôn từ đặc sắc.');
INSERT INTO genre (id, name, description) VALUES (4, N'Kịch', N'Các vở kịch viết để diễn trên sân khấu, tập trung vào đối thoại và hành động của nhân vật.');
INSERT INTO genre (id, name, description) VALUES (5, N'Hồi ký', N'Các câu chuyện về cuộc đời của một người nổi tiếng hay nhân vật lịch sử.');
INSERT INTO genre (id, name, description) VALUES (6, N'Truyện tranh', N'Các câu chuyện được thể hiện bằng hình ảnh và chữ viết.');
INSERT INTO genre (id, name, description) VALUES (7, N'Sách giáo khoa', N'Sách dùng để học tập trong nhà trường.');
INSERT INTO genre (id, name, description) VALUES (8, N'Từ điển', N'Giải thích ý nghĩa của các từ ngữ.');
INSERT INTO genre (id, name, description) VALUES (9, N'Tôn giáo', N'Các sách về tôn giáo, kinh thánh.');
INSERT INTO genre (id, name, description) VALUES (10, N'Triết học', N'Các sách bàn về triết học, nhân sinh quan.');
INSERT INTO genre (id, name, description) VALUES (11, N'Lịch sử', N'Ghi chép các sự kiện lịch sử.');
INSERT INTO genre (id, name, description) VALUES (12, N'Chính trị', N'Các sách về lý luận, chính sách chính trị.');
INSERT INTO genre (id, name, description) VALUES (13, N'Kinh tế', N'Các sách về lý thuyết, chính sách kinh tế.');
INSERT INTO genre (id, name, description) VALUES (14, N'Khoa học', N'Các sách về khoa học tự nhiên và kỹ thuật.');
INSERT INTO genre (id, name, description) VALUES (15, N'Nghệ thuật', N'Sách về lịch sử, lý thuyết nghệ thuật.');
INSERT INTO genre (id, name, description) VALUES (16, N'Du ký', N'Mô tả các chuyến đi, khám phá của tác giả.');
INSERT INTO genre (id, name, description) VALUES (17, N'Hướng dẫn', N'Hướng dẫn cách làm một việc gì đó.');
INSERT INTO genre (id, name, description) VALUES (18, N'Tiểu sử', N'Cuc đời của một nhân vật nổi tiếng do người khác viết.');
INSERT INTO genre (id, name, description) VALUES (19, N'Kỹ năng', N'Các sách dạy kỹ năng mềm, kỹ năng sống.');
INSERT INTO genre (id, name, description) VALUES (20, N'Sách thiếu nhi', N'Sách viết cho lứa tuổi thiếu nhi.');
SET IDENTITY_INSERT genre OFF;
-- ======================================================================================
SET IDENTITY_INSERT locations ON;
INSERT INTO locations (id, floor, room, bookshelf, shelf) VALUES (1, N'1', N'101', N'1', N'1');
INSERT INTO locations (id, floor, room, bookshelf, shelf) VALUES (2, N'1', N'101', N'1', N'2');
INSERT INTO locations (id, floor, room, bookshelf, shelf) VALUES (3, N'1', N'101', N'2', N'1');
INSERT INTO locations (id, floor, room, bookshelf, shelf) VALUES (4, N'1', N'101', N'2', N'2');
SET IDENTITY_INSERT locations OFF;
-- ======================================================================================
SET IDENTITY_INSERT books ON;
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (1, N'Romeo và Juliet', N'Romeo và Juliet là vở bi kịch về một mối tình lãng mạn mà oan trái, dựa trên sự việc có thật thời Trung Cổ. Tại thành Verona, hai dòng họ nhà Montague và Capulet có mối hận thù lâu đời. Thế nhưng trong một buổi dạ hội, Romeo và Juliet đã phải lòng nhau và yêu nhau sâu đậm. Mối hận thù giữa hai nhà càng tăng cao khi anh họ của Juliet giết chết người bạn thân của Romeo, Romeo trả thù và bị đày ải khỏi Verona. Trong khi đó, Juliet bị ép gả cho bá tước Paris. Để trốn đám cưới, Juliet uống một loại thuốc giả chết và nhờ một tu sĩ báo cho Romeo trở về cứu mình từ hầm mộ. Thế nhưng trước khi tu sĩ kịp báo cho Romeo, chàng đã nghe được tin về cái chết của Juliet và trở về giết Paris rồi tự sát. Khi Juliet tỉnh dậy, Romeo đã chết, quá đau đớn, nàng rút dao tự vẫn.', 1, 1, 30, 0, 3000, N'/uploads/56deb252-dabd-464c-b114-ca22bbbb1bfa.jpg', N'/pdfs/94bf775e-ef9f-4735-a658-38a27001e7cc.pdf', 1, 1, N'1978');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (2, N'Hamlet', N'Hamlet (/ˈhæmlɪt/, tên đầy đủ là The Tragedy of Hamlet, Prince of Denmark) là vở bi - hài kịch của nhà văn, nhà soạn kịch người Anh William Shakespeare, có lẽ được sáng tác vào năm 1601. Cốt truyện của tác phẩm có nguồn gốc từ thể loại Saga (truyện dân gian) thời đại Trung cổ. Trên sân khấu Anh thời Phục Hưng đã từng diễn nhiều vở kịch cùng tên của nhiều tác giả. Người ta cho rằng Shakespeare sáng tác Hamlet có thể dựa trên Bi kịch lịch sử của François Belleforest hoặc trên vở kịch nay đã bị thất lạc Hamlet của Thomas Kyd (1558-1594), một vở kịch được gọi tên là Ur-Hamlet với ý nghĩa là vở `Hamlet nguyên bản`.', 1, 1, 40, 0, 4000, N'/uploads/b56bb3f6-379a-43ee-81fd-e939ffded569.jpg', N'/pdfs/05b5b6c3-ff74-4131-80ad-73c0ed047f3f.pdf', 1, 2, N'1928');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (3, N'The Old Man And The Sea (Ông già và biển cả)', N'Bắt đầu ở đây. Bạn bắt đầu ở đây bởi vì, khi bạn đọc cuốn sách này lần đầu tiên, bạn còn quá trẻ. Hồi đó, bạn lo lắng về việc đạt điểm A trong bài văn của mình và bạn sẽ học đại học ở đâu và bạn sẽ mời ai để đi dạ hội cùng. Lần này, đừng tìm kiếm chủ đề hay suy nghĩ về ý nghĩa của màu sắc - như chính Hemingway đã nói, biển cả là biển cả, cá mập cũng chỉ là cá mập, và, “Tất cả những chủ nghĩa tượng trưng mà người ta nói đều là tồi tệ.” Hãy để hoàn cảnh của người đánh cá già, người tìm thấy người bạn thủy chung một thời của mình bị xé nát thành hư vô, vang vọng trong đầu bạn. Hãy biết rằng đó là cuốn tiểu thuyết cuối cùng của Hemingway được xuất bản trong cả cuộc đời ông, và hãy tận hưởng tác phẩm cuối cùng ấy. Mọi người khen ngợi, từ các nhà phê bình cho đến các đối thủ cạnh tranh, nó được chính Hemingway coi là tác phẩm hay nhất của ông. Đó là một cuốn sách ngắn, và xuất hiện trong nhiều danh sách tiểu thuyết ở  mọi thời đại (mặc dù thực tế rằng là về mặt kỹ thuật nó là một tiểu thuyết ngắn). Nhưng như một lời giới thiệu về Hemingway, có rất ít tác phẩm của ông đòi hỏi một chút cam kết, cũng như không có nhiều tác phẩm sẽ ở lại với bạn lâu như vậy.', 2, 2, 25, 0, 2500, N'/uploads/095ea21c-ba42-4220-8ad4-359678cfc508.jpg', N'/pdfs/a41ee367-9edc-448e-85ef-359fb4acdba1.pdf', 1, 1, N'1888');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (4, N'A Farewell To Arms (Giã từ vũ khí)', N'Tiếp cận cuốn tiểu thuyết Hemingway đầu tiên mà không sợ sệt, run rẩy. Arms được xuất bản vào năm 1929, là nỗ lực năm hai của nhà văn, và nó kể về một người lính Mỹ AWOL phục vụ trong quân đội Ý và cô y tá phong cách Florence Nightingale khi họ chạy trốn khỏi cuộc đại chiến. Tác phẩm có những cuộc vượt ngục liều lỉnh, trượt tuyết trên núi Alps và một cái kết bi thảm, và nó cũng vay mượn từ cuốn tự truyện của chính tác giả, mặc dù đã được thêu dệt và chỉnh sửa rất nhiều. Nó như một trong những tác phẩm quan trọng nhất trong chiến tranh thế giới thứ nhất, và điều đó không hề bị giảm bớt lại, nhưng nó còn thể hiện một nhà văn tự tin hơn, giành chiến thắng, mở rộng ra ảnh hưởng văn học và hư cấu của mình. Tóm lại, đừng gọi đó là sự trở lại. Nó đã được dựng lên và chuyển thể và chuyển thể thành phim, và nếu có một cuốn sách nào đó của Hemingway có thể được coi là đọc trên bãi biển (mặc dù phải thừa nhận rằng nó vẫn chứa đầy tính nghiêm trang), thì đây chính là nó. Hãy gói nó bên cạnh khăn tắm và kem chống nắng của bạn.', 2, 2, 36, 0, 5400, N'/uploads/171e13d8-c321-45f8-9fcc-c02cc39f57a0.jpg', N'/pdfs/c2c6df1a-5a5f-43ef-9686-2e072c80413b.pdf', 1, 2, N'1426');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (5, N'Anna Karenina', N'Anna Karenina là một tiểu thuyết của nhà văn Nga Lev Nikolayevich Tolstoy, được đăng tải nhiều kỳ trên tờ báo Ruskii Vestnik từ năm 1873 đến năm 1877 trước khi xuất bản thành ấn phẩm hoàn chỉnh. Anna Karenina được xem như là một đỉnh cao của tiểu thuyết hiện thực.', 3, 1, 35, 0, 1800, N'/uploads/1f2209ee-23b4-4c49-b83b-72648982ee66.jpg', N'/pdfs/de432079-0aa5-44ae-bf84-69eb4e61edd9.pdf', 1, 3, N'1877');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (6, N'The War and Peace (Chiến tranh và hòa bình)', N'Lev Tolstoy cũng đã từng băn khoăn: `Thú thật tôi hoàn toàn không biết một trăm năm sau liệu có ai đọc các tác phẩm của tôi không...` (Thư ông gửi cho một nhà nghiên cứu người Anh ngày 27-12-1878). Lenin đã giải đáp nỗi băn khoăn đó: `Tolstoy đã mất rồi và nước Nga trước cách mạng đã chìm vào dĩ vãng. Nhưng trong di sản của ông có cái không chìm vào dĩ vãng, có cái thuộc về tương lai. Di sản đó, giai cấp vô sản Nga đón lấy và nghiên cứu nó.`Chiến Tranh Và Hòa Bình của Tolstoy chính là loại tác phẩm thuộc về tương lai. Năm 1960, một nhà văn Pháp đã nói rất hay về sức sống của tác phẩm Tolstoy: `Khi đọc lại Chiến Tranh Và Hòa Bình tôi cảm thấy trước mắt tôi không phải là một giai đoạn đã qua mà là bí mật đã mất`.', 3, 5, 32, 0, 3500, N'/uploads/4759d9c3-9da0-40ed-b144-4699b710cf92.jpg', N'/pdfs/b683ea1f-ffca-44e6-97d6-8f50832bcc8a.pdf', 1, 4, N'1798');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (7, N'Những Cuộc Phiêu Lưu Của Tom Sawyer', N'Những cuộc phiêu lưu của Tom Sawyer là một quyển tiểu thuyết được nhà văn Mark Twain viết với bút pháp độc đáo, miêu tả tâm lý, cử chỉ, hành động của một chú bé sống tại một ngôi làng nghèo bên sông Mississippi. Tác giả đã miêu tả xuất sắc tính cách, tâm lý, hành động của chú bé thông minh, nghịch ngợm nhưng dũng cảm và có một tấm lòng nhân hậu giàu tình nghĩa. Cuốn tiểu thuyết đã được chuyển thể thành trên dưới 20 bộ phim của nhiều quốc gia, trong đó có ba bản phim nổi bật của Mỹ vào các năm 1938, 1973, 1995 (tựa đề Tom and Huck).', 7, 2, 13, 0, 2700, N'/uploads/349019f0-ac2a-467e-977f-4f139d01f4b6.jpg', N'/pdfs/ec1707c3-9158-425f-9374-7ca909714862.pdf', 1, 2, N'1280');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (8, N'Những Cuộc Phiêu Lưu Của Huckleberry Finn', N'Những cuộc phiêu lưu của Huckleberry Finn (tiếng Anh: Adventures of Huckleberry Finn) là tiểu thuyết được xuất bản năm 1884 của nhà văn Mỹ Mark Twain. Nó được viết trong ngôi thứ nhất, là một trong những tiểu thuyết Mỹ đầu tiên dùng phương ngữ để viết. Những cuộc phiêu lưu của Huckleberry Finn thường được đánh giá là một trong những tác phẩm vĩ đại nhất trong nền văn học Hoa Kỳ. Huckleberry Finn được xem là cuốn tiếp theo của quyển Những cuộc phiêu lưu của Tom Sawyer, xuất bản năm 1876. Nhân vật kể chuyện, Huckleberry Finn, là bạn của Tom Sawyer. Câu chuyện kể về những cuộc phiêu lưu của Huckleberry Finn trên dòng sông Mississippi với người bạn là Jim, một nô lệ đang chạy thoát. Quyển sách miêu tả những cảnh vật trên dòng sông và châm biếm những quan điểm ở miền Nam Hoa Kỳ thời tiền chiến, đặc biệt là quan điểm kỳ thị chủng tộc. Hình ảnh Huck và Jim trên chiếc bè chạy theo dòng sông, đi đến tự do, là một trong những hình ảnh bất hủ nhất trong văn học Hoa Kỳ.', 7, 2, 19, 0, 2400, N'/uploads/26dae3e7-5da0-481e-9593-c7f4ec817800.webp', N'/pdfs/4ffa67b9-cc00-4d3a-b98a-6e78851c6e19.pdf', 1, 2, N'1980');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (9, N'Great Expectations (Ước vọng lớn lao, 1861)', N'Great Expectations là một tiểu thuyết giáo dục nhân cách. Tác phẩm là sự mô tả quá trình trưởng thành của cậu bé mồ côi Pip. Cuốn tiểu thuyết được đăng hàng kì trên tạp chí văn học All the Year Round từ ngày 1/12/1860 đến tháng 8/1961. Vào tháng 10/1861, nhà xuất bản Chapman and Hall đã xuất bản thành một bộ tiểu thuyết gồm 3 tập. Great Expectations là cuốn tiểu thuyết sinh động, phản ánh các sự kiện, các mối quan tâm của nhà văn và mối quan hệ giữa xã hội và con người. Great Expectations quy tụ đầy đủ các sắc thái trong nền văn hóa bình dân: một quý bà Havisham giàu có nhưng rất khó tính và tàn nhẫn, một cô gái Estella xinh đẹp nhưng lạnh lùng, một người thợ rèn Joe tốt bụng và hào phóng, một bác Pumblechook hiền lành… Xuyên suốt câu chuyện, chủ đề chủ yếu mà nhà văn muốn đề cập tới là: giàu có và nghèo đói, tình yêu và sự cự tuyệt, và chiến thắng cuối cùng của cái thiện trước cái ác. Tác phẩm trở nên phổ biến và được giảng dạy ở các trường học tại Anh. Great Expectations được dịch ra rất nhiều ngôn ngữ và được chuyển thể thành phim.', 1, 1, 23, 0, 1900, N'/uploads/f32b7360-3e76-47b7-b3d9-91869ed19529.jpg', N'/pdfs/9cb94a2d-34e0-4fac-ae1e-326d802dda6d.pdf', 1, 3, N'1280');
INSERT INTO books (id, title, description, author_id, genre_id, quantity, renting, price, cover_image, soft_file, available, location_id, year) VALUES (10, N'Những người khốn khổ', N'Những người khốn khổ là tiểu thuyết của văn hào Pháp Victor Hugo, được xuất bản năm 1862. Tác phẩm được đánh giá là một trong những tiểu thuyết nổi tiếng nhất của nền văn học thế giới thế kỷ 19.', 6, 1, 28, 0, 4000, N'/uploads/9d9bfc24-eab5-45f1-ad34-687e72b6c95d.jpg', N'/pdfs/878889d8-d74e-4892-8ce4-2cbb795ac27f.pdf', 1, 2, N'1862');
SET IDENTITY_INSERT books OFF;
-- ======================================================================================
SET IDENTITY_INSERT users ON;
INSERT INTO users (id, name, email, phone, avatar, dob, address, password, is_verify, is_admin, is_block, uuid, gender, account_balance) VALUES (1, N'Quang Minh Trần', N'tranquangminh116@gmail.com', N'+84763416782', N'https://lh3.googleusercontent.com/a/ACg8ocIt8XtJpqw1ntOyeAJF8XyacXD7_UdomYCc7OyZ4mN5vg=s96-c', N'2002-08-05', N'123 y lan nguyen phi', N'$2a$12$a79eEY5V5r/XozbHXF33J.P7nKU12qNCOoxAGcELc8Ms4THBxS1JS', 1, 1, 0, null, 0, 0);
INSERT INTO users (id, name, email, phone, avatar, dob, address, password, is_verify, is_admin, is_block, uuid, gender, account_balance) VALUES (2, N'quangminh tran', N'tranquangminh050802@gmail.com', N'+84763416789', N'/uploads/dcfa7ea4-d298-4567-9f02-46934f03e91f.png', N'2003-06-08', N'123 Ỷ Lan Nguyên Phi, Quận Hải Châu, Thành Phố Đằ Nẵng.updated', N'$2a$12$hTiw6UVYXyNlb5EUWxOLAuWh6vnR.4/TsQT0b76DMT6M2iOUJUl96', 1, 0, 0, null, 0, 96000);
INSERT INTO users (id, name, email, phone, avatar, dob, address, password, is_verify, is_admin, is_block, uuid, gender, account_balance) VALUES (3, N'Quang Minh Trần', N'minhtqde160524@fpt.edu.vn', N'+84763916782', N'/assets/default-avatar.webp', N'2023-10-11', N'123 y lan nguyen phi', N'$2a$12$1qdQpEMmWl.2w4Rk3fn5y.mjMIn.r1eUVXOKxnbfdmkx.S7r5iik2', 0, 0, 0, N'bcb9e293-14b5-4530-92d4-49d62e9c9472', 1, 0);
SET IDENTITY_INSERT users OFF;
-- ======================================================================================
