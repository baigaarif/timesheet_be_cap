using  {
    ventia.polaris.time as mytime,
    
} from '../db/schema';

service getWorkingTime @(path : '/odata/TimeData') {

 
entity Attachments as projection on mytime.Attachments;

@Capabilities : { Insertable: true, Updatable : true, Deletable: false }
entity WorkingTime as projection on mytime.WorkingTime {
   *, AttachmentItems : redirected TO Attachments
};

    

}