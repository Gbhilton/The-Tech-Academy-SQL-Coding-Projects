COM *********************************************************
COM *** Import Customer Master Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM A.AIAN8),1,8) as "Add_No", 
C.ABALPH as "Name_Alpha", 
A.AICO as "Company", 
A.AIACL as "Credit_Limit", 
E.PNNDTP as "Net_Days_to_Pay",
SUBSTR(TRIM(' ' FROM A.AIARPY),1,8) as "Alternate_Payor", 
A.AICLMG as "Collection_Manager", 
A.AIARC as "G_L_Offset", 
A.AITXA1 as "Tax_Rate_Area", 
A.AIDLC as "Date_Last_Credit_Review_Temp",
A.AIPOPN as "Person_Opening_Acct", 
A.AIDAOJ as "Date_Acct_Opened_Temp", 
A.AIBADT as "Billing_Add_Type", 
B.ALADD1 as "Add_Line_1", 
B.ALADD2 as "Add_Line_2", 
B.ALADD3 as "Add_Line_3", 
B.ALADD4 as "Add_Line_4", 
B.ALCTY1 as "City", 
B.ALADDS as "State", 
B.ALCOUN as "County", 
B.ALADDZ as "Postal_Code", 
B.ALCTR as "Country",
C.ABAT1 as "Search_Type", 
C.ABTAX as "Tax_ID", 
TRIM(' ' FROM C.ABALKY) as "Long_Add_No", 
TRIM(' ' FROM C.ABMCU) as "Business_Unit", 
C.ABAC23 as "Category_Code_Add_Book_23", 
SUBSTR(TRIM(' ' FROM C.ABAN85),1,8) as "FactorSpecial_Payee", 
C.ABTXCT as "Certificate_Tax_Exemption", 
C.ABALP1 as "Secondary_Alpha_Name", 
C.ABLNGP as "Language",
D.WPPH1 as "Phone_No",
E.PNPTD as "Descr_Pmt_Terms", 
A.AITRAR as "Pmt_Terms"
   FROM %v_SCHEMA1%.F03012 A
LEFT JOIN (SELECT DISTINCT(A.ALAN8), A.ALUPMJ, A.ALUPMT, A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR, B.maxDate, B.maxTime, B.Seq
   FROM %v_SCHEMA1%.F0116 A
INNER JOIN (SELECT DISTINCT(A.ALAN8), A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR,
            MAX(A.ALUPMJ) AS maxDate,  MAX(A.ALUPMT) AS maxTime, row_number() over(partition by A.ALAN8 order by A.ALUPMJ desc) Seq
            FROM %v_SCHEMA1%.F0116 A
            GROUP BY A.ALAN8, A.ALUPMJ, A.ALUPMT, A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR) B
    ON A.ALAN8 = B.ALAN8
        AND A.ALUPMJ = B.maxDate
        AND A.ALUPMT = B.maxTime
        WHERE Seq = 1) B ON A.AIAN8 = B.ALAN8
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.AIAN8 = C.ABAN8
LEFT JOIN (SELECT DISTINCT(A.WPAN8), A.WPUPMJ, A.WPUPMT, A.WPPH1, B.maxDate, B.maxTime, B.Seq
   FROM %v_SCHEMA1%.F0115 A
INNER JOIN (SELECT DISTINCT(A.WPAN8), A.WPPH1, MAX(A.WPUPMJ) AS maxDate,  MAX(A.WPUPMT) AS maxTime, row_number() over(partition by A.WPAN8 order by A.WPUPMJ desc) Seq
            FROM %v_SCHEMA1%.F0115 A
            GROUP BY A.WPAN8, A.WPUPMJ, A.WPUPMT, A.WPPH1) B
    ON A.WPAN8 = B.WPAN8
        AND A.WPUPMJ = B.maxDate
        AND A.WPUPMT = B.maxTime
        AND A.WPPH1 = B.WPPH1
        WHERE Seq = 1) D ON A.AIAN8 = D.WPAN8
LEFT JOIN %v_SCHEMA1%.F0014 E ON A.AITRAR = E.PNPTC
WHERE C.ABAT1 = %v_Customer_SearchType% and 
C.ABAC01 = %v_AddrBookCatCode1% and 
C.ABAC02 = %v_AddrBookCatCode2% and 
C.ABAC03 = %v_AddrBookCatCode3% and  
C.ABAC04 = %v_AddrBookCatCode4% and
C.ABAC05 = %v_AddrBookCatCode5% and
C.ABAC06 = %v_AddrBookCatCode6% and
C.ABAC07 = %v_AddrBookCatCode7% and
C.ABAC08 = %v_AddrBookCatCode8% and
C.ABAC09 = %v_AddrBookCatCode9% and
C.ABAC10 = %v_AddrBookCatCode10% and
C.ABAC12 = %v_AddrBookCatCode12% and
C.ABAC13 = %v_AddrBookCatCode13% and
C.ABAC14 = %v_AddrBookCatCode14% and
C.ABAC15 = %v_AddrBookCatCode15% and
C.ABAC16 = %v_AddrBookCatCode16% and
C.ABAC17 = %v_AddrBookCatCode17% and
C.ABAC18 = %v_AddrBookCatCode18% and
C.ABAC19 = %v_AddrBookCatCode19% and
C.ABAC20 = %v_AddrBookCatCode20% and
C.ABAC21 = %v_AddrBookCatCode21% and
C.ABAC22 = %v_AddrBookCatCode22% and
C.ABAC23 = %v_AddrBookCatCode23% and
C.ABAC24 = %v_AddrBookCatCode24% and
C.ABAC25 = %v_AddrBookCatCode25% and
C.ABAC26 = %v_AddrBookCatCode26% and
C.ABAC27 = %v_AddrBookCatCode27% and
C.ABAC28 = %v_AddrBookCatCode28% and
C.ABAC29 = %v_AddrBookCatCode29% and
C.ABAC30 = %v_AddrBookCatCode30%
ORDER BY A.AIAN8
  
COM *********************************************************
COM *** Import Accounts Receviable Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM RPDOC),1,8) as "Invoice_No",
RPDIVJ as "Invoice_Date_Temp",
TRIM(' ' FROM RPDCT) as "Doc_Type",
TRIM(' ' FROM RPKCO) as "Doc_Co",
TRIM(' ' FROM RPSFX) as "Doc_Pay_Item",
SUBSTR(TRIM(' ' FROM RPAN8),1,8) as "Add_No",
TRIM(' ' FROM RPALPH) as "Name_Alpha",
TRIM(' ' FROM RPPTC) as "Pmt_Terms_Code",
RPDGJ as "GL_Date_Temp",
RPAG/100 as "Amt_Gross",
RPAAP/100 as "Amt_Open",
B.RZPAAP/100 as "Pmt_Amt",
B.RZADSA/100 as "Discount_Taken",
TRIM(' ' FROM B.RZBCRC) as "Currency_Code",
TRIM(' ' FROM B.RZCRR) as "Currency_Conversion",
B.RYVLDT as "Cleared_Date_Temp",
B.RYDMTJ as "Date_Matching_Check_Temp",
TRIM(' ' FROM B.RYCBNK) as "Bank_Account_Paid_To",
TRIM(' ' FROM B.RYRYIN) as "Pmt_Instrument",
TRIM(' ' FROM RPPST) as "Pay_Status_Code",
SUBSTR(TRIM(' ' FROM RPSDOC),1,8) as "Sales_Doc_No",
TRIM(' ' FROM RPSDCT) as "Sales_Doc_Type",
SUBSTR(TRIM(' ' FROM RPPA8),1,8) as "Add_No_Parent",
SUBSTR(TRIM(' ' FROM RPAN8J),1,8) as "Add_No_Alternate_Payee",
RPDDJ as "Date_Net_Due_Temp",
TRIM(' ' FROM RPRMK) as "Name_Remark",
TRIM(' ' FROM RPICUT) as "Batch_Type",
SUBSTR(TRIM(' ' FROM RPICU),1,8) as "Batch_No",
RPDICJ as "Batch_Date_Temp",
TRIM(' ' FROM RPRSCO) as "Write_Off_Reason_Code",
SUBSTR(TRIM(' ' FROM RPODOC),1,8) as "Doc_Original",
TRIM(' ' FROM RPODCT) as "Doc_Type_Original",
TRIM(' ' FROM RPOKCO) as "Doc_Co_Original_Order",
TRIM(' ' FROM RPOSFX) as "Doc_Pay_Item_Original",
TRIM(' ' FROM RPVINV) as "Supplier_Invoice_No",
RPPPDI as "Date_Invoice_Printed_Temp",
TRIM(' ' FROM RPTORG) as "Transaction_Originator",
TRIM(' ' FROM RPUSER) as "User_ID",
RPJCL as "Date_Invoice_Closed_Temp",
TRIM(' ' FROM RPPID) as "Program_ID",
RPUPMJ as "Date_Updated_Temp",
TRIM(' ' FROM RPPO) as "Purchase_Order",
TRIM(' ' FROM RPPDCT) as "Doc_Type_Purch_Order",
TRIM(' ' FROM RPPKCO) as "Doc_Co_Purch_Order",
TRIM(' ' FROM RPDCTO) as "Order_Type",
RPLNID/1000 as "Line_No",
TRIM(' ' FROM RPSKCO) as "Doc_Co_Sales_Order",
TRIM(' ' FROM RPSFXO) as "Order_Suffix",
TRIM(' ' FROM RPCO) as "Co",
TRIM(' ' FROM RPGLC) as "GL_Offset",
TRIM(' ' FROM RPAID) as "Acct_ID",
SUBSTR(TRIM(' ' FROM RPPYR),1,8) as "Payor_Add_No",
RPADSC/100 as "Disc_Available",
RPADSA/100 as "Disc_Taken",
RPATXA/100 as "Amt_Taxable",
RPATXN/100 as "Amt_Non_Taxable",
RPSTAM/100 as "Amt_Tax",
TRIM(' ' FROM RPBCRC) as "Cur_Code_Base",
TRIM(' ' FROM RPCRRM) as "Cur_Mode_For_or_Dom_Entr",
TRIM(' ' FROM RPCRCD) as "Cur_Code_From",
RPCRR as "Cur_Conv_Spot_Rate",
TRIM(' ' FROM RPDMCD) as "Dom_Entr_wMult_Cur_Dist",
RPACR/100 as "Amt_Currency",
RPFAP/100 as "Amt_Foreign_Open",
RPCDS/100 as "Amt_Foreign_Disc_Avail",
RPCDSA/100 as "Amt_Foreign_Disc_Taken",
RPCTXA/100 as "Amt_Foreign_Taxable",
RPCTXN/100 as "Amt_Foreign_Non_Taxable",
RPCTAM/100 as "Amt_Foreign_Tax",
TRIM(' ' FROM RPTXA1) as "Tax_RateArea",
TRIM(' ' FROM RPEXR1) as "Tax_Expl_Code_1",
RPDSVJ as "Date_Service_Tax_Temp",
TRIM(' ' FROM RPGLBA) as "GL_Bank_Acct",
TRIM(' ' FROM RPAM) as "Acct_Mode_GL",
TRIM(' ' FROM RPAID2) as "Acct_ID2",
TRIM(' ' FROM RPAM2) as "Acct_Mode_GL2",
TRIM(' ' FROM RPMCU) as "Business_Unit",
TRIM(' ' FROM RPOBJ) as "Object_Acct",
TRIM(' ' FROM RPSUB) as "Subsidiary",
TRIM(' ' FROM RPSBLT) as "Subledger_Type",
TRIM(' ' FROM RPSBL) as "Subledger_GL",
RPDDNJ as "Dte_Disc_Due_Temp",
RPRDDJ as "Dte_of_Last_Sent_Reminder_Temp",
RPRDSJ as "Dte_Rem_Stop_Until_Dte_Temp",
RPLFCJ as "Dte_Last_Fee_Calc_Temp",
RPSMTJ as "Dte_Statement_Temp",
TRIM(' ' FROM RPNBRR) as "No_of_Rmdrs_to_Send",
TRIM(' ' FROM RPRDRL) as "Last_Sent_Reminder",
RPRMDS as "No_of_Sent_Reminders",
TRIM(' ' FROM RPCOLL) as "Collection_Report_YN",
TRIM(' ' FROM RPCORC) as "Collection_Reason_Code",
TRIM(' ' FROM RPAFC) as "Apply_Finance_Charges_YN",
TRIM(' ' FROM RPDNLT) as "Delinquency_Notice_YN",
RPVLDT as "Date_ClearedValue_Temp",
TRIM(' ' FROM RPRF) as "Frequency_Recurring",
RPDRF as "Recurring_Freq_of_Pmts",
TRIM(' ' FROM RPCTL) as "ControlStatement_Field",
TRIM(' ' FROM RPFNLP) as "Closed_Item_As_Of_Proc",
RPITM as "Item_No_Short",
RPU/100 as "Units",
TRIM(' ' FROM RPUM) as "Unit_of_Measure",
TRIM(' ' FROM RPALT6) as "GL_Pst_Cash_Basis_Acct",
RPVDGJ as "Void_Date_For_GL_Temp",
TRIM(' ' FROM RPVOD) as "Void_Flag",
SUBSTR(TRIM(' ' FROM RPPYID),1,15) as "Pmt_ID_Internal",
TRIM(' ' FROM RPJOBN) as "Work_Station_ID"
FROM %v_SCHEMA1%.F03B11 A 
LEFT JOIN (SELECT * 
FROM %v_SCHEMA1%.F03B14 A
LEFT JOIN %v_SCHEMA1%.F03B13 B ON A.RZPYID = B.RYPYID) B ON A.RPDOC = B.RZDOC and A.RPKCO = B.RZKCO and A.RPDCT = B.RZDCT and A.RPSFX = B.RZSFX
WHERE (A.RPCO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (A.RPDGJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.RPCO <> ' '
 
COM *********************************************************
COM *** Import Sales Order Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM SDDOCO),1,8) as "Order No",
SDTRDJ as "Order_Date_Temp",
TRIM(' ' FROM SDDCTO) as "Order Type",
SDLNID/1000 as "Line No",
TRIM(' ' FROM SDKCOO) as "Order Co",
TRIM(' ' FROM C.ABALPH) as "Name_Alpha", 
SUBSTR(TRIM(' ' FROM SDAN8),1,8) as "Add No",
SUBSTR(TRIM(' ' FROM SDSHAN),1,8) as "Add No Ship To",
SUBSTR(TRIM(' ' FROM SDPA8),1,8) as "Add No Parent",
SDADDJ as "Date_Actual_Ship_Date_Temp",
SUBSTR(TRIM(' ' FROM SDDOC),1,8) as "Invoice No",
SDIVD as "Invoice_Date_Temp",
SDDGL as "GL_Date_Temp",
SUBSTR(TRIM(' ' FROM SDITM),1,8) as "Item No Short",
TRIM(' ' FROM SDLITM) as "Item No2",
TRIM(' ' FROM SDAITM) as "Item No3",
TRIM(' ' FROM SDDSC1) as "Descr",
TRIM(' ' FROM SDDSC2) as "Descr Line 2",
TRIM(' ' FROM SDUOM) as "Unit of Measure as Input",
SDUORG/1000 as "Qty Ordered",
SDSOQS/1000 as "Qty Shipped",
SDUOPN as "Units Open",
SDQTYT/1000 as "Units Shipped to Date",
SDUPRC/10000 as "Amt Price per Unit",
SDAEXP/100 as "Amt Extended Price",
SDAOPN/100 as "Amt Open",
TRIM(' ' FROM SDNXTR) as "Status Code Next",
TRIM(' ' FROM SDLTTR) as "Status Code Last",
SDDRQJ as "Date_Requested_Temp",
SDPDDJ as "Date_Scheduled_Pick_Temp",
SDCNDJ as "Date_Cancel_Temp",
SDRSDJ as "Date_Promised_Delivery_Temp",
SDPEFJ as "Date_Price_Effective_Date_Temp",
SDPPDJ as "Date_Promised_Shipment_Temp",
TRIM(' ' FROM SDPROV) as "Price Override Code",
TRIM(' ' FROM SDPTC) as "Pmt Terms Code",
TRIM(' ' FROM SDRYIN) as "Pmt Instrument",
SUBSTR(TRIM(' ' FROM SDPSN),1,8) as "Pick Slip No",
SUBSTR(TRIM(' ' FROM SDDELN),1,8) as "Delivery No",
SDQRLV as "Units Relieved",
SUBSTR(TRIM(' ' FROM SDANBY),1,8) as "Buyer No",
TRIM(' ' FROM SDTORG) as "Trans Originator",
TRIM(' ' FROM SDUSER) as "User ID",
TRIM(' ' FROM SDPID) as "Program ID",
TRIM(' ' FROM SDJOBN) as "Work Station ID",
SDUPMJ as "Date_Updated_Temp",
TRIM(' ' FROM SDLOCN) as "Location",
TRIM(' ' FROM SDSFXO) as "Order Suffix",
TRIM(' ' FROM SDMCU) as "Business Unit",
TRIM(' ' FROM SDCO) as "Co",
TRIM(' ' FROM SDRORN) as "PO SO WO No",
TRIM(' ' FROM SDRCTO) as "PO SO WO Order Type",
SDRLLN/1000 as "Related PO SO Line No",
TRIM(' ' FROM SDDMCT) as "Agrmt No Distr",
SDDMCS as "Agrmt Suppl Distr",
TRIM(' ' FROM SDLNTY) as "Line Type",
TRIM(' ' FROM SDEMCU) as "Business Unit Header",
TRIM(' ' FROM SDRLIT) as "Item No Related Kit",
SDKTLN/1000 as "Kit Master Line No",
SDCPNT/10 as "Component Line No",
SDRKIT as "Related Kit Component",
SDKTP as "No of Component Per Parent",
TRIM(' ' FROM SDSRP1) as "Sales Catalog Section",
TRIM(' ' FROM SDSRP2) as "Sub Section",
TRIM(' ' FROM SDPRP1) as "Commodity Class",
TRIM(' ' FROM SDPRP2) as "Commodity Sub Class",
TRIM(' ' FROM SDPRP3) as "Supplier Rebate Code",
TRIM(' ' FROM SDPRP4) as "Master Planning Family",
TRIM(' ' FROM SDPRP5) as "Purchasing Cat Code 5",
SDSOBK as "Units Qty Backordered Held",
SDSOCN as "Units Qty Canceled Scrapped",
SDSONE as "Units Future Qty Committed",
TRIM(' ' FROM SDCOMM) as "Committed H S",
TRIM(' ' FROM SDTPC) as "Temporary Price Y N",
TRIM(' ' FROM SDAPUM) as "UOM Entered for Unit Price",
SDLPRC/10000 as "Amt List Price",
SDUNCS/10000 as "Amt Unit Cost",
SDECST/100 as "Amt Extended Cost",
TRIM(' ' FROM SDCSTO) as "Cost Override Code",
SDTCST/10000 as "Extended Cost Transfer",
TRIM(' ' FROM SDINMG) as "Print Message",
TRIM(' ' FROM SDDTBS) as "Based on Date",
SDTRDC/1000 as "Disc Trade",
SDFUN2/10000 as "Trade Disc Old",
TRIM(' ' FROM SDASN) as "Price and Adj Schedule",
TRIM(' ' FROM SDPRGR) as "Item Price Group",
TRIM(' ' FROM SDCLVL) as "Pricing Cat Level",
SDCADC/1000 as "Disc % Cash",
TRIM(' ' FROM SDKCO) as "Doc Co",
TRIM(' ' FROM SDDCT) as "Doc Type",
SUBSTR(TRIM(' ' FROM SDODOC),1,8) as "Doc Original",
TRIM(' ' FROM SDODCT) as "Doc Type Original",
TRIM(' ' FROM SDOKC) as "Doc Co Original",
TRIM(' ' FROM SDTAX1) as "Sales Taxable Y N",
TRIM(' ' FROM SDTXA1) as "Tax Rate Area",
TRIM(' ' FROM SDEXR1) as "Tax Expl Code 1",
TRIM(' ' FROM SDATXT) as "Associated Text",
TRIM(' ' FROM SDPRIO) as "Priority Processing",
TRIM(' ' FROM SDRESL) as "Printed Code",
TRIM(' ' FROM SDBACK) as "Backorders Allowed Y N",
TRIM(' ' FROM SDSBAL) as "Substitutes Allowed Y N",
TRIM(' ' FROM SDAPTS) as "Partial Line Shpmt Allow Y N",
TRIM(' ' FROM SDLOB) as "Line of Business",
TRIM(' ' FROM SDEUSE) as "End Use",
TRIM(' ' FROM SDDTYS) as "Duty Status",
TRIM(' ' FROM SDNTR) as "Nature of Trans",
SUBSTR(TRIM(' ' FROM SDVEND),1,8) as "Primary Last Supplier No",
SUBSTR(TRIM(' ' FROM SDCARS),1,8) as "Carrier No",
TRIM(' ' FROM SDMOT) as "Mode of Transport",
TRIM(' ' FROM SDROUT) as "Route Code",
TRIM(' ' FROM SDSTOP) as "Stop Code",
TRIM(' ' FROM SDZON) as "Zone No",
TRIM(' ' FROM SDCNID) as "Container I D",
TRIM(' ' FROM SDFRTH) as "Freight Handling Code",
TRIM(' ' FROM SDSHCM) as "Shipping Commodity Class",
TRIM(' ' FROM SDSHCN) as "Shipping Conditions Code",
TRIM(' ' FROM SDSERN) as "Serial No Lot",
TRIM(' ' FROM SDUPC1) as "Price Code 1",
TRIM(' ' FROM SDUPC2) as "Price Code 2",
TRIM(' ' FROM SDUPC3) as "Price Code 3",
'Detail' as "Sales_Order_Table"
FROM %v_SCHEMA1%.F4211 A
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.SDAN8 = C.ABAN8
WHERE (A.SDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))  
AND (A.SDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.SDKCOO <> ' '
UNION ALL
SELECT SUBSTR(TRIM(' ' FROM SDDOCO),1,8) as "Order No",
SDTRDJ as "Order_Date_Temp",
TRIM(' ' FROM SDDCTO) as "Order Type",
SDLNID/1000 as "Line No",
TRIM(' ' FROM SDKCOO) as "Order Co",
TRIM(' ' FROM C.ABALPH) as "Name_Alpha", 
SUBSTR(TRIM(' ' FROM SDAN8),1,8) as "Add No",
SUBSTR(TRIM(' ' FROM SDSHAN),1,8) as "Add No Ship To",
SUBSTR(TRIM(' ' FROM SDPA8),1,8) as "Add No Parent",
SDADDJ as "Date_Actual_Ship_Date_Temp",
SUBSTR(TRIM(' ' FROM SDDOC),1,8) as "Invoice No",
SDIVD as "Invoice_Date_Temp",
SDDGL as "GL_Date_Temp",
SUBSTR(TRIM(' ' FROM SDITM),1,8) as "Item No Short",
TRIM(' ' FROM SDLITM) as "Item No2",
TRIM(' ' FROM SDAITM) as "Item No3",
TRIM(' ' FROM SDDSC1) as "Descr",
TRIM(' ' FROM SDDSC2) as "Descr Line 2",
TRIM(' ' FROM SDUOM) as "Unit of Measure as Input",
SDUORG/1000 as "Qty Ordered",
SDSOQS/1000 as "Qty Shipped",
SDUOPN as "Units Open",
SDQTYT/1000 as "Units Shipped to Date",
SDUPRC/10000 as "Amt Price per Unit",
SDAEXP/100 as "Amt Extended Price",
SDAOPN/100 as "Amt Open",
TRIM(' ' FROM SDNXTR) as "Status Code Next",
TRIM(' ' FROM SDLTTR) as "Status Code Last",
SDDRQJ as "Date_Requested_Temp",
SDPDDJ as "Date_Scheduled_Pick_Temp",
SDCNDJ as "Date_Cancel_Temp",
SDRSDJ as "Date_Promised_Delivery_Temp",
SDPEFJ as "Date_Price_Effective_Date_Temp",
SDPPDJ as "Date_Promised_Shipment_Temp",
TRIM(' ' FROM SDPROV) as "Price Override Code",
TRIM(' ' FROM SDPTC) as "Pmt Terms Code",
TRIM(' ' FROM SDRYIN) as "Pmt Instrument",
SUBSTR(TRIM(' ' FROM SDPSN),1,8) as "Pick Slip No",
SUBSTR(TRIM(' ' FROM SDDELN),1,8) as "Delivery No",
SDQRLV as "Units Relieved",
SUBSTR(TRIM(' ' FROM SDANBY),1,8) as "Buyer No",
TRIM(' ' FROM SDTORG) as "Trans Originator",
TRIM(' ' FROM SDUSER) as "User ID",
TRIM(' ' FROM SDPID) as "Program ID",
TRIM(' ' FROM SDJOBN) as "Work Station ID",
SDUPMJ as "Date_Updated_Temp",
TRIM(' ' FROM SDLOCN) as "Location",
TRIM(' ' FROM SDSFXO) as "Order Suffix",
TRIM(' ' FROM SDMCU) as "Business Unit",
TRIM(' ' FROM SDCO) as "Co",
TRIM(' ' FROM SDRORN) as "PO SO WO No",
TRIM(' ' FROM SDRCTO) as "PO SO WO Order Type",
SDRLLN/1000 as "Related PO SO Line No",
TRIM(' ' FROM SDDMCT) as "Agrmt No Distr",
SDDMCS as "Agrmt Suppl Distr",
TRIM(' ' FROM SDLNTY) as "Line Type",
TRIM(' ' FROM SDEMCU) as "Business Unit Header",
TRIM(' ' FROM SDRLIT) as "Item No Related Kit",
SDKTLN/1000 as "Kit Master Line No",
SDCPNT/10 as "Component Line No",
SDRKIT as "Related Kit Component",
SDKTP as "No of Component Per Parent",
TRIM(' ' FROM SDSRP1) as "Sales Catalog Section",
TRIM(' ' FROM SDSRP2) as "Sub Section",
TRIM(' ' FROM SDPRP1) as "Commodity Class",
TRIM(' ' FROM SDPRP2) as "Commodity Sub Class",
TRIM(' ' FROM SDPRP3) as "Supplier Rebate Code",
TRIM(' ' FROM SDPRP4) as "Master Planning Family",
TRIM(' ' FROM SDPRP5) as "Purchasing Cat Code 5",
SDSOBK as "Units Qty Backordered Held",
SDSOCN as "Units Qty Canceled Scrapped",
SDSONE as "Units Future Qty Committed",
TRIM(' ' FROM SDCOMM) as "Committed H S",
TRIM(' ' FROM SDTPC) as "Temporary Price Y N",
TRIM(' ' FROM SDAPUM) as "UOM Entered for Unit Price",
SDLPRC/10000 as "Amt List Price",
SDUNCS/10000 as "Amt Unit Cost",
SDECST/100 as "Amt Extended Cost",
TRIM(' ' FROM SDCSTO) as "Cost Override Code",
SDTCST/10000 as "Extended Cost Transfer",
TRIM(' ' FROM SDINMG) as "Print Message",
TRIM(' ' FROM SDDTBS) as "Based on Date",
SDTRDC/1000 as "Disc Trade",
SDFUN2/10000 as "Trade Disc Old",
TRIM(' ' FROM SDASN) as "Price and Adj Schedule",
TRIM(' ' FROM SDPRGR) as "Item Price Group",
TRIM(' ' FROM SDCLVL) as "Pricing Cat Level",
SDCADC/1000 as "Disc % Cash",
TRIM(' ' FROM SDKCO) as "Doc Co",
TRIM(' ' FROM SDDCT) as "Doc Type",
SUBSTR(TRIM(' ' FROM SDODOC),1,8) as "Doc Original",
TRIM(' ' FROM SDODCT) as "Doc Type Original",
TRIM(' ' FROM SDOKC) as "Doc Co Original",
TRIM(' ' FROM SDTAX1) as "Sales Taxable Y N",
TRIM(' ' FROM SDTXA1) as "Tax Rate Area",
TRIM(' ' FROM SDEXR1) as "Tax Expl Code 1",
TRIM(' ' FROM SDATXT) as "Associated Text",
TRIM(' ' FROM SDPRIO) as "Priority Processing",
TRIM(' ' FROM SDRESL) as "Printed Code",
TRIM(' ' FROM SDBACK) as "Backorders Allowed Y N",
TRIM(' ' FROM SDSBAL) as "Substitutes Allowed Y N",
TRIM(' ' FROM SDAPTS) as "Partial Line Shpmt Allow Y N",
TRIM(' ' FROM SDLOB) as "Line of Business",
TRIM(' ' FROM SDEUSE) as "End Use",
TRIM(' ' FROM SDDTYS) as "Duty Status",
TRIM(' ' FROM SDNTR) as "Nature of Trans",
SUBSTR(TRIM(' ' FROM SDVEND),1,8) as "Primary Last Supplier No",
SUBSTR(TRIM(' ' FROM SDCARS),1,8) as "Carrier No",
TRIM(' ' FROM SDMOT) as "Mode of Transport",
TRIM(' ' FROM SDROUT) as "Route Code",
TRIM(' ' FROM SDSTOP) as "Stop Code",
TRIM(' ' FROM SDZON) as "Zone No",
TRIM(' ' FROM SDCNID) as "Container I D",
TRIM(' ' FROM SDFRTH) as "Freight Handling Code",
TRIM(' ' FROM SDSHCM) as "Shipping Commodity Class",
TRIM(' ' FROM SDSHCN) as "Shipping Conditions Code",
TRIM(' ' FROM SDSERN) as "Serial No Lot",
TRIM(' ' FROM SDUPC1) as "Price Code 1",
TRIM(' ' FROM SDUPC2) as "Price Code 2",
TRIM(' ' FROM SDUPC3) as "Price Code 3",
'History' as "Sales_Order_Table"
FROM %v_SCHEMA1%.F42119 B
LEFT JOIN %v_SCHEMA1%.F0101 C ON B.SDAN8 = C.ABAN8
WHERE (B.SDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (B.SDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND B.SDKCOO <> ' '