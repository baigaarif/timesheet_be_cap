using {ventia.polaris.time as mytime

} from '../db/schema';

service TIMESHEET_SRV @(path : '/odata/v4/polaris/TIMESHEET_SRV') {


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
