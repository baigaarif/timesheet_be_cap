namespace ventia.polaris.time;

using {managed} from '@sap/cds/common';

entity Timedetails : managed {
    key PERNR             : Integer;
    key PAYROLL_AREA      : String(20);
    key DATE              : Date;
    key SEQ_NUM           : Integer;
    key TIMEIN            : Time;
    key TIMEOUT           : Time;
    key ATT_ABS_CODE      : String(10);
        ATT_ABS_DESC      : String(100);
        Day               : String(10);
        hours_Rec         : Integer;
        co_Type           : String;
        co_Code           : String;
        co_Desc           : String;
        co_Type2          : String;
        co_Code2          : String;
        co_Desc2          : String;
        cause_Type        : String;
        time_Zone         : String;
        prev_Day          : Boolean;
        empl_FullName     : String;
        time_Slice_Status : String;
        line_Mgr_Approver : String;
        line_Mgr_FullName : String;
        del_Mgr_Approver  : String;
        del_Mgr_FullName  : String;
        WORKASSIGNMENT    : String(100);
        HasAllowance      : Boolean;
        HasAttachment     : Boolean;
        HasComment        : Boolean;
        AttachmentItems   : Association to many Attachments
                                on AttachmentItems.ID = $self;
        HasAllowanceItems : Integer;

}


entity Attachments {
    key ID      : Association to Timedetails;
    key NUMBER  : Integer;
        DocType : String;
}

entity Allowance {
    key ID         : Association to Timedetails;
    key CODE       : Integer;
        Desc       : String(100);
        CostObject : String(50);
        IsBillable : Boolean;
        IsHDA      : Boolean;
        Quantity   : Integer;
        Unit       : String(10);

}
