namespace ventia.polaris.time;

using {
    managed,
    cuid
} from '@sap/cds/common';

type time_Status : String(20) enum {
    Approved  = 'A';
    Submitted = 'S';
    Rejected  = 'R';
    Open      = 'O';

}

type Days : String(10) enum {
    Monday    = 'MON';
    Tuesday   = 'TUE';
    Wednesday = 'WED';
    Thursday  = 'THU';
    Friday    = 'FRI';
    Saturday  = 'SAT';
    Sunday    = 'SUN';
}


type COTYPE : String(30) enum {
    WORKORDER     = 'WORK';
    NETWORK       = 'NETW';
    INTERNALORDER = 'INTORD';
    COSTCENTER    = 'COCE';
}

annotate time_Status with @(

assert.enum);


entity Timedetails : managed {
    key PERNR             : Integer;
    key PAYROLL_AREA      : String(20);
    key DATE              : Date;
    key SEQ_NUM           : Integer;
    key TIMEIN            : Time;
    key TIMEOUT           : Time;
    key ATT_ABS_CODE      : String(10);
        att_Abs_Desc      : String(100);
        Day               : Days;
        hours_Rec         : Integer;
        co_Type           : COTYPE;
        co_Code           : String;
        co_Desc           : String;
        co_Type2          : String;
        co_Code2          : String;
        co_Desc2          : String;
        cause_Type        : String;
        time_Zone         : String;
        prev_Day          : Boolean;
        empl_FullName     : String;
        time_Slice_Status : time_Status;
        line_Mgr_Approver : String;
        line_Mgr_FullName : String;
        del_Mgr_Approver  : String;
        del_Mgr_FullName  : String;
        hasAllowance      : Boolean;
        hasAttachment     : Boolean;
        hasComment        : Boolean;
        attachmentitems   : Composition of many Attachments
                                on attachmentitems.attachmentitems = $self;
        allowanceItems    : Composition of many Allowance
                                on allowanceItems.allowanceItems = $self;
        commentsItems     : Composition of many Comments
                                on commentsItems.commentsItems = $self;

}


entity Attachments {
    key attachmentitems : Association to Timedetails;
        attachmentName  : String;
        attachmentType  : String;
        attachmentLink  : String;


}

entity Allowance {
    key allowanceItems : Association to Timedetails;
        allowanceCode  : String;
        allowanceDesc  : String;
        coType         : COTYPE;
        coCode         : String;
        coDesc         : String;
        coType2        : String;
        coCode2        : String;
        coDesc2        : String;
        isHDA          : Boolean;
        isBillable     : Boolean;


}

entity Comments {
    key commentsItems : Association to Timedetails;
        sender        : String;
        recipient     : String;
        subject       : String;
        messageBody   : String;
}

entity FavHeader {
    key PERNR        : Integer;
    key PAYROLL_AREA : String;
    key FAVNAME      : String;
    key TYPE         : String;
        favItems     : Composition of many FavItems
                           on favItems.favitems = $self;

}

entity FavItems {
    key CUID         : cuid;
    key    favitems     : Association to FavHeader;
        TIMEIN       : Time;
        TIMEOUT      : Time;
        SEQ_NUM      : Integer;
        ATT_ABS_CODE : String(10);
        Day          : Days;
        coType       : COTYPE;
        coCode       : String;
        coDesc       : String;
        coType2      : String;
        coCode2      : String;
        coDesc2      : String;
}
