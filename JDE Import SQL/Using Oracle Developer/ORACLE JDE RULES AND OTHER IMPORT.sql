COM *********************************************************
COM *** Import Activity Rules Table
COM *********************************************************

SELECT TRIM(' ' FROM FSDCTO) as "Order Type",
TRIM(' ' FROM FSTRTY) as "Status Line",
TRIM(' ' FROM FSSTDS) as "Descr Status",
TRIM(' ' FROM FSLNTY) as "Line Type",
TRIM(' ' FROM FSLNDS) as "Descr Line Type",
TRIM(' ' FROM FSLND2) as "Descr Line Type Line 2",
TRIM(' ' FROM FSNXTR) as "Status Code Next",
TRIM(' ' FROM FSA1TR) as "Status Code Allowed 1",
TRIM(' ' FROM FSA2TR) as "Status Code Allowed 2",
TRIM(' ' FROM FSA3TR) as "Status Code Allowed 3",
TRIM(' ' FROM FSA4TR) as "Status Code Allowed 4",
TRIM(' ' FROM FSA5TR) as "Status Code Allowed 5",
TRIM(' ' FROM FSFID) as "Form ID",
SUBSTR(TRIM(' ' FROM FSORNN),1,2) as "Order Type Next No",
TRIM(' ' FROM FSWRTH) as "Flag Write Ledger Record Y N"
FROM %v_SCHEMA1%.F40203  

COM *********************************************************
COM *** Import Price Adjustment Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM ADAN8),1,8) as "Add No",
TRIM(' ' FROM ADAST) as "Price Adjustment Name",
SUBSTR(TRIM(' ' FROM ADITM),1,8) as "Item NoShort",
TRIM(' ' FROM ADLITM) as "Item No2",
TRIM(' ' FROM ADAITM) as "Item No3",
TRIM(' ' FROM ADUOM) as "Unit of Measure as Input",
ADFVTR/10000 as "Factor Value",
ADMNQ as "QtyFrom",
ADEFTJ as "Date_Effective_Temp",
ADEXDJ as "Date_Expired_Temp",
TRIM(' ' FROM ADCRCD) as "Currency CodeFrom",
TRIM(' ' FROM ADBSCD) as "Basis Code",
TRIM(' ' FROM ADLEDG) as "Cost Method",
TRIM(' ' FROM ADFRMN) as "Price Formula Name",
TRIM(' ' FROM ADFGY) as "Free Goods  Y N",
SUBSTR(TRIM(' ' FROM ADATID),1,8) as "Price Adjustment Key ID",
TRIM(' ' FROM ADURCD) as "User Reserved Code",
ADURDT as "User_Reserved_Date_Temp",
ADURAT/100 as "User Reserved Amt",
SUBSTR(TRIM(' ' FROM ADURAB),1,8) as "User Reserved No",
TRIM(' ' FROM ADURRF) as "User Reserved Reference",
TRIM(' ' FROM ADUSER) as "User ID",
TRIM(' ' FROM ADPID) as "Program ID",
TRIM(' ' FROM ADJOBN) as "Work Station ID",
ADUPMJ as "Date_Updated_Temp",
ADTDAY as "Time of Day"
FROM %v_SCHEMA1%.F4072

COM *********************************************************
COM *** Import Payment Terms Table
COM *********************************************************

SELECT TRIM(' ' FROM PNPTC) as "Pmt Terms Code",
TRIM(' ' FROM PNPTD) as "Descr Pmt Terms",
PNDCP as "Disc Per Pmt Terms",
PNDCD as "Disc Days",
PNNDTP as "Net Days to Pay",
PNDDJ as "Date_Net_Due_Temp",
PNNSP as "No of Split Pmts",
PNDTPA as "Days to Pay Aging",
PNEIR as "Percnt Eff Interest Rate",
TRIM(' ' FROM PNUSER) as "User ID",
TRIM(' ' FROM PNPID) as "Program ID",
PNUPMJ as "Date_Updated_Temp",
TRIM(' ' FROM PNJOBN) as "Work Station ID",
PNUPMT as "Time Last Updated",
PNPXDM as "Date Due Date MO",
PNPXDD as "Date Due Date DA"       
FROM %v_SCHEMA1%.F0014

COM *********************************************************
COM *** Import Approval Levels Table
COM *********************************************************

SELECT TRIM(' ' FROM APDCTO) as "Order Type",
TRIM(' ' FROM APARTG) as "Code Approval Routing",
TRIM(' ' FROM APDL01) as "Descr",
APALIM as "Limit Approval",
APRPER as "Person Responsible",
TRIM(' ' FROM APATY) as "Type of Approver"
FROM %v_SCHEMA1%.F43008