using {ventia.polaris.time as mytime

} from '../db/schema';



    
service TimesheetService @(impl : './handlers/timesheet-service.js')@(path : '/odata/v4/TimesheetService') {


   entity Attachments as projection on mytime.Attachments;    
    entity Timedetails as projection on mytime.Timedetails;
    entity Allowances as projection on mytime.Allowance;
    entity Comments as projection on mytime.Comments;
    entity Favheader as projection on mytime.FavHeader;
    entity Favitems as projection on mytime.FavItems;


}
