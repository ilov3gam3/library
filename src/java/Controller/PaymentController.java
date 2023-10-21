package Controller;

import Database.DB;
import Database.MyObject;
import Init.Config;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class PaymentController {
    @WebServlet("/user/recharge-balance")
    public static class ChargeBalance extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/user/charge-balance.jsp").forward(req, resp);
        }
    }

    @WebServlet("/user/get-vnpay-url")
    public static class GetVNPAYUrl extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            long amount = Integer.parseInt(req.getParameter("amount"))*100;
            String bankCode = req.getParameter("bankCode");
            String vnp_TxnRef = Config.getRandomNumber(8);
            String vnp_IpAddr = Config.getIpAddress(req);
            String vnp_TmnCode = Config.vnp_TmnCode;
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");

            if (bankCode != null && !bankCode.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            String vnp_OrderInfo = "nap tien|" + UUID.randomUUID();
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", orderType);

            String locate = req.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            SimpleDateFormat sqlFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    //Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    //Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
            com.google.gson.JsonObject job = new JsonObject();
            job.addProperty("code", "00");
            job.addProperty("message", "success");
            job.addProperty("data", paymentUrl);
            String sql = "insert into payments(user_id, amount, create_order_at, vnp_TxnRef, vnp_OrderInfo) values(?, ?, ?, ?, ?)";
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            try {
                String[] vars = new String[]{user.id, String.valueOf((int) amount).replaceFirst("00", ""), sqlFormatter.format(formatter.parse(vnp_CreateDate)), vnp_TxnRef, vnp_OrderInfo};
                DB.executeUpdate(sql, vars);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            Gson gson = new Gson();
            resp.getWriter().write(gson.toJson(job));
        }
    }


    @WebServlet("/user/vnpay-result")
    public static class VNPAYResult extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            SimpleDateFormat sqlFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            MyObject user = (MyObject) req.getSession().getAttribute("login");
            String amount = req.getParameter("vnp_Amount").replaceFirst("00", "");
            String paid_at = req.getParameter("vnp_PayDate");
            try {
                paid_at = sqlFormatter.format(formatter.parse(paid_at));
            } catch (ParseException e) {
                req.getSession().setAttribute("mess", "error|Đã có lỗi xảy ra.");
                resp.sendRedirect(req.getContextPath() + "/user/recharge-balance");
            }
            String vnp_TransactionStatus = req.getParameter("vnp_TransactionStatus");
            String vnp_TransactionNo = req.getParameter("vnp_TransactionNo");
            String vnp_BankTranNo = req.getParameter("vnp_BankTranNo");
            String vnp_CardType = req.getParameter("vnp_CardType");
            String vnp_BankCode = req.getParameter("vnp_BankCode");
            String vnp_OrderInfo = req.getParameter("vnp_OrderInfo");
            String vnp_TxnRef = req.getParameter("vnp_TxnRef");
            String sql = "update payments set vnp_BankCode = ?, vnp_TransactionNo = ?, vnp_TransactionStatus = ?, vnp_CardType = ?, vnp_BankTranNo = ?, paid_at = ? where user_id = ? and amount = ? and vnp_TxnRef = ? and vnp_OrderInfo = ?;update users set account_balance = account_balance + ? where id = ?;";
            String[] vars = new String[]{vnp_BankCode, vnp_TransactionNo, vnp_TransactionStatus, vnp_CardType, vnp_BankTranNo, paid_at, user.id, amount, vnp_TxnRef, vnp_OrderInfo, amount, user.id};
            user.account_balance = String.valueOf(Integer.parseInt(user.account_balance) + Integer.parseInt(amount));
            req.getSession().setAttribute("login", user);
            boolean check = DB.executeUpdate(sql, vars);
            if (check){
                if (vnp_TransactionStatus.equals("00")){
                    req.getSession().setAttribute("mess", "success|Nạp tiền thành công.");
                } else {
                    req.getSession().setAttribute("mess", "warning|Nạp tiền không thành công.");
                }
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
            }
            resp.sendRedirect(req.getContextPath() + "/user/recharge-balance");
            /*Map fields = new HashMap();
            for (Enumeration params = req.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(req.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = req.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            System.out.println("handel return url ===================");
            System.out.println("vnp_SecureHash : " + vnp_SecureHash);
            System.out.println("signValue : " + signValue);
            System.out.println("fields : " + fields);*/
        }
    }

    @WebServlet("/admin/payment")
    public static class ViewPayments extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String sql = "select payments.*, users.name as user_name from payments inner join users on users.id = payments.user_id";
            String[] fields = new String[]{"id", "user_id", "amount", "vnp_BankCode", "vnp_TransactionNo", "vnp_TransactionStatus", "vnp_OrderInfo", "vnp_TxnRef", "vnp_CardType", "vnp_BankTranNo", "create_order_at", "paid_at", "user_name"};
            ArrayList<MyObject> payments = DB.getData(sql, fields);
            req.setAttribute("payments", payments);
            req.getRequestDispatcher("/views/admin/payments.jsp").forward(req, resp);

        }
    }
}
