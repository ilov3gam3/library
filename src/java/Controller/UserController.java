package Controller;

import Database.DB;
import Database.MyObject;
import Init.Config;
import Init.SendMail;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class UserController {
    private static final int WORK_FACTOR = 12;

    @WebServlet("/register")
    public static class RegisterController extends HttpServlet {
        public static boolean checkEmail(String email) {
            return DB.getData("select * from users where email = ?", new String[]{email}, new String[]{"id"}).size() == 0;
        }

        public static boolean checkEmailExcept(String email, String id) {
            return DB.getData("select * from users where email = ? and id != ?", new String[]{email, id}, new String[]{"id"}).size() == 0;
        }

        public static boolean checkPhone(String phone) {
            return DB.getData("select * from users where phone = ?", new String[]{phone}, new String[]{"id"}).size() == 0;
        }

        public static boolean checkPhoneExcept(String phone, String id) {
            return DB.getData("select * from users where phone = ? and id != ?", new String[]{phone, id}, new String[]{"id"}).size() == 0;
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            if (req.getSession().getAttribute("form") != null) {
                MyObject form = (MyObject) req.getSession().getAttribute("form");
                req.setAttribute("form", form);
                req.getSession().removeAttribute("form");
            }
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            boolean check_email = checkEmail(email);
            boolean check_phone = checkPhone(phone);
            String gender = req.getParameter("gender");
            String name = req.getParameter("name");
            String password = req.getParameter("password");
            String re_password = req.getParameter("re_password");
            String dob = req.getParameter("dob");
            String address = req.getParameter("address");
            MyObject form = new MyObject();
            form.email = email;
            form.phone = phone;
            form.gender = gender;
            form.password = password;
            form.re_password = re_password;
            form.dob = dob;
            form.address = address;
            form.name = name;
            boolean register_success = true;
            String context = req.getContextPath();
            if (check_email && check_phone) {
                String uuid = UUID.randomUUID().toString();
                String tail_url = "/active?uuid=" + uuid;
                if (re_password.equals(password)) {
                    String sql = "insert into users(name, email, phone, avatar, dob, address, password, is_verify, is_admin, is_block, uuid, gender, account_balance) values (?,?,?,?,?,?,?,?,?,?,?,?, 0)";
                    password = BCrypt.hashpw(password, BCrypt.gensalt(WORK_FACTOR));
                    String[] vars = {name, email, phone, "/assets/default-avatar.webp", dob, address, password, "false", "false", "false", uuid, gender};
                    boolean check = DB.executeUpdate(sql, vars);
                    if (check) {
                        ExecutorService executorService = Executors.newSingleThreadExecutor();
                        executorService.submit(() -> {
                            try {
                                String url = Config.app_url + context + tail_url;
                                String html = "<h1>Nhấn vào <a href='" + url + "'> đây </a> để kích hoạt tải khoản của bạn</h1>";
                                SendMail.send(email, "Kích hoạt tài khoản", html);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        });
                        executorService.shutdown();
                        req.getSession().setAttribute("mess", "success|Đăng kí thành công, vui lòng kiểm tra email.");
                    } else {
                        register_success = false;
                        req.getSession().setAttribute("mess", "error|Đăng kí không thành công, vui lòng liên hệ admin.");
                    }
                } else {
                    req.getSession().setAttribute("form", form);
                    req.getSession().setAttribute("mess", "warning|Mật khẩu và nhập lại mật khẩu không trùng nhau.");
                    register_success = false;
                }
            } else {
                req.getSession().setAttribute("form", form);
                if (!check_email && !check_phone) {
                    req.getSession().setAttribute("mess", "warning|Số điện thoại và email đã được sử dụng.");
                    register_success = false;
                } else {
                    if (!check_email) {
                        req.getSession().setAttribute("mess", "warning|Email đã được sử dụng.");
                        register_success = false;
                    }
                    if (!check_phone) {
                        req.getSession().setAttribute("mess", "warning|Số điện thoại đã được sử dụng.");
                        register_success = false;
                    }
                }
            }
            resp.sendRedirect(req.getContextPath() + (register_success ? "/login" : "/register"));
        }
    }

    @WebServlet("/login")
    public static class LoginController extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            if (req.getSession().getAttribute("email") != null) {
                req.setAttribute("email", req.getSession().getAttribute("email"));
                req.getSession().removeAttribute("email");
            }
            if (req.getSession().getAttribute("password") != null) {
                req.setAttribute("password", req.getSession().getAttribute("password"));
                req.getSession().removeAttribute("password");
            }
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            Date currentDate = Calendar.getInstance().getTime();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sql = "select users.*, vip_subscriptions.id as vip_sub_id from users left join vip_subscriptions on users.id = vip_subscriptions.user_id and vip_subscriptions.from_date < ? and to_date > ? where email = ?";
            String[] vars = {dateFormat.format(currentDate), dateFormat.format(currentDate), email};
            String[] fields = new String[]{"id", "name", "email", "phone", "avatar", "dob", "address", "password", "is_verify", "is_admin", "is_block", "uuid", "gender", "is_admin", "account_balance", "vip_sub_id"};
            ArrayList<MyObject> user = DB.getData(sql, vars, fields);
            boolean login_status;
            if (user.size() == 0) {
                req.getSession().setAttribute("mess", "error|Tài khoản hoặc mật khẩu không đúng.");
                login_status = false;
            } else if (user.get(0).is_block.equals("1")) {
                req.getSession().setAttribute("mess", "warning|Tài khoản của bạn đã bị khóa.");
                login_status = false;
            } else if (user.get(0).is_verify.equals("0")) {
                req.getSession().setAttribute("mess", "warning|Bạn chưa xác nhận email của bạn, vui lòng kiểm tra email.");
                login_status = false;
            } else if (!BCrypt.checkpw(password, user.get(0).password)) {
                req.getSession().setAttribute("mess", "error|Tài khoản hoặc mật khẩu không đúng.");
                login_status = false;
            } else {
                login_status = true;
                req.getSession().setAttribute("mess", "success|Đăng nhập thành công.");
            }
            if (login_status) {
                req.getSession().setAttribute("login", user.get(0));
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                req.getSession().setAttribute("email", email);
                req.getSession().setAttribute("password", password);
                resp.sendRedirect(req.getContextPath() + "/login");
            }
        }
    }

    @WebServlet("/active")
    public static class Active extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String uuid = req.getParameter("uuid");
            boolean check_verify = DB.executeUpdate("update users set is_verify = 'true', uuid = '' where uuid = ?", new String[]{uuid});
            if (check_verify) {
                req.setAttribute("message_success", "Tài khoản của bạn được xác nhận thành công.");
            } else {
                req.setAttribute("message_error", "Đường dẫn không tồn tại hoặc đã có lỗi xảy ra.");
            }
            req.getRequestDispatcher("/views/auth/verify.jsp").forward(req, resp);
        }
    }

    @WebServlet("/user/profile")
    public static class Profile extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            boolean check_email = RegisterController.checkEmailExcept(email, user.id);
            boolean check_phone = RegisterController.checkPhoneExcept(phone, user.id);
            String gender = req.getParameter("gender").equals("true") ? "1" : "0";
            String name = req.getParameter("name");
            String dob = req.getParameter("dob");
            String address = req.getParameter("address");
            if (check_email && check_phone) {
                String sql = "update users set name = ?, email = ?, phone = ?, dob = ?, address = ?, gender = ? where id = ?";
                String[] vars = new String[]{name, email, phone, dob, address, gender, user.id};
                boolean check = DB.executeUpdate(sql, vars);
                if (check) {
                    req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
                    user.name = name;
                    user.email = email;
                    user.phone = phone;
                    user.dob = dob;
                    user.address = address;
                    user.gender = gender;
                    req.getSession().setAttribute("login", user);
                } else {
                    req.getSession().setAttribute("mess", "error|Đã có lỗi xảy ra.");
                }
            } else {
                if (!check_email && !check_phone) {
                    req.getSession().setAttribute("mess", "warning|Số điện thoại và email đã được sử dụng.");
                } else {
                    if (!check_email) {
                        req.getSession().setAttribute("mess", "warning|Email đã được sử dụng.");
                    }
                    if (!check_phone) {
                        req.getSession().setAttribute("mess", "warning|Số điện thoại đã được sử dụng.");
                    }
                }
            }
            resp.sendRedirect(req.getRequestURI());
        }
    }

    @WebServlet("/user/change-password")
    public static class ChangePasswor extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/user/change-password.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String current_pass = req.getParameter("current_pass");
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            boolean update_success = true;
            if (BCrypt.checkpw(current_pass, user.password)) {
                String new_pass = req.getParameter("new_pass");
                String re_new_pass = req.getParameter("re_new_pass");
                if (new_pass.equals(re_new_pass)) {
                    new_pass = BCrypt.hashpw(new_pass, BCrypt.gensalt(WORK_FACTOR));
                    String sql = "update users set password = ? where id = ?";
                    String[] vars = new String[]{new_pass, user.id};
                    boolean check = DB.executeUpdate(sql, vars);
                    if (check) {
                        req.getSession().setAttribute("mess", "success|Cập nhật mật khẩu thành xông.");
                    } else {
                        update_success = false;
                        req.getSession().setAttribute("mess", "error|Đã có lỗi xảy ra.");
                    }
                } else {
                    update_success = false;
                    req.getSession().setAttribute("mess", "warning|Mật khẩu mới và nhập lại mật khẩu mới không trùng nhau.");
                }
            } else {
                update_success = false;
                req.getSession().setAttribute("mess", "warning|Mật khẩu hiện tại không đúng.");
            }
            resp.sendRedirect(req.getContextPath() + (update_success ? "/user/profile" : "/user/change-password"));
        }
    }

    @WebServlet("/user/change-avatar")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 30,      // 10 MB
            maxRequestSize = 1024 * 1024 * 30  // 10 MB
    )
    public static class ChangeAvatar extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                Part filePart = req.getPart("image");
                String fileName = HandleFileUpload.getFileName(filePart);
                assert fileName != null;
                String newFileName = HandleFileUpload.generateUniqueFileName(fileName);
                String uploadDir = req.getServletContext().getRealPath("/") + "uploads";
                Path filePath = Paths.get(uploadDir, newFileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                MyObject user = (MyObject) req.getSession().getAttribute("login");
                String sql = "update users set avatar = ? where id = ?";
                boolean check_update = DB.executeUpdate(sql, new String[]{"/uploads/" + newFileName, user.id});
                if (check_update) {
                    req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
                    user.avatar = "/uploads/" + newFileName;
                    req.getSession().setAttribute("login", user);
                } else {
                    req.getSession().setAttribute("mess", "error|Cập nhật thất bại");
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("mess", "error|Cập nhật thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/user/profile");
        }
    }

    @WebServlet("/forgot-password")
    public static class ForgotPassword extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String email = req.getParameter("email");
            String uuid = UUID.randomUUID().toString();
            String sql = "update users set uuid = ? where email = ?";
            String[] vars = new String[]{uuid, email};
            DB.executeUpdate(sql, vars);
            ExecutorService executorService = Executors.newSingleThreadExecutor();
            executorService.submit(() -> {
                try {
                    String url = Config.app_url + req.getContextPath() + "/reset-password?uuid=" + uuid;
                    String html = "<h1>Nhấn vào <a href='" + url + "'> đây </a> để đặt lại mật khẩu của bạn</h1>";
                    SendMail.send(email, "Lấy lại mật khẩu.", html);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
            executorService.shutdown();
            req.setAttribute("check_mail", true);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        }
    }

    @WebServlet("/reset-password")
    public static class ResetPassword extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String uuid = req.getParameter("uuid");
            String sql = "select * from users where uuid = ?";
            boolean check = DB.getData(sql, new String[]{uuid}, new String[]{"id"}).size() == 1;
            if (check) {
                String password = req.getParameter("password");
                String re_password = req.getParameter("re_password");
                if (password.equals(re_password)) {
                    password = BCrypt.hashpw(password, BCrypt.gensalt(WORK_FACTOR));
                    boolean check_reset = DB.executeUpdate("update users set password = ?, uuid = '' where uuid = ?", new String[]{password, uuid});
                    if (check_reset) {
                        req.setAttribute("message", "success|Đổi mật khẩu thành công.");
                    } else {
                        req.setAttribute("mess", "error|Đã có lỗi xảy ra.");
                    }
                } else {
                    req.setAttribute("mess", "warning|Nhập lại mật khẩu không trùng khớp.");
                }
            } else {
                req.setAttribute("message", "Đường dẫn không tồn tại hoặc đã hết hạn.");
            }
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }

    @WebServlet("/logout")
    public static class Logout extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getSession().removeAttribute("login");
            resp.sendRedirect(req.getContextPath());
        }
    }

    @WebServlet("/login-google")
    public static class LoginGoogle extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            JSONObject json = new JSONObject();
            String code = req.getParameter("code");
            json.put("code", code);
            json.put("client_id", Config.client_id);
            json.put("client_secret", Config.client_secret);
            json.put("redirect_uri", Config.redirect_uri);
            json.put("grant_type", "authorization_code");
            try {
                HttpClient httpClient = HttpClients.createDefault();
                HttpPost httpPost = new HttpPost(new URI("https://oauth2.googleapis.com/token"));
                httpPost.setHeader("Content-Type", "application/json");
                httpPost.setEntity(new StringEntity(json.toString(), ContentType.APPLICATION_JSON));
                HttpResponse response = httpClient.execute(httpPost);
                HttpEntity responseEntity = response.getEntity();
                if (responseEntity != null) {
                    String responseString = EntityUtils.toString(responseEntity);
                    ObjectMapper objectMapper = new ObjectMapper();
                    try {
                        JsonNode jsonResponse = objectMapper.readTree(responseString);
                        String access_token = jsonResponse.get("access_token").asText();
                        HttpClient httpGetClient = HttpClients.createDefault();
                        HttpGet httpGet = new HttpGet("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + access_token);
                        try {
                            HttpResponse responseFromGet = httpGetClient.execute(httpGet);
                            HttpEntity responseEntityFromGet = responseFromGet.getEntity();
                            if (responseEntityFromGet != null) {
                                String responseStringFromGet = EntityUtils.toString(responseEntityFromGet);
                                objectMapper = new ObjectMapper();
                                jsonResponse = objectMapper.readTree(responseStringFromGet);
                                String email = jsonResponse.get("email").asText();
                                Date currentDate = Calendar.getInstance().getTime();
                                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                ArrayList<MyObject> user = DB.getData("select users.*, vip_subscriptions.id as vip_sub_id from users left join vip_subscriptions on users.id = vip_subscriptions.user_id and vip_subscriptions.from_date < ? and to_date > ? where email = ?", new String[]{dateFormat.format(currentDate), dateFormat.format(currentDate), email}, new String[]{"id", "name", "email", "phone", "avatar", "dob", "address", "password", "is_verify", "is_admin", "is_block", "uuid", "gender", "account_balance", "vip_sub_id"});
                                if (user.size() == 0) {
                                    String name = jsonResponse.get("name").asText();
                                    String avatar = jsonResponse.get("picture").asText();
                                    MyObject form = new MyObject();
                                    form.email = email;
                                    form.name = name;
                                    form.avatar = avatar;
                                    req.setAttribute("form", form);
                                    req.getRequestDispatcher("/views/auth/add-more-info.jsp").forward(req, resp);
                                } else {
                                    req.getSession().setAttribute("login", user.get(0));
                                    req.getSession().setAttribute("mess", "success|Đăng nhập thành công");
                                    resp.sendRedirect(req.getContextPath());
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @WebServlet("/add-more-info")
    public static class AddMoreInfo extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            if (req.getSession().getAttribute("form") != null) {
                MyObject form = (MyObject) req.getSession().getAttribute("form");
                req.setAttribute("form", form);
                req.getRequestDispatcher("/views/auth/add-more-info.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath());
            }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String password = req.getParameter("password");
            String re_password = req.getParameter("re_password");
            String dob = req.getParameter("dob");
            String address = req.getParameter("address");
            String email = req.getParameter("email");
            String name = req.getParameter("name");
            String avatar = req.getParameter("avatar");
            MyObject form = new MyObject();
            form.phone = phone;
            form.gender = gender;
            form.password = password;
            form.re_password = re_password;
            form.dob = dob;
            form.address = address;
            form.email = email;
            form.name = name;
            form.avatar = avatar;
            boolean check_phone = RegisterController.checkPhone(phone);
            boolean register_success = true;
            if (check_phone) {
                if (password.equals(re_password)) {
                    String sql = "insert into users(name, email, phone,  dob, address, password, is_verify, is_admin, is_block, avatar, gender, account_balance) values (?,?,?,?,?,?,?,?,?,?,?, 0)";
                    password = BCrypt.hashpw(password, BCrypt.gensalt(WORK_FACTOR));
                    String[] vars = {name, email, phone, dob, address, password, "true", "false", "false", avatar, gender};
                    boolean check = DB.executeUpdate(sql, vars);
                    if (check) {
                        Date currentDate = Calendar.getInstance().getTime();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        MyObject user = DB.getData("select users.*, vip_subscriptions.id as vip_sub_id from users left join vip_subscriptions on users.id = vip_subscriptions.user_id and vip_subscriptions.from_date < ? and to_date > ? where email = ?", new String[]{dateFormat.format(currentDate), dateFormat.format(currentDate), email}, new String[]{"id", "name", "email", "phone", "avatar", "dob", "address", "password", "is_verify", "is_admin", "is_block", "uuid", "gender", "account_balance", "vip_sub_id"}).get(0);
                        req.getSession().setAttribute("login", user);
                        req.getSession().setAttribute("mess", "success|Đăng kí thành công.");
                    } else {
                        register_success = false;
                        req.getSession().setAttribute("mess", "warning|Đã có lỗi xảy ra");
                    }
                } else {
                    register_success = false;
                    req.getSession().setAttribute("mess", "warning|Mật khẩu không trùng khớp.");
                }
            } else {
                register_success = false;
                req.getSession().setAttribute("mess", "warning|Số điện thoại đã được sử dụng");
            }
            if (register_success) {
                resp.sendRedirect(req.getContextPath());
            } else {
                req.getSession().setAttribute("form", form);
                resp.sendRedirect(req.getContextPath() + "/add-more-info");
            }
        }
    }

    @WebServlet("/user/upgrade-vip")
    public static class UpgradeVip extends HttpServlet {
        static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        public static Date[] calculateDatesAfterXMonths(int x) {
            Calendar calendar = Calendar.getInstance();
            Date currentDate = calendar.getTime();
            calendar.add(Calendar.MONTH, x);
            calendar.add(Calendar.DAY_OF_MONTH, -1); // Subtract 1 day to get the last day of the month
            Date futureDate = calendar.getTime();
            return new Date[]{currentDate, futureDate};
        }
        public static boolean checkVipSub(String user_id, Date date){
            String sql = "select * from vip_subscriptions where from_date < ? and to_date > ? and user_id = ?";
            ArrayList<MyObject> a = DB.getData(sql, new String[]{dateFormat.format(date),dateFormat.format(date), user_id}, new String[]{"id"});
            if (a.size() == 0){
                return true;
            }
            return false;
        }
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/user/upgrade-vip.jsp").forward(req, resp);
        }
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            int months = Integer.parseInt(req.getParameter("months"));
            System.out.println(months);
            Date[] dates = calculateDatesAfterXMonths(months);
            if (checkVipSub(user.id, dates[0])){
                int discount = 0;
                boolean stop = false;
                switch (months){
                    case 1:{
                        discount = 0;
                        break;
                    }
                    case 3:{
                        discount = 10;
                        break;
                    }
                    case 6:{
                        discount = 15;
                        break;
                    }
                    case 9:{
                        discount = 20;
                        break;
                    }
                    case 12:{
                        discount = 25;
                        break;
                    }
                    default:{
                        req.getSession().setAttribute("mess", "Số tháng không hợp lệ.");
                        stop = true;
                        resp.sendRedirect(req.getContextPath() + "/user/upgrade-vip");
                    }
                }
                if (!stop){
                    System.out.println(discount);
                    float money = (float)months * (float)Config.vip_amount * (1 - (float)discount/100);
                    String sql = "insert into vip_subscriptions(user_id, from_date, to_date, price, discount) values (?, ?, ?, ?, ?);update users set account_balance = account_balance - ? where id = ?";
                    String[] vars = new String[]{user.id, dateFormat.format(dates[0]),dateFormat.format(dates[1]), String.valueOf((int) money), String.valueOf(discount), String.valueOf((int) money), user.id};
                    boolean check = DB.executeUpdate(sql, vars);
                    if (check){
                        user.account_balance = String.valueOf(Integer.parseInt(user.account_balance) - (int) money);
                        user.vip_sub_id = "0";
                        req.getSession().setAttribute("login", user);
                        req.getSession().setAttribute("mess", "success|Nâng cấp tài khoản thành công");
                    } else {
                        req.getSession().setAttribute("mess", "error|Nâng cấp tài khoản không thành công");
                    }
                    resp.sendRedirect(req.getContextPath() + "/user/upgrade-vip");
                }
            } else {
                req.getSession().setAttribute("mess", "warning|Chưa thể gia hạn vip do thời hạn vip của bạn chưa hết.");
                resp.sendRedirect(req.getContextPath() + "/user/upgrade-vip");
            }
        }
    }

    @WebServlet("/admin/user")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 10,      // 10 MB
            maxRequestSize = 1024 * 1024 * 10  // 10 MB
    )
    public static class GetUser extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select * from users";
            String[] var = new String[]{"id", "name", "email", "phone", "avatar", "dob", "address", "is_verify", "is_admin", "is_block", "gender"};
            ArrayList<MyObject> user = DB.getData(sql, var);
            req.setAttribute("users", user);
            req.getRequestDispatcher("/views/admin/user.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String userId = req.getParameter("id");
            boolean isBlock = Boolean.parseBoolean(req.getParameter("block"));

            String sql = "update users set is_block=? where id =?";
            String[] vars = new String[]{String.valueOf(isBlock), userId};
            DB.executeUpdate(sql, vars);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        }
    }

    @WebServlet("/admin/user/block")
    public static class UserBlock extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String user_id = req.getParameter("user_id");
            String status = req.getParameter("status");
            String sql = "update users set is_block = ? where id = ?";
            String[] vars = new String[]{status, user_id};
            boolean check = DB.executeUpdate(sql, vars);
            com.google.gson.JsonObject job = new JsonObject();
            if (check) {
                job.addProperty("status", true);
                job.addProperty("message", "Cập nhật thành công.");
            } else {
                job.addProperty("status", false);
                job.addProperty("message", "Cập nhật không thành công.");
            }
            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(job));
        }
    }

    @WebServlet("/admin/user/verify")
    public static class UserVerify extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String user_id = req.getParameter("user_id");
            String status = req.getParameter("status");
            String sql = "update users set is_verify = ? where id = ?";
            String[] vars = new String[]{status, user_id};
            boolean check = DB.executeUpdate(sql, vars);
            com.google.gson.JsonObject job = new JsonObject();
            if (check) {
                job.addProperty("status", true);
                job.addProperty("message", "Cập nhật thành công.");
            } else {
                job.addProperty("status", false);
                job.addProperty("message", "Cập nhật không thành công.");
            }
            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(job));
        }
    }


    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024, // 1 MB
            maxFileSize = 1024 * 1024 * 30,      // 10 MB
            maxRequestSize = 1024 * 1024 * 30  // 10 MB
    )
    @WebServlet("/admin/user/update")
    public static class UpdateUser extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String update_id = req.getParameter("update_id");
            String update_name = req.getParameter("update_name");
            String update_email = req.getParameter("update_email");
            String update_phone = req.getParameter("update_phone");
            String update_gender = req.getParameter("update_gender");
            String update_dob = req.getParameter("update_dob");
            String update_address = req.getParameter("update_address");
            String password = req.getParameter("update_password").equals("") ? "" : BCrypt.hashpw(req.getParameter("update_password"), BCrypt.gensalt(WORK_FACTOR));

            Part filePart = req.getPart("update_avatar");
            String newFileName = "";
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = HandleFileUpload.getFileName(filePart);
                newFileName = HandleFileUpload.generateUniqueFileName(fileName);
                String uploadDir = req.getServletContext().getRealPath("/") + "uploads";
                Path filePath = Paths.get(uploadDir, newFileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                newFileName = "/uploads/" + newFileName;
            } else {
                newFileName = "";
            }

            String sql = "update users set name = ?, email = ?, phone = ?, avatar = IIF(? = '', avatar, ?), dob = ?, address = ?, password = IIF(? = '', password, ?), gender = ? where id = ?";
            String[] vars = new String[]{update_name, update_email, update_phone, newFileName, newFileName, update_dob, update_address, password, password, update_gender, update_id};
            boolean check = DB.executeUpdate(sql, vars);
            if (check) {
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Cập nhật không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        }
    }

    @WebServlet("/admin/vip_subs")
    public static class AdminViewVipSubs extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select vip_subscriptions.*, users.name as user_name from vip_subscriptions inner join users on vip_subscriptions.user_id = users.id";
            ArrayList<MyObject> vips = DB.getData(sql, new String[]{"id", "user_id", "from_date", "to_date", "price", "discount", "user_name"});
            req.setAttribute("vips", vips);
            int amount = 0;
            for (int i = 0; i < vips.size(); i++) {
                amount += Integer.parseInt(vips.get(i).price);
            }
            req.setAttribute("amount", amount);
            req.getRequestDispatcher("/views/admin/vip_subs.jsp").forward(req, resp);
        }
    }
}
