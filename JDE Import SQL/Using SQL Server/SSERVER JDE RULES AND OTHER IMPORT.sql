COM *********************************************************
COM *** Import Activity Rules Table
COM *********************************************************

SELECT LTRIM(FSDCTO) as 'Order Type',
LTRIM(FSTRTY) as 'Status Line',
LTRIM(FSSTDS) as 'Descr Status',
LTRIM(FSLNTY) as 'Line Type',
LTRIM(FSLNDS) as 'Descr Line Type',
LTRIM(FSLND2) as 'Descr Line Type Line 2',
LTRIM(FSNXTR) as 'Status Code Next',
LTRIM(FSA1TR) as 'Status Code Allowed 1',
LTRIM(FSA2TR) as 'Status Code Allowed 2',
LTRIM(FSA3TR) as 'Status Code Allowed 3',
LTRIM(FSA4TR) as 'Status Code Allowed 4',
LTRIM(FSA5TR) as 'Status Code Allowed 5',
LTRIM(FSFID) as 'Form ID',
LTRIM(STR(FSORNN,2)) as 'Order Type Next No',
LTRIM(FSWRTH) as 'Flag Write Ledger Record Y N '
FROM %v_SCHEMA1%.F40203

COM *********************************************************
COM *** Import Price Adjustment Table
COM *********************************************************

SELECT LTRIM(STR(ADAN8,8)) as 'Add No',
LTRIM(ADAST) as 'Price Adjustment Name',
LTRIM(STR(ADITM,8)) as 'Item NoShort',
LTRIM(ADLITM) as 'Item No2',
LTRIM(ADAITM) as 'Item No3',
LTRIM(ADUOM) as 'Unit of Measure as Input',
ADFVTR/10000 as 'Factor Value',
ADMNQ as 'QtyFrom',
ADEFTJ as 'Date_Effective_Temp',
ADEXDJ as 'Date_Expired_Temp',
LTRIM(ADCRCD) as 'Currency CodeFrom',
LTRIM(ADBSCD) as 'Basis Code',
LTRIM(ADLEDG) as 'Cost Method',
LTRIM(ADFRMN) as 'Price Formula Name',
LTRIM(ADFGY) as 'Free Goods  Y N',
LTRIM(STR(ADATID,8)) as 'Price Adjustment Key ID',
LTRIM(ADURCD) as 'User Reserved Code',
ADURDT as 'User_Reserved_Date_Temp',
ADURAT/100 as 'User Reserved Amt',
LTRIM(STR(ADURAB,8)) as 'User Reserved No',
LTRIM(ADURRF) as 'User Reserved Reference',
LTRIM(ADUSER) as 'User ID',
LTRIM(ADPID) as 'Program ID',
LTRIM(ADJOBN) as 'Work Station ID',
ADUPMJ as 'Date_Updated_Temp',
ADTDAY as 'Time of Day'
FROM %v_SCHEMA1%.F4072

COM *********************************************************
COM *** Import Payment Terms Table
COM *********************************************************

SELECT LTRIM(PNPTC) as 'Pmt Terms Code',
LTRIM(PNPTD) as 'Descr Pmt Terms',
PNDCP as 'Disc Per Pmt Terms',
PNDCD as 'Disc Days',
PNNDTP as 'Net Days to Pay',
PNDDJ as 'Date_Net_Due_Temp',
PNNSP as 'No of Split Pmts',
PNDTPA as 'Days to Pay Aging',
PNEIR as 'Percnt Eff Interest Rate',
LTRIM(PNUSER) as 'User ID',
LTRIM(PNPID) as 'Program ID',
PNUPMJ as 'Date_Updated_Temp',
LTRIM(PNJOBN) as 'Work Station ID',
PNUPMT as 'Time Last Updated',
PNPXDM as 'Date Due Date MO',
PNPXDD as 'Date Due Date DA'       
FROM %v_SCHEMA1%.F0014

COM *********************************************************
COM *** Import Approval Levels Table
COM *********************************************************

SELECT LTRIM(APDCTO) as 'Order Type',
LTRIM(APARTG) as 'Code Approval Routing',
LTRIM(APDL01) as 'Descr',
APALIM as 'Limit Approval',
APRPER as 'Person Responsible',
LTRIM(APATY) as 'Type of Approver'
FROM %v_SCHEMA1%.F43008

