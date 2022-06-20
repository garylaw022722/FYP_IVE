/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author law
 */
public class DateGenerator {

    public int getYear(Timestamp time) {

        return time.getYear();
    }

    public Timestamp dateCal(Timestamp time, int period) {
        Timestamp times = time;
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(times.getTime());
        cal.add(Calendar.WEEK_OF_MONTH, period);
        times = new Timestamp(cal.getTime().getTime());

        return times;
    }

//    public boolean  isRecentBorrowingItem(){
    public boolean isRecentBorrowingItem(Timestamp itemDate) {
        int day = -7;//recent seven day
        boolean flag = false;
        long now = new Timestamp(System.currentTimeMillis()).getTime();

        if (now >= itemDate.getTime() && itemDate.getTime() >= addDay(now, day).getTime()) {
            flag = true;
        }

        return flag;
    }

    public Timestamp addDay(long now, int day) {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(now);
        cal.add(Calendar.DATE, day);/// minus the  seven date and accept negative number ;
        return new Timestamp(cal.getTime().getTime());
    }

    public boolean isOverdue(Timestamp itemDate) {
        boolean flag = false;
        long now = new Timestamp(System.currentTimeMillis()).getTime();
        if (now > itemDate.getTime()) {
            flag = true;
        }

        return flag;
    }

    public String getFormateDate(Date date) {

        Date  target =date;
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd ");
        
       return ft.format(target);
    }
    
  
    public String formatDate(Timestamp st ,String format){
       Date date=new Date(st.getTime());        
        SimpleDateFormat ft = new SimpleDateFormat(format);        
       return ft.format(date);    
    }
    
      
    public String formatTime(Time s ,String format) throws ParseException{
          Date date=new Date(s.getTime());       
           SimpleDateFormat ft = new SimpleDateFormat(format);        
           return ft.format(date);    
    }
    

}
