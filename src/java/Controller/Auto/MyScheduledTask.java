package Controller.Auto;

import Database.DB;
import Database.MyObject;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;

public class MyScheduledTask implements Runnable{
    @Override
    public void run() {
        System.out.println("run task");
        // hủy đơn không nhận sách
        LocalDate currentDate = LocalDate.now();
        LocalDate twoDaysBefore = currentDate.minusDays(2);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String twoDaysBeforeStr = twoDaysBefore.format(formatter);
        String sql = "update rentals set status = -1 where from_date <= ? and received_book = 'false' and where status = 0";
        String[] vars = new String[]{twoDaysBeforeStr};
        System.out.println(sql + "with para: " + Arrays.toString(vars));
        boolean check = DB.executeUpdate(sql, vars);



        // trừ tiền không trả sách
        sql = "select * from rentals where to_date < ? and returned_book = 'false' and received_book = 'true' and status = 0";
        vars = new String[]{formatter.format(currentDate)};
        String[] fields = new String[]{"id"};
        ArrayList<MyObject> late_rental_id = DB.getData(sql, vars, fields);
        if (late_rental_id.size()>0){
            sql = "";
            for (int i = 0; i < late_rental_id.size(); i++) {
                sql += "insert into late_returns(rental_id, penalty_fee_date, amount) values ("+late_rental_id.get(i).id+",'"+ formatter.format(currentDate) +"' ,(select books.price from rentals inner join books on rentals.book_id = books.id where rentals.id = "+ late_rental_id.get(i).id +"));";
            }
            DB.executeUpdate(sql);
            System.out.println(sql + "with para: " + Arrays.toString(vars));
        }
    }
}
