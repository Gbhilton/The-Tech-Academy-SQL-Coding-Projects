COM *********************************************************
COM *** Import Customer Master Table
COM *********************************************************

SELECT RTRIM(LTRIM(STR(A.AIAN8,8))) as 'Add_No',
C.ABALPH as 'Name_Alpha',  
A.AICO as 'Company', 
A.AIACL as 'Credit_Limit', 
E.PNNDTP as 'Net_Days_to_Pay',
RTRIM(LTRIM(STR(A.AIARPY,8))) as 'Alternate_Payor', 
A.AICLMG as 'Collection_Manager', 
A.AIARC as 'G_L_Offset', 
A.AITXA1 as 'Tax_Rate_Area', 
A.AIDLC as 'Date_Last_Credit_Review_Temp', 
A.AIPOPN as 'Person_Opening_Acct', 
A.AIDAOJ as 'Date_Acct_Opened_Temp', 
A.AIBADT as 'Billing_Add_Type', 
B.ALADD1 as 'Add_Line_1', 
B.ALADD2 as 'Add_Line_2', 
B.ALADD3 as 'Add_Line_3', 
B.ALADD4 as 'Add_Line_4', 
B.ALCTY1 as 'City', 
B.ALADDS as 'State', 
B.ALCOUN as 'County', 
B.ALADDZ as 'Postal_Code', 
B.ALCTR as 'Country',
C.ABAT1 as 'Search_Type', 
C.ABTAX as 'Tax_ID', 
RTRIM(LTRIM(C.ABALKY)) as 'Long_Add_No', 
RTRIM(LTRIM(C.ABMCU)) as 'Business_Unit', 
C.ABAC23 as 'Category_Code_Add_Book_23', 
RTRIM(LTRIM(STR(C.ABAN85,8))) as 'FactorSpecial_Payee', 
C.ABTXCT as 'Certificate_Tax_Exemption', 
C.ABALP1 as 'Secondary_Alpha_Name', 
C.ABLNGP as 'Language',
D.WPPH1 as 'Phone_No',
E.PNPTD as 'Descr_Pmt_Terms', 
A.AITRAR as 'Pmt_Terms'
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

SELECT RTRIM(LTRIM(STR(RPDOC,8))) as 'Invoice_No',
RPDIVJ as 'Invoice_Date_Temp',
RTRIM(LTRIM(RPDCT)) as 'Doc_Type',
RTRIM(LTRIM(RPKCO)) as 'Doc_Co',
RTRIM(LTRIM(RPSFX)) as 'Doc_Pay_Item',
RTRIM(LTRIM(STR(RPAN8,8)) as 'Add_No',
RTRIM(LTRIM(RPALPH)) as 'Name_Alpha',
RTRIM(LTRIM(RPPTC)) as 'Pmt_Terms_Code',
RPDGJ as 'GL_Date_Temp',
RPAG/100 as 'Amt_Gross',
RPAAP/100 as 'Amt_Open',
RZPAAP/100 as 'Pmt_Amt',
RZADSA/100 as 'Discount_Taken',
RTRIM(LTRIM(RZBCRC)) as 'Currency_Code',
RTRIM(LTRIM(RZCRR)) as 'Currency_Conversion',
RYVLDT as 'Cleared_Date_Temp',
RYDMTJ as 'Date_Matching_Check_Temp',
RTRIM(LTRIM(RYCBNK)) as 'Bank_Account_Paid_To',
RTRIM(LTRIM(RYRYIN)) as 'Pmt_Instrument',
RTRIM(LTRIM(RPPST)) as 'Pay_Status_Code',
RTRIM(LTRIM(STR(RPSDOC,8))) as 'Sales_Doc_No',
RTRIM(LTRIM(RPSDCT)) as 'Sales_Doc_Type',
RTRIM(LTRIM(STR(RPPA8,8))) as 'Add_No_Parent',
RTRIM(LTRIM(STR(RPAN8J,8))) as 'Add_No_Alternate_Payee',
RPDDJ as 'Date_Net_Due_Temp',
RTRIM(LTRIM(RPRMK)) as 'Name_Remark',
RTRIM(LTRIM(RPICUT)) as 'Batch_Type',
RTRIM(LTRIM(STR(RPICU,8))) as 'Batch_No',
RPDICJ as 'Batch_Date_Temp',
RTRIM(LTRIM(RPRSCO)) as 'Write_Off_Reason_Code',
RTRIM(LTRIM(STR(RPODOC,8))) as 'Doc_Original',
RTRIM(LTRIM(RPODCT)) as 'Doc_Type_Original',
RTRIM(LTRIM(RPOKCO)) as 'Doc_Co_Original_Order',
RTRIM(LTRIM(RPOSFX)) as 'Doc_Pay_Item_Original',
RTRIM(LTRIM(RPVINV)) as 'Supplier_Invoice_No',
RPPPDI as 'Date_Invoice_Printed_Temp',
RTRIM(LTRIM(RPTORG)) as 'Transaction_Originator',
RTRIM(LTRIM(RPUSER)) as 'User_ID',
RPJCL as 'Date_Invoice_Closed_Temp',
RTRIM(LTRIM(RPPID)) as 'Program_ID',
RPUPMJ as 'Date_Updated_Temp',
RTRIM(LTRIM(RPPO)) as 'Purchase_Order',
RTRIM(LTRIM(RPPDCT)) as 'Doc_Type_Purch_Order',
RTRIM(LTRIM(RPPKCO)) as 'Doc_Co_Purch_Order',
RTRIM(LTRIM(RPDCTO)) as 'Order_Type',
RPLNID/1000 as 'Line_No',
RTRIM(LTRIM(RPSKCO)) as 'Doc_Co_Sales_Order',
RTRIM(LTRIM(RPSFXO)) as 'Order_Suffix',
RTRIM(LTRIM(RPCO)) as 'Co',
RTRIM(LTRIM(RPGLC)) as 'GL_Offset',
RTRIM(LTRIM(RPAID)) as 'Acct_ID',
RTRIM(LTRIM(STR(RPPYR,8))) as 'Payor_Add_No',
RPADSC/100 as 'Disc_Available',
RPADSA/100 as 'Disc_Taken',
RPATXA/100 as 'Amt_Taxable',
RPATXN/100 as 'Amt_Non_Taxable',
RPSTAM/100 as 'Amt_Tax',
RTRIM(LTRIM(RPBCRC)) as 'Cur_Code_Base',
RTRIM(LTRIM(RPCRRM)) as 'Cur_Mode_For_or_Dom_Entr',
RTRIM(LTRIM(RPCRCD)) as 'Cur_Code_From',
RPCRR as 'Cur_Conv_Spot_Rate',
RTRIM(LTRIM(RPDMCD)) as 'Dom_Entr_wMult_Cur_Dist',
RPACR/100 as 'Amt_Currency',
RPFAP/100 as 'Amt_Foreign_Open',
RPCDS/100 as 'Amt_Foreign_Disc_Avail',
RPCDSA/100 as 'Amt_Foreign_Disc_Taken',
RPCTXA/100 as 'Amt_Foreign_Taxable',
RPCTXN/100 as 'Amt_Foreign_Non_Taxable',
RPCTAM/100 as 'Amt_Foreign_Tax',
RTRIM(LTRIM(RPTXA1)) as 'Tax_RateArea',
RTRIM(LTRIM(RPEXR1)) as 'Tax_Expl_Code_1',
RPDSVJ as 'Date_Service_Tax_Temp',
RTRIM(LTRIM(RPGLBA)) as 'GL_Bank_Acct',
RTRIM(LTRIM(RPAM)) as 'Acct_Mode_GL',
RTRIM(LTRIM(RPAID2)) as 'Acct_ID2',
RTRIM(LTRIM(RPAM2)) as 'Acct_Mode_GL2',
RTRIM(LTRIM(RPMCU)) as 'Business_Unit',
RTRIM(LTRIM(RPOBJ)) as 'Object_Acct',
RTRIM(LTRIM(RPSUB)) as 'Subsidiary',
RTRIM(LTRIM(RPSBLT)) as 'Subledger_Type',
RTRIM(LTRIM(RPSBL)) as 'Subledger_GL',
RPDDNJ as 'Dte_Disc_Due_Temp',
RPRDDJ as 'Dte_of_Last_Sent_Reminder_Temp',
RPRDSJ as 'Dte_Rem_Stop_Until_Dte_Temp',
RPLFCJ as 'Dte_Last_Fee_Calc_Temp',
RPSMTJ as 'Dte_Statement_Temp',
RTRIM(LTRIM(RPNBRR)) as 'No_of_Rmdrs_to_Send',
RTRIM(LTRIM(RPRDRL)) as 'Last_Sent_Reminder',
RPRMDS as 'No_of_Sent_Reminders',
RTRIM(LTRIM(RPCOLL)) as 'Collection_Report_YN',
RTRIM(LTRIM(RPCORC)) as 'Collection_Reason_Code',
RTRIM(LTRIM(RPAFC)) as 'Apply_Finance_Charges_YN',
RTRIM(LTRIM(RPDNLT)) as 'Delinquency_Notice_YN',
RPVLDT as 'Date_ClearedValue_Temp',
RTRIM(LTRIM(RPRF)) as 'Frequency_Recurring',
RPDRF as 'Recurring_Freq_of_Pmts',
RTRIM(LTRIM(RPCTL)) as 'ControlStatement_Field',
RTRIM(LTRIM(RPFNLP)) as 'Closed_Item_As_Of_Proc',
RPITM as 'Item_No_Short',
RPU/100 as 'Units',
RTRIM(LTRIM(RPUM)) as 'Unit_of_Measure',
RTRIM(LTRIM(RPALT6)) as 'GL_Pst_Cash_Basis_Acct',
RPVDGJ as 'Void_Date_For_GL_Temp',
RTRIM(LTRIM(RPVOD)) as 'Void_Flag',
RTRIM(LTRIM(STR(RPPYID,15))) as 'Pmt_ID_Internal',
RTRIM(LTRIM(RPJOBN)) as 'Work_Station_ID'
FROM %v_SCHEMA1%.F03B11 A 
LEFT JOIN (SELECT * 
FROM %v_SCHEMA1%.F03B14 A
LEFT JOIN %v_SCHEMA1%.F03B13 B ON A.RZPYID = B.RYPYID) B ON A.RPDOC = B.RZDOC and A.RPKCO = B.RZKCO and A.RPDCT = B.RZDCT and A.RPSFX = B.RZSFX
WHERE (A.RPCO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))
AND (A.RPDGJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.RPCO <> ''
 
COM *********************************************************
COM *** Import Sales Order Table
COM *********************************************************

SELECT RTRIM(LTRIM(STR(SDDOCO,8))) as 'Order No',
SDTRDJ as 'Order_Date_Temp',
RTRIM(LTRIM(SDDCTO)) as 'Order Type',
SDLNID/1000 as 'Line No',
RTRIM(LTRIM(SDKCOO)) as 'Order Co',
RTRIM(LTRIM(C.ABALPH)) as 'Name_Alpha', 
RTRIM(LTRIM(STR(SDAN8,8)) as 'Add No',
RTRIM(LTRIM(STR(SDSHAN,8)) as 'Add No Ship To',
RTRIM(LTRIM(STR(SDPA8,8)) as 'Add No Parent',
SDADDJ as 'Date_Actual_Ship_Date_Temp',
RTRIM(LTRIM(STR(SDDOC,8))) as 'Invoice No',
SDIVD as 'Invoice_Date_Temp',
SDDGL as 'GL_Date_Temp',
RTRIM(LTRIM(STR(SDITM,8))) as 'Item No Short',
RTRIM(LTRIM(SDLITM)) as 'Item No2',
RTRIM(LTRIM(SDAITM)) as 'Item No3',
RTRIM(LTRIM(SDDSC1)) as 'Descr',
RTRIM(LTRIM(SDDSC2)) as 'Descr Line 2',
RTRIM(LTRIM(SDUOM)) as 'Unit of Measure as Input',
SDUORG/1000 as 'Qty Ordered',
SDSOQS/1000 as 'Qty Shipped',
SDUOPN as 'Units Open',
SDQTYT/1000 as 'Units Shipped to Date',
SDUPRC/10000 as 'Amt Price per Unit',
SDAEXP/100 as 'Amt Extended Price',
SDAOPN/100 as 'Amt Open',
RTRIM(LTRIM(SDNXTR)) as 'Status Code Next',
RTRIM(LTRIM(SDLTTR)) as 'Status Code Last',
SDDRQJ as 'Date_Requested_Temp',
SDPDDJ as 'Date_Scheduled_Pick_Temp',
SDCNDJ as 'Date_Cancel_Temp',
SDRSDJ as 'Date_Promised_Delivery_Temp',
SDPEFJ as 'Date_Price_Effective_Date_Temp',
SDPPDJ as 'Date_Promised_Shipment_Temp',
RTRIM(LTRIM(SDPROV)) as 'Price Override Code',
RTRIM(LTRIM(SDPTC)) as 'Pmt Terms Code',
RTRIM(LTRIM(SDRYIN)) as 'Pmt Instrument',
RTRIM(LTRIM(STR(SDPSN,8))) as 'Pick Slip No',
RTRIM(LTRIM(STR(SDDELN,8))) as 'Delivery No',
SDQRLV as 'Units Relieved',
RTRIM(LTRIM(STR(SDANBY,8))) as 'Buyer No',
RTRIM(LTRIM(SDTORG)) as 'Trans Originator',
RTRIM(LTRIM(SDUSER)) as 'User ID',
RTRIM(LTRIM(SDPID)) as 'Program ID',
RTRIM(LTRIM(SDJOBN)) as 'Work Station ID',
SDUPMJ as 'Date_Updated_Temp',
RTRIM(LTRIM(SDLOCN)) as 'Location',
RTRIM(LTRIM(SDSFXO)) as 'Order Suffix',
RTRIM(LTRIM(SDMCU)) as 'Business Unit',
RTRIM(LTRIM(SDCO)) as 'Co',
RTRIM(LTRIM(SDRORN)) as 'PO SO WO No',
RTRIM(LTRIM(SDRCTO)) as 'PO SO WO Order Type',
SDRLLN/1000 as 'Related PO SO Line No',
RTRIM(LTRIM(SDDMCT)) as 'Agrmt No Distr',
SDDMCS as 'Agrmt Suppl Distr',
RTRIM(LTRIM(SDLNTY)) as 'Line Type',
RTRIM(LTRIM(SDEMCU)) as 'Business Unit Header',
RTRIM(LTRIM(SDRLIT)) as 'Item No Related Kit',
SDKTLN/1000 as 'Kit Master Line No',
SDCPNT/10 as 'Component Line No',
SDRKIT as 'Related Kit Component',
SDKTP as 'No of Component Per Parent',
RTRIM(LTRIM(SDSRP1)) as 'Sales Catalog Section',
RTRIM(LTRIM(SDSRP2)) as 'Sub Section',
RTRIM(LTRIM(SDPRP1)) as 'Commodity Class',
RTRIM(LTRIM(SDPRP2)) as 'Commodity Sub Class',
RTRIM(LTRIM(SDPRP3)) as 'Supplier Rebate Code',
RTRIM(LTRIM(SDPRP4)) as 'Master Planning Family',
RTRIM(LTRIM(SDPRP5)) as 'Purchasing Cat Code 5',
SDSOBK as 'Units Qty Backordered Held',
SDSOCN as 'Units Qty Canceled Scrapped',
SDSONE as 'Units Future Qty Committed',
RTRIM(LTRIM(SDCOMM)) as 'Committed H S',
RTRIM(LTRIM(SDTPC)) as 'Temporary Price Y N',
RTRIM(LTRIM(SDAPUM)) as 'UOM Entered for Unit Price',
SDLPRC/10000 as 'Amt List Price',
SDUNCS/10000 as 'Amt Unit Cost',
SDECST/100 as 'Amt Extended Cost',
RTRIM(LTRIM(SDCSTO)) as 'Cost Override Code',
SDTCST/10000 as 'Extended Cost Transfer',
RTRIM(LTRIM(SDINMG)) as 'Print Message',
RTRIM(LTRIM(SDDTBS)) as 'Based on Date',
SDTRDC/1000 as 'Disc Trade',
SDFUN2/10000 as 'Trade Disc Old',
RTRIM(LTRIM(SDASN)) as 'Price and Adj Schedule',
RTRIM(LTRIM(SDPRGR)) as 'Item Price Group',
RTRIM(LTRIM(SDCLVL)) as 'Pricing Cat Level',
SDCADC/1000 as 'Disc % Cash',
RTRIM(LTRIM(SDKCO)) as 'Doc Co',
RTRIM(LTRIM(SDDCT)) as 'Doc Type',
RTRIM(LTRIM(STR(SDODOC,8))) as 'Doc Original',
RTRIM(LTRIM(SDODCT)) as 'Doc Type Original',
RTRIM(LTRIM(SDOKC)) as 'Doc Co Original',
RTRIM(LTRIM(SDTAX1)) as 'Sales Taxable Y N',
RTRIM(LTRIM(SDTXA1)) as 'Tax Rate Area',
RTRIM(LTRIM(SDEXR1)) as 'Tax Expl Code 1',
RTRIM(LTRIM(SDATXT)) as 'Associated Text',
RTRIM(LTRIM(SDPRIO)) as 'Priority Processing',
RTRIM(LTRIM(SDRESL)) as 'Printed Code',
RTRIM(LTRIM(SDBACK)) as 'Backorders Allowed Y N',
RTRIM(LTRIM(SDSBAL)) as 'Substitutes Allowed Y N',
RTRIM(LTRIM(SDAPTS)) as 'Partial Line Shpmt Allow Y N',
RTRIM(LTRIM(SDLOB)) as 'Line of Business',
RTRIM(LTRIM(SDEUSE)) as 'End Use',
RTRIM(LTRIM(SDDTYS)) as 'Duty Status',
RTRIM(LTRIM(SDNTR)) as 'Nature of Trans',
RTRIM(LTRIM(STR(SDVEND,8))) as 'Primary Last Supplier No',
RTRIM(LTRIM(STR(SDCARS,8))) as 'Carrier No',
RTRIM(LTRIM(SDMOT)) as 'Mode of Transport',
RTRIM(LTRIM(SDROUT)) as 'Route Code',
RTRIM(LTRIM(SDSTOP)) as 'Stop Code',
RTRIM(LTRIM(SDZON)) as 'Zone No',
RTRIM(LTRIM(SDCNID)) as 'Container I D',
RTRIM(LTRIM(SDFRTH)) as 'Freight Handling Code',
RTRIM(LTRIM(SDSHCM)) as 'Shipping Commodity Class',
RTRIM(LTRIM(SDSHCN)) as 'Shipping Conditions Code',
RTRIM(LTRIM(SDSERN)) as 'Serial No Lot',
RTRIM(LTRIM(SDUPC1)) as 'Price Code 1',
RTRIM(LTRIM(SDUPC2)) as 'Price Code 2',
RTRIM(LTRIM(SDUPC3)) as 'Price Code 3',
'Detail' as 'Sales_Order_Table'
FROM %v_SCHEMA1%.F4211 A
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.SDAN8 = C.ABAN8
WHERE(A.SDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))  
AND (A.SDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.SDKCOO <> ''
UNION ALL
SELECT RTRIM(LTRIM(STR(SDDOCO,8))) as 'Order No',
SDTRDJ as 'Order_Date_Temp',
RTRIM(LTRIM(SDDCTO)) as 'Order Type',
SDLNID/1000 as 'Line No',
RTRIM(LTRIM(SDKCOO)) as 'Order Co',
RTRIM(LTRIM(C.ABALPH)) as 'Name_Alpha', 
RTRIM(LTRIM(STR(SDAN8,8))) as 'Add No',
RTRIM(LTRIM(STR(SDSHAN,8))) as 'Add No Ship To',
RTRIM(LTRIM(STR(SDPA8,8))) as 'Add No Parent',
SDADDJ as 'Date_Actual_Ship_Date_Temp',
RTRIM(LTRIM(STR(SDDOC,8))) as 'Invoice No',
SDIVD as 'Invoice_Date_Temp',
SDDGL as 'GL_Date_Temp',
RTRIM(LTRIM(STR(SDITM,8))) as 'Item No Short',
RTRIM(LTRIM(SDLITM)) as 'Item No2',
RTRIM(LTRIM(SDAITM)) as 'Item No3',
RTRIM(LTRIM(SDDSC1)) as 'Descr',
RTRIM(LTRIM(SDDSC2)) as 'Descr Line 2',
RTRIM(LTRIM(SDUOM)) as 'Unit of Measure as Input',
SDUORG/1000 as 'Qty Ordered',
SDSOQS/1000 as 'Qty Shipped',
SDUOPN as 'Units Open',
SDQTYT/1000 as 'Units Shipped to Date',
SDUPRC/10000 as 'Amt Price per Unit',
SDAEXP/100 as 'Amt Extended Price',
SDAOPN/100 as 'Amt Open',
RTRIM(LTRIM(SDNXTR)) as 'Status Code Next',
RTRIM(LTRIM(SDLTTR)) as 'Status Code Last',
SDDRQJ as 'Date_Requested_Temp',
SDPDDJ as 'Date_Scheduled_Pick_Temp',
SDCNDJ as 'Date_Cancel_Temp',
SDRSDJ as 'Date_Promised_Delivery_Temp',
SDPEFJ as 'Date_Price_Effective_Date_Temp',
SDPPDJ as 'Date_Promised_Shipment_Temp',
RTRIM(LTRIM(SDPROV)) as 'Price Override Code',
RTRIM(LTRIM(SDPTC)) as 'Pmt Terms Code',
RTRIM(LTRIM(SDRYIN)) as 'Pmt Instrument',
RTRIM(LTRIM(STR(SDPSN,8))) as 'Pick Slip No',
RTRIM(LTRIM(STR(SDDELN,8))) as 'Delivery No',
SDQRLV as 'Units Relieved',
RTRIM(LTRIM(STR(SDANBY,8))) as 'Buyer No',
RTRIM(LTRIM(SDTORG)) as 'Trans Originator',
RTRIM(LTRIM(SDUSER)) as 'User ID',
RTRIM(LTRIM(SDPID)) as 'Program ID',
RTRIM(LTRIM(SDJOBN)) as 'Work Station ID',
SDUPMJ as 'Date_Updated_Temp',
RTRIM(LTRIM(SDLOCN)) as 'Location',
RTRIM(LTRIM(SDSFXO)) as 'Order Suffix',
RTRIM(LTRIM(SDMCU)) as 'Business Unit',
RTRIM(LTRIM(SDCO)) as 'Co',
RTRIM(LTRIM(SDRORN)) as 'PO SO WO No',
RTRIM(LTRIM(SDRCTO)) as 'PO SO WO Order Type',
SDRLLN/1000 as 'Related PO SO Line No',
RTRIM(LTRIM(SDDMCT)) as 'Agrmt No Distr',
SDDMCS as 'Agrmt Suppl Distr',
RTRIM(LTRIM(SDLNTY)) as 'Line Type',
RTRIM(LTRIM(SDEMCU)) as 'Business Unit Header',
RTRIM(LTRIM(SDRLIT)) as 'Item No Related Kit',
SDKTLN/1000 as 'Kit Master Line No',
SDCPNT/10 as 'Component Line No',
SDRKIT as 'Related Kit Component',
SDKTP as 'No of Component Per Parent',
RTRIM(LTRIM(SDSRP1)) as 'Sales Catalog Section',
RTRIM(LTRIM(SDSRP2)) as 'Sub Section',
RTRIM(LTRIM(SDPRP1)) as 'Commodity Class',
RTRIM(LTRIM(SDPRP2)) as 'Commodity Sub Class',
RTRIM(LTRIM(SDPRP3)) as 'Supplier Rebate Code',
RTRIM(LTRIM(SDPRP4)) as 'Master Planning Family',
RTRIM(LTRIM(SDPRP5)) as 'Purchasing Cat Code 5',
SDSOBK as 'Units Qty Backordered Held',
SDSOCN as 'Units Qty Canceled Scrapped',
SDSONE as 'Units Future Qty Committed',
RTRIM(LTRIM(SDCOMM)) as 'Committed H S',
RTRIM(LTRIM(SDTPC)) as 'Temporary Price Y N',
RTRIM(LTRIM(SDAPUM)) as 'UOM Entered for Unit Price',
SDLPRC/10000 as 'Amt List Price',
SDUNCS/10000 as 'Amt Unit Cost',
SDECST/100 as 'Amt Extended Cost',
RTRIM(LTRIM(SDCSTO)) as 'Cost Override Code',
SDTCST/10000 as 'Extended Cost Transfer',
RTRIM(LTRIM(SDINMG)) as 'Print Message',
RTRIM(LTRIM(SDDTBS)) as 'Based on Date',
SDTRDC/1000 as 'Disc Trade',
SDFUN2/10000 as 'Trade Disc Old',
RTRIM(LTRIM(SDASN)) as 'Price and Adj Schedule',
RTRIM(LTRIM(SDPRGR)) as 'Item Price Group',
RTRIM(LTRIM(SDCLVL)) as 'Pricing Cat Level',
SDCADC/1000 as 'Disc % Cash',
RTRIM(LTRIM(SDKCO)) as 'Doc Co',
RTRIM(LTRIM(SDDCT)) as 'Doc Type',
RTRIM(LTRIM(STR(SDODOC,8))) as 'Doc Original',
RTRIM(LTRIM(SDODCT)) as 'Doc Type Original',
RTRIM(LTRIM(SDOKC)) as 'Doc Co Original',
RTRIM(LTRIM(SDTAX1)) as 'Sales Taxable Y N',
RTRIM(LTRIM(SDTXA1)) as 'Tax Rate Area',
RTRIM(LTRIM(SDEXR1)) as 'Tax Expl Code 1',
RTRIM(LTRIM(SDATXT)) as 'Associated Text',
RTRIM(LTRIM(SDPRIO)) as 'Priority Processing',
RTRIM(LTRIM(SDRESL)) as 'Printed Code',
RTRIM(LTRIM(SDBACK)) as 'Backorders Allowed Y N',
RTRIM(LTRIM(SDSBAL)) as 'Substitutes Allowed Y N',
RTRIM(LTRIM(SDAPTS)) as 'Partial Line Shpmt Allow Y N',
RTRIM(LTRIM(SDLOB)) as 'Line of Business',
RTRIM(LTRIM(SDEUSE)) as 'End Use',
RTRIM(LTRIM(SDDTYS)) as 'Duty Status',
RTRIM(LTRIM(SDNTR)) as 'Nature of Trans',
RTRIM(LTRIM(STR(SDVEND,8))) as 'Primary Last Supplier No',
RTRIM(LTRIM(STR(SDCARS,8))) as 'Carrier No',
RTRIM(LTRIM(SDMOT)) as 'Mode of Transport',
RTRIM(LTRIM(SDROUT)) as 'Route Code',
RTRIM(LTRIM(SDSTOP)) as 'Stop Code',
RTRIM(LTRIM(SDZON)) as 'Zone No',
RTRIM(LTRIM(SDCNID)) as 'Container I D',
RTRIM(LTRIM(SDFRTH)) as 'Freight Handling Code',
RTRIM(LTRIM(SDSHCM)) as 'Shipping Commodity Class',
RTRIM(LTRIM(SDSHCN)) as 'Shipping Conditions Code',
RTRIM(LTRIM(SDSERN)) as 'Serial No Lot',
RTRIM(LTRIM(SDUPC1)) as 'Price Code 1',
RTRIM(LTRIM(SDUPC2)) as 'Price Code 2',
RTRIM(LTRIM(SDUPC3)) as 'Price Code 3',
'History' as 'Sales_Order_Table'
FROM %v_SCHEMA1%.F42119 B
LEFT JOIN %v_SCHEMA1%.F0101 C ON B.SDAN8 = C.ABAN8
WHERE (B.SDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))  
AND (B.SDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND B.SDKCOO <> ''
