COM *********************************************************
COM *** Import Vendor Master Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM A.A6AN8),1,8) as "Add_No", 
C.ABALPH as "Name_Alpha", 
A.A6TRAP as "Pmt_Term_AP", 
A.A6PYIN as "Pmt_Instrument",
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
C.ABSIC as "Industry_Class_Code", 
C.ABDC as "Descr_Compressed", 
C.ABEFTB as "Date_Beginning_Eff_Temp", 
D.WPPH1 as "Phone_No",
E.PNPTD as "Descr_Pmt_Terms", 
E.PNNDTP as "Net_Days_to_Pay",
F.AYCBNK as "Bank_Acct_No_Customer", 
F.AYCTR as "Bank_Acct_Country",
F.AYBKTP as  "Record_Type_Bank_Transit", 
F.AYDL01 as "Descr", 
F.AYAID as "Account_ID", 
F.AYSWFT as "SWIFT_Code", 
F.AYCKSV as "Checking_or_Savings_Act"
FROM %v_SCHEMA1%.F0401 A
LEFT JOIN (SELECT DISTINCT(A.ALAN8), A.ALUPMJ, A.ALUPMT, A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR, B.maxDate, B.maxTime, B.Seq
FROM %v_SCHEMA1%.F0116 A
INNER JOIN (SELECT DISTINCT(A.ALAN8), A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR,
            MAX(A.ALUPMJ) AS maxDate,  MAX(A.ALUPMT) AS maxTime, row_number() over(partition by A.ALAN8 order by A.ALUPMJ desc) Seq
            FROM %v_SCHEMA1%.F0116 A
            GROUP BY A.ALAN8, A.ALUPMJ, A.ALUPMT, A.ALADD1, A.ALADD2, A.ALADD3, A.ALADD4, A.ALCTY1, A.ALADDS, A.ALCOUN, A.ALADDZ, A.ALCTR) B
    ON A.ALAN8 = B.ALAN8
        AND A.ALUPMJ = B.maxDate
        AND A.ALUPMT = B.maxTime
        WHERE Seq = 1) B ON A.A6AN8 = B.ALAN8
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.A6AN8 = C.ABAN8
LEFT JOIN (SELECT DISTINCT(A.WPAN8), A.WPUPMJ, A.WPUPMT, A.WPPH1, B.maxDate, B.maxTime, B.Seq
FROM %v_SCHEMA1%.F0115 A
INNER JOIN (SELECT DISTINCT(A.WPAN8), A.WPPH1, MAX(A.WPUPMJ) AS maxDate,  MAX(A.WPUPMT) AS maxTime, row_number() over(partition by A.WPAN8 order by A.WPUPMJ desc) Seq
            FROM %v_SCHEMA1%.F0115 A
            GROUP BY A.WPAN8, A.WPUPMJ, A.WPUPMT, A.WPPH1) B
    ON A.WPAN8 = B.WPAN8
        AND A.WPUPMJ = B.maxDate
        AND A.WPUPMT = B.maxTime
        AND A.WPPH1 = B.WPPH1
        WHERE Seq = 1) D ON A.A6AN8 = D.WPAN8
LEFT JOIN %v_SCHEMA1%.F0014 E ON A.A6TRAP = E.PNPTC
LEFT JOIN (SELECT A.AYAN8, A.AYCBNK, A.AYBKTP, A.AYDL01, A.AYSWFT, A.AYCKSV, A.AYAID, A.Seq
FROM 
(SELECT A.AYAN8, A.AYCBNK, A.AYBKTP, A.AYDL01, A.AYSWFT, A.AYCKSV, A.AYAID, ROW_NUMBER() OVER (PARTITION BY AYAN8 ORDER BY AYAN8 DESC) AS Seq
FROM %v_SCHEMA1%.F0030 A) A
WHERE Seq=1) F ON A.A6AN8 = F.AYAN8
WHERE A.A6AN8<>0 and
C.ABAT1 = %v_Vendor_SearchType% and 
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
ORDER BY A.A6AN8

COM *********************************************************
COM *** Import Purchase Order Detail Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM PDDOCO),1,8) as "Order No",
PDTRDJ as "Order_Date_Temp",
TRIM(' ' FROM PDKCOO) as "Order Co",
TRIM(' ' FROM PDDCTO) as "Order Type",
PDLNID/1000 as "Line No",
SUBSTR(TRIM(' ' FROM PDAN8),1,8) as "Add No",
TRIM(' ' FROM B.ABALPH) as "Name_Alpha", 
SUBSTR(TRIM(' ' FROM PDSHAN),1,8) as "Add No Ship To",
PDDGL as "GL_Date_Temp",
TRIM(' ' FROM PDLNTY) as "Line Type",
TRIM(' ' FROM PDPTC) as "Pmt Terms Code",
TRIM(' ' FROM PDNXTR) as "Status Code Next",
TRIM(' ' FROM PDLTTR) as "Status Code Last",
TRIM(' ' FROM PDVR01) as "Contract Number",
TRIM(' ' FROM PDVR02) as "Contract Supplement",
SUBSTR(TRIM(' ' FROM PDITM),1,8) as "Item No Short",
TRIM(' ' FROM PDLITM) as "Item No2",
TRIM(' ' FROM PDAITM) as "Item No3",
TRIM(' ' FROM PDDSC1) as "Descr",
TRIM(' ' FROM PDDSC2) as "Descr Line 2",
PDUORG/1000 as "Qty Ordered",
PDUREC/1000 as "Units Received",
PDUCHG as "Units On Hold",
PDUOPN/1000 as "Units Open",
PDAEXP/100 as "Amt Ext Price",
PDAOPN/100 as "Amt Open",
PDACHG/100 as "Amt On Hold",
PDAREC/100 as "Amt Received",
TRIM(' ' FROM PDCRCD) as "Cur Code From",
PDCRR as "Cur Conversion Rate",
PDFRRC/10000 as "Foreign Unit Price",
PDFEA/100 as "Foreign Extended Price Amt",
PDFUC/10000 as "Foreign Unit Cost",
PDFEC/100 as "Foreign Extended Cost",
PDFCHG/100 as "Foreign Changed Amt",
PDFAP/100 as "Foreign Open Amt",
PDFREC/100 as "Received Foreign Amt",
TRIM(' ' FROM PDLOCN) as "Location",
SUBSTR(TRIM(' ' FROM PDANBY),1,8) as "Buyer No",
TRIM(' ' FROM PDSFXO) as "Order Suffix",
TRIM(' ' FROM PDMCU) as "Business Unit",
TRIM(' ' FROM PDCO) as "Co",
TRIM(' ' FROM PDOKCO) as "Doc Co Original Order",
TRIM(' ' FROM PDOORN) as "Original Order No",
TRIM(' ' FROM PDOCTO) as "Original Order Type",
PDOGNO/1000 as "Original Line No",
TRIM(' ' FROM PDRORN) as "Related PO SO WO No",
TRIM(' ' FROM PDRCTO) as "Related PO SO WO Order Type",
PDRLLN/1000 as "Related PO SO Line No",
PDDRQJ as "Date_Requested_Temp",
PDPDDJ as "Date_Scheduled_Pick_Temp",
PDOPDJ as "Date_Orig_Promised_Deliv_Temp",
PDADDJ as "Date_Actual_Ship_Date_Temp",
PDCNDJ as "Date_Cancel_Temp",
PDPEFJ as "Date_Price_Effective_Date_Temp",
PDPPDJ as "Date_Promised_Shipment_Temp",
PDPSDJ as "Date_Future_Date_2_Temp",
PDDSVJ as "Date_Service_Tax_Temp",
PDPN as "Period No General Ledger",
TRIM(' ' FROM PDLOTN) as "Lot Serial No",
TRIM(' ' FROM PDFRGD) as "From Grade",
TRIM(' ' FROM PDTHGD) as "Thru Grade",
PDFRMP/1000 as "From Potency",
PDTHRP/1000 as "Thru Potency",
TRIM(' ' FROM PDRLIT) as "Item No Related Kit",
TRIM(' ' FROM PDUOM) as "UOM as Input",
PDCREC as "Units Cumulative Received",
PDURLV as "Units Relieved",
PDPRRC/10000 as "Amt Unit Cost",
PDARLV/100 as "Amt Relieved",
PDFTN1/100 as "Amt Tax Commitment",
PDTRLV/100 as "Amt Tax Relieved",
TRIM(' ' FROM PDPROV) as "Price Override Code",
PDAMC3/10000 as "Unit Cost Pur",
PDECST/100 as "Amt Ext Cost",
TRIM(' ' FROM PDCSTO) as "Cost Override Code",
TRIM(' ' FROM PDCSMP) as "Costing Method Pur",
TRIM(' ' FROM PDINMG) as "Print Message",
TRIM(' ' FROM PDASN) as "Price and Adj Schedule",
TRIM(' ' FROM PDPRGR) as "Item Price Group",
TRIM(' ' FROM PDCLVL) as "Pricing Cat Level",
TRIM(' ' FROM PDCATN) as "Catalog",
PDDSPR/10000 as "Disc Factor",
TRIM(' ' FROM PDTX) as "Pur Taxable Y N",
TRIM(' ' FROM PDCNID) as "Container I D",
TRIM(' ' FROM PDCDCD) as "Commodity Code",
TRIM(' ' FROM PDNTR) as "Nature of Transaction",
TRIM(' ' FROM PDFRTH) as "Freight Handling Code",
TRIM(' ' FROM PDFRTC) as "Freight Calculated Y N",
TRIM(' ' FROM PDZON) as "Zone No",
TRIM(' ' FROM PDFRAT) as "Rate Code Frieght Misc",
TRIM(' ' FROM PDRATT) as "Rate Type Freight Misc",
SUBSTR(TRIM(' ' FROM PDANCR),1,8) as "Carrier No",
TRIM(' ' FROM PDMOT) as "Mode of Transport",
TRIM(' ' FROM PDCOT) as "Conditions of Transport",
TRIM(' ' FROM PDSHCM) as "Ship Commodity Class",
TRIM(' ' FROM PDSHCN) as "Ship Conditions Code",
TRIM(' ' FROM PDUOM1) as "UOM Primary",
PDPQOR as "Units Pri Qty Ordered",
TRIM(' ' FROM PDUOM2) as "UOM Secondary",
PDSQOR as "Units Sec Qty Ordered",
TRIM(' ' FROM PDUOM3) as "UOM Pur",
TRIM(' ' FROM PDVLUM) as "Volume UOM",
TRIM(' ' FROM PDGLC) as "G L Offset",
PDCTRY as "Century",
PDFY as "Fiscal Year",
TRIM(' ' FROM PDSTTS) as "Line Status",
TRIM(' ' FROM PDRCD) as "Reason Code",
TRIM(' ' FROM PDFUF1) as "AIA Doc Flag",
TRIM(' ' FROM PDFUF2) as "Post Quantities",
TRIM(' ' FROM PDOMCU) as "Project Business Unit",
TRIM(' ' FROM PDOBJ) as "Object Acct",
TRIM(' ' FROM PDSUB) as "Subsidiary",
TRIM(' ' FROM PDSBLT) as "Subledger Type",
TRIM(' ' FROM PDSBL) as "Subledger G L",
TRIM(' ' FROM PDASID) as "Serial No",
PDCCMP as "Cost Component No",
TRIM(' ' FROM PDTAG) as "Tag Ref",
TRIM(' ' FROM PDARTG) as "Code Approval Routing",
SUBSTR(TRIM(' ' FROM PDCORD),1,3) as "Change Order No",
TRIM(' ' FROM PDCHDT) as "Change Order Type",
PDDOCC as "Doc Change Order",
TRIM(' ' FROM PDTORG) as "Transaction Originator",
TRIM(' ' FROM PDUSER) as "User ID",
TRIM(' ' FROM PDPID) as "Program ID",
TRIM(' ' FROM PDJOBN) as "Work Station ID",
PDUPMJ as "Date_Updated_Temp"      
FROM %v_SCHEMA1%.F4311 A 
LEFT JOIN %v_SCHEMA1%.F0101 B ON A.PDAN8 = B.ABAN8
WHERE (A.PDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (A.PDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.PDKCOO <> ' '

COM *********************************************************
COM *** Import Purchase Order Receiving Table
COM *********************************************************

SELECT TRIM(' ' FROM PRMATC) as "Type Match Record Type",
SUBSTR(TRIM(' ' FROM PRDOCO),1,8) as "PO Order No",
PRTRDJ as "Order_Date_Temp",
SUBSTR(TRIM(' ' FROM PRAN8),1,8) as "Add No",
TRIM(' ' FROM B.ABALPH) as "Name_Alpha", 
TRIM(' ' FROM PRKCOO) as "Order Co Order No",
TRIM(' ' FROM PRDCTO) as "Order Type",
PRLNID/1000 as "Line No",
SUBSTR(TRIM(' ' FROM PRITM),1,8) as "Item No Short",
TRIM(' ' FROM PRLITM) as "Item No2",
TRIM(' ' FROM PRAITM) as "Item No3",
PRRCDJ as "Date_Received_Temp",
PRUORG/1000 as "Units Order Trans Qty",
PRUPTD/1000 as "Units Paid to Date",
PRUREC/1000 as "Units Received",
PRUOPN/1000 as "Units Open",
PRQTYR as "Units Returned",
PRECST/100 as "Amt Extended Cost",
PRAPTD/100 as "Amt Paid to Date",
PRAOPN/100 as "Amt Open",
PRAREC/100 as "Amt Received",
TRIM(' ' FROM PRCRCD) as "Cur Code From",
PRCRR as "Cur Conversion Rate",
PRFRRC/10000 as "Foreign Unit Price",
PRFEC/100 as "Foreign Extended Price Amt",
PRFAP/100 as "Foreign Open Amt",
PRFAPT/100 as "Foreign Amt Paid to Date",
PRFREC/100 as "Received Foreign Amt",
PRFCLO/100 as "Foreign Closed Amt",
PRDRQJ as "Date_Requested_Temp",
PRPDDJ as "Date_Scheduled_Pick_Temp",
TRIM(' ' FROM PRNXTR) as "Status Code Next",
TRIM(' ' FROM PRLTTR) as "Status Code Last",
TRIM(' ' FROM PRVINV) as "Supplier Invoice No",
TRIM(' ' FROM PRPTC) as "Pmt Terms Code",
SUBSTR(TRIM(' ' FROM PRDOC),1,8) as "Invoice No",
TRIM(' ' FROM PRDCT) as "Doc Type",
TRIM(' ' FROM PRSFX) as "Doc Pay Item",
PRDGL as "GL_Date_Temp",
TRIM(' ' FROM PRSFXO) as "Order Suffix",
PRNLIN as "No of Lines",
PRALIN as "Line Associated",
TRIM(' ' FROM PRRTBY) as "Written By Program",
TRIM(' ' FROM PRDMCT) as "Agreement No Distribution",
PRDMCS as "Agreement Supp Distribution",
TRIM(' ' FROM PRBALU) as "Contract Balances Upd Y N",
TRIM(' ' FROM PRIMCU) as "Item Business Unit",
TRIM(' ' FROM PRLOCN) as "Location",
TRIM(' ' FROM PRLOTN) as "Lot Serial No",
TRIM(' ' FROM PRLOTG) as "Lot Grade",
PRLOTP/1000 as "Lot Potency",
TRIM(' ' FROM PRVRMK) as "Supplier Remark",
TRIM(' ' FROM PRCNID) as "Container I D",
PROPDJ as "Date_Orig_Promised_Deliv_Temp",
TRIM(' ' FROM PRRCD) as "Reason Code",
TRIM(' ' FROM PRPST) as "Pay Status Code",
TRIM(' ' FROM PRLAND) as "Code Landed Cost",
TRIM(' ' FROM PRPRP5) as "Purchasing Cat Code 5",
TRIM(' ' FROM PRLVLA) as "Level Cost",
TRIM(' ' FROM PRILOG) as "Code Invoice Logging",
TRIM(' ' FROM PRDLOG) as "Final Rcpt Flag Y or BLANK",
TRIM(' ' FROM PRRTGC) as "Routing Process Y N",
TRIM(' ' FROM PRRCPF) as "Leadtime Recalculated Y N",
TRIM(' ' FROM PRAVCH) as "Code Eval Receipt Settlement",
TRIM(' ' FROM PRLNTY) as "Line Type",
TRIM(' ' FROM PRGLC) as "G L Offset",
TRIM(' ' FROM PRMCU) as "Business Unit",
TRIM(' ' FROM PRCO) as "Co",
TRIM(' ' FROM PRAID) as "Acct ID",
TRIM(' ' FROM PRANI) as "Acct No Input Mode Unknown",
TRIM(' ' FROM PROMCU) as "Project Business Unit",
TRIM(' ' FROM PROBJ) as "Object Acct",
TRIM(' ' FROM PRSUB) as "Subsidiary",
TRIM(' ' FROM PRASID) as "Serial No",
TRIM(' ' FROM PRSBL) as "Subledger G L",
TRIM(' ' FROM PRSBLT) as "Subledger Type",
TRIM(' ' FROM PRKCO) as "Doc Co",
PRJELN as "Journal Entry Line No",
TRIM(' ' FROM PRVANI) as "Acct No Rec Not Vouchered",
TRIM(' ' FROM PRTX) as "Purchasing Taxable Y N",
TRIM(' ' FROM PREXR1) as "Tax Expl Code 1",
TRIM(' ' FROM PRTXA1) as "Tax Rate Area",
TRIM(' ' FROM PRUOM) as "UOM as Input",
PRUCLO as "Units Closed",
PRQTYS as "Units Stocked",
PRQTYW as "Units Reworked",
PRQTYC as "Units Scrapped",
PRQTYJ as "Units Rejected",
PRQTYA as "Units Adjusted",
TRIM(' ' FROM PRUOM3) as "UOM Purchasing",
PRPRRC/10000 as "Amt Unit Cost",
PRACLO/100 as "Amt Closed",
TRIM(' ' FROM PRTORG) as "Trans Originator",
TRIM(' ' FROM PRUSER) as "User ID",
TRIM(' ' FROM PRPID) as "Program ID",
TRIM(' ' FROM PRJOBN) as "Work Station ID",
TRIM(' ' FROM PRTERM) as "Terminal Identification",
PRUPMJ as "Date_Updated_Temp",
PRTDAY as "Time of Day"  
FROM %v_SCHEMA1%.F43121 A 
LEFT JOIN %v_SCHEMA1%.F0101 B ON A.PRAN8 = B.ABAN8
WHERE (A.PRKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))
AND (A.PRTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.PRKCOO <> ' '

COM *********************************************************
COM *** Import Accounts Payable Table
COM *********************************************************

SELECT SUBSTR(TRIM(' ' FROM RPDOC),1,8) as "Invoice No",
RPDIVJ as "Invoice_Date_Temp",
TRIM(' ' FROM RPKCO) as "Doc Co",
TRIM(' ' FROM RPDCT) as "Doc Type",
TRIM(' ' FROM RPSFX) as "Doc Pay Item",
SUBSTR(TRIM(' ' FROM RPAN8),1,8) as "Add No",
TRIM(' ' FROM C.ABALPH) as "Name_Alpha", 
RPAG/100 as "Amt Gross",
RPAAP/100 as "Amt Open",
RNPAAP/100 as "Pmt Amt",
RNPFAP/100 as "Pmt Amt Foreign",
RMVLDT as "Cleared_Date_Temp",
TRIM(' ' FROM RMCBNK) as "Bank Acct No Vendor",
RMDMTJ as "Date_Match_Check_or_Item_Temp",
SUBSTR(TRIM(' ' FROM RPPYE),1,8) as "Payee Add No",
TRIM(' ' FROM RPRMK) as "Name Remark",
SUBSTR(TRIM(' ' FROM RPSNTO),1,8) as "Add No Approver",
RPDSVJ as "Date_Service_Tax_Temp",
RPDDJ as "Date_Net_Due_Temp",
RPDDNJ as "Date_Disc_Due_Julian_Temp",
RPDGJ as "GL_Date_Temp",
RPFY as "Fiscal Year",
RPCTRY as "Century",
RPPN as "Period No General Ledger",
TRIM(' ' FROM RPCO) as "Co",
SUBSTR(TRIM(' ' FROM RPICU),1,8) as "Batch No",
TRIM(' ' FROM RPICUT) as "Batch Type",
RPDICJ as "Date_Batch_Julian_Temp",
TRIM(' ' FROM RPBALJ) as "Balanced Journal Entries",
TRIM(' ' FROM RPPST) as "Pay Status Code",
RPADSC/100 as "Disc Available",
RPADSA/100 as "Disc Taken",
RPATXA/100 as "Amt Taxable",
RPATXN/100 as "Amt Non Taxable",
RPSTAM/100 as "Amt Tax",
TRIM(' ' FROM RPTXA1) as "Tax Rate Area",
TRIM(' ' FROM RPEXR1) as "Tax Expl Code 1",
TRIM(' ' FROM RPCRRM) as "Cur Mode Foreign Dom Entry",
TRIM(' ' FROM RPCRCD) as "Cur Code From",
RPCRR as "Cur Conversion Rate Spot Rate",
RPACR/100 as "Amt Cur",
RPFAP/100 as "Amt Foreign Open",
RPCDS/100 as "Amt Foreign Disc Available",
RPCDSA/100 as "Amt Foreign Disc Taken",
RPCTXA/100 as "Amt Foreign Taxable",
RPCTXN/100 as "Amt Foreign Non Taxable",
RPCTAM/100 as "Amt Foreign Tax",
RPSFXE as "Pay Item Extension No",
TRIM(' ' FROM RPDCTA) as "Doc Type Adjusting",
TRIM(' ' FROM RPGLC) as "G L Offset",
TRIM(' ' FROM RPGLBA) as "G L Bank Acct",
TRIM(' ' FROM RPPOST) as "G L Posted Code",
TRIM(' ' FROM RPAM) as "Acct Mode G L",
TRIM(' ' FROM RPAID2) as "Acct ID",
TRIM(' ' FROM RPMCU) as "Business Unit",
TRIM(' ' FROM RPOBJ) as "Object Acct",
TRIM(' ' FROM RPSUB) as "Subsidiary",
TRIM(' ' FROM RPSBLT) as "Subledger Type",
TRIM(' ' FROM RPSBL) as "Subledger G L",
TRIM(' ' FROM RPBAID) as "Bank Transit Short ID",
TRIM(' ' FROM RPPTC) as "Pmt Terms Code",
TRIM(' ' FROM RPVOD) as "Void Flag",
TRIM(' ' FROM RPOKCO) as "Doc Co Original Order",
TRIM(' ' FROM RPODCT) as "Doc Type Original",
SUBSTR(TRIM(' ' FROM RPODOC),1,8) as "Doc Original",
TRIM(' ' FROM RPOSFX) as "Doc Pay Item Original",
TRIM(' ' FROM RPCRC) as "Pmt Handling Code",
TRIM(' ' FROM RPVINV) as "Supplier Invoice No",
TRIM(' ' FROM RPPKCO) as "Doc Co Purchase Order",
TRIM(' ' FROM RPPO) as "Purchase Order",
TRIM(' ' FROM RPPDCT) as "Doc Type Purchase Order",
RPLNID/1000 as "Line No",
TRIM(' ' FROM RPSFXO) as "Order Suffix",
RPOPSQ/100 as "Sequence No Operations",
TRIM(' ' FROM RPVR01) as "Reference",
TRIM(' ' FROM RPUNIT) as "Unit",
TRIM(' ' FROM RPMCU2) as "Business Unit 2",
TRIM(' ' FROM RPRF) as "Frequency Recurring",
RPDRF as "Recurring Freq of Pmts",
TRIM(' ' FROM RPCTL) as "Control Statement Field",
TRIM(' ' FROM RPFNLP) as "Closed Item As Of Processing",
RPU/100 as "Units",
TRIM(' ' FROM RPUM) as "UOM",
TRIM(' ' FROM RPPYIN) as "Pmt Instrument",
TRIM(' ' FROM RPTXA3) as "Tax Rate Area 3 Withholding",
TRIM(' ' FROM RPEXR3) as "Tax Expl Code 3 Withholding",
TRIM(' ' FROM RPRP1) as "AR AP Miscellaneous Code 1",
TRIM(' ' FROM RPRP2) as "AR AP Miscellaneous Code 2",
TRIM(' ' FROM RPRP3) as "AR AP Cash Rcpts Inv Reg Code",
TRIM(' ' FROM RPAC07) as "Cat Code Add Book 07",
TRIM(' ' FROM RPTNN) as "Flag for 1099",
TRIM(' ' FROM RPDMCD) as "Dom Entry w Mult Cur Distr",
SUBSTR(TRIM(' ' FROM RPITM),1,8) as "Item No Short",
RPHCRR as "Historical Cur Conv Rate",
RPHDGJ as "Historical_Date_Julian_Temp",
TRIM(' ' FROM RPTORG) as "Transaction Originator",
TRIM(' ' FROM RPUSER) as "User ID",
TRIM(' ' FROM RPPID) as "Program ID",
RPUPMJ as "Date_Updated_Temp",
RPUPMT as "Time Last Updated",
TRIM(' ' FROM RPJOBN) as "Work Station ID"
FROM %v_SCHEMA1%.F0411 A 
LEFT JOIN (SELECT * 
FROM %v_SCHEMA1%.F0414 A
LEFT JOIN %v_SCHEMA1%.F0413 B ON A.RNPYID = B.RMPYID) B ON A.RPDOC = B.RNDOC and A.RPCO = B.RNCO and A.RPDCT = B.RNDCT and A.RPSFX = B.RNSFX
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.RPAN8 = C.ABAN8
WHERE (A.RPCO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%))
AND (A.RPDGJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.RPCO <> ' '
