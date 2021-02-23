using {ventia.polaris.time as mytime

} from '../db/schema';

service TimesheetService @(impl : './handlers/timesheet-service.js')@(path : '/odata/v4/TimesheetService') {


    entity Attachments as projection on mytime.Attachments;


    @Capabilities : {
        Insertable : true,
        Updatable  : true,
        Deletable  : false
    }
    entity Timedetails as projection on mytime.Timedetails {
        * , attachmentItems : redirected to Attachments
    };


}
