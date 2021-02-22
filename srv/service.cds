using  {
    ventia.polaris.time as mytime
    
} from '../db/schema';

service getWorkingTime @(path : '/odata/TimeData') {

 
entity Attachments as projection on mytime.Attachments;

@Capabilities : { Insertable: true, Updatable : true, Deletable: false }
entity timeDetails as projection on mytime.timeDetails {
   *, AttachmentItems : redirected TO Attachments
};

    

}