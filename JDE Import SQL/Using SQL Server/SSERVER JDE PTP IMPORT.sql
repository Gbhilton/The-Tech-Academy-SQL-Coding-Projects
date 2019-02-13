COM *********************************************************
COM *** Import Vendor Master Table
COM *********************************************************

SELECT LTRIM(STR(A.A6AN8,8)) as 'Add_No', 
C.ABALPH as 'Name_Alpha', 
A.A6TRAP as 'Pmt_Term_AP', 
A.A6PYIN as 'Pmt_Instrument',
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
LTRIM(C.ABALKY) as 'Long_Add_No', 
LTRIM(C.ABMCU) as 'Business_Unit', 
C.ABSIC as 'Industry_Class_Code', 
C.ABDC as 'Descr_Compressed', 
C.ABEFTB as 'Date_Beginning_Eff_Temp', 
D.WPPH1 as 'Phone_No',
E.PNPTD as 'Descr_Pmt_Terms', 
E.PNNDTP as 'Net_Days_to_Pay',
F.AYCBNK as 'Bank_Acct_No_Customer', 
F.AYCTR as "Bank_Acct_Country",
F.AYBKTP as  'Record_Type_Bank_Transit', 
F.AYDL01 as 'Descr', 
F.AYAID as 'Account_ID', 
F.AYSWFT as 'SWIFT_Code', 
F.AYCKSV as 'Checking_or_Savings_Act'
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

SELECT RTRIM(LTRIM(STR(PDDOCO,8))) as 'Order No',
PDTRDJ as 'Order_Date_Temp',
RTRIM(LTRIM(PDKCOO)) as 'Order Co',
RTRIM(LTRIM(PDDCTO)) as 'Order Type',
PDLNID/1000 as 'Line No',
RTRIM(LTRIM(STR(PDAN8,8))) as 'Add No',
RTRIM(LTRIM(C.ABALPH)) as 'Name_Alpha', 
RTRIM(LTRIM(STR(PDSHAN,8))) as 'Add No Ship To',
PDDGL as 'GL_Date_Temp',
RTRIM(LTRIM(PDLNTY)) as 'Line Type',
RTRIM(LTRIM(PDPTC)) as 'Pmt Terms Code',
RTRIM(LTRIM(PDNXTR)) as 'Status Code Next',
RTRIM(LTRIM(PDLTTR)) as 'Status Code Last',
RTRIM(LTRIM(PDVR01)) as 'Contract Number',
RTRIM(LTRIM(PDVR02)) as 'Contract Supplement',
RTRIM(LTRIM(STR(PDITM,8))) as 'Item No Short',
RTRIM(LTRIM(PDLITM)) as 'Item No2',
RTRIM(LTRIM(PDAITM)) as 'Item No3',
RTRIM(LTRIM(PDDSC1)) as 'Descr',
RTRIM(LTRIM(PDDSC2)) as 'Descr Line 2',
PDUORG/1000 as 'Qty Ordered',
PDUREC/1000 as 'Units Received',
PDUCHG as 'Units On Hold',
PDUOPN/1000 as 'Units Open',
PDAEXP/100 as 'Amt Ext Price',
PDAOPN/100 as 'Amt Open',
PDACHG/100 as 'Amt On Hold',
PDAREC/100 as 'Amt Received',
RTRIM(LTRIM(PDCRCD)) as 'Cur Code From',
PDCRR as 'Cur Conversion Rate',
PDFRRC/10000 as 'Foreign Unit Price',
PDFEA/100 as 'Foreign Extended Price Amt',
PDFUC/10000 as 'Foreign Unit Cost',
PDFEC/100 as 'Foreign Extended Cost',
PDFCHG/100 as 'Foreign Changed Amt',
PDFAP/100 as 'Foreign Open Amt',
PDFREC/100 as 'Received Foreign Amt',
RTRIM(LTRIM(PDLOCN)) as 'Location',
RTRIM(LTRIM(STR(PDANBY,8))) as 'Buyer No',
RTRIM(LTRIM(PDSFXO)) as 'Order Suffix',
RTRIM(LTRIM(PDMCU)) as 'Business Unit',
RTRIM(LTRIM(PDCO)) as 'Co',
RTRIM(LTRIM(PDOKCO)) as 'Doc Co Original Order',
RTRIM(LTRIM(PDOORN)) as 'Original Order No',
RTRIM(LTRIM(PDOCTO)) as 'Original Order Type',
PDOGNO/1000 as 'Original Line No',
RTRIM(LTRIM(PDRORN)) as 'Related PO SO WO No',
RTRIM(LTRIM(PDRCTO)) as 'Related PO SO WO Order Type',
PDRLLN/1000 as 'Related PO SO Line No',
PDDRQJ as 'Date_Requested_Temp',
PDPDDJ as 'Date_Scheduled_Pick_Temp',
PDOPDJ as 'Date_Orig_Promised_Deliv_Temp',
PDADDJ as 'Date_Actual_Ship_Date_Temp',
PDCNDJ as 'Date_Cancel_Temp',
PDPEFJ as 'Date_Price_Effective_Date_Temp',
PDPPDJ as 'Date_Promised_Shipment_Temp',
PDPSDJ as 'Date_Future_Date_2_Temp',
PDDSVJ as 'Date_Service_Tax_Temp',
PDPN as 'Period No General Ledger',
RTRIM(LTRIM(PDLOTN)) as 'Lot Serial No',
RTRIM(LTRIM(PDFRGD)) as 'From Grade',
RTRIM(LTRIM(PDTHGD)) as 'Thru Grade',
PDFRMP/1000 as 'From Potency',
PDTHRP/1000 as 'Thru Potency',
RTRIM(LTRIM(PDRLIT)) as 'Item No Related Kit',
RTRIM(LTRIM(PDUOM)) as 'UOM as Input',
PDCREC as 'Units Cumulative Received',
PDURLV as 'Units Relieved',
PDPRRC/10000 as 'Amt Unit Cost',
PDARLV/100 as 'Amt Relieved',
PDFTN1/100 as 'Amt Tax Commitment',
PDTRLV/100 as 'Amt Tax Relieved',
RTRIM(LTRIM(PDPROV)) as 'Price Override Code',
PDAMC3/10000 as 'Unit Cost Pur',
PDECST/100 as 'Amt Ext Cost',
RTRIM(LTRIM(PDCSTO)) as 'Cost Override Code',
RTRIM(LTRIM(PDCSMP)) as 'Costing Method Pur',
RTRIM(LTRIM(PDINMG)) as 'Print Message',
RTRIM(LTRIM(PDASN)) as 'Price and Adj Schedule',
RTRIM(LTRIM(PDPRGR)) as 'Item Price Group',
RTRIM(LTRIM(PDCLVL)) as 'Pricing Cat Level',
RTRIM(LTRIM(PDCATN)) as 'Catalog',
PDDSPR/10000 as 'Disc Factor',
RTRIM(LTRIM(PDTX)) as 'Pur Taxable Y N',
RTRIM(LTRIM(PDCNID)) as 'Container I D',
RTRIM(LTRIM(PDCDCD)) as 'Commodity Code',
RTRIM(LTRIM(PDNTR)) as 'Nature of Transaction',
RTRIM(LTRIM(PDFRTH)) as 'Freight Handling Code',
RTRIM(LTRIM(PDFRTC)) as 'Freight Calculated Y N',
RTRIM(LTRIM(PDZON)) as 'Zone No',
RTRIM(LTRIM(PDFRAT)) as 'Rate Code Frieght Misc',
RTRIM(LTRIM(PDRATT)) as 'Rate Type Freight Misc',
RTRIM(LTRIM(STR(PDANCR,8))) as 'Carrier No',
RTRIM(LTRIM(PDMOT)) as 'Mode of Transport',
RTRIM(LTRIM(PDCOT)) as 'Conditions of Transport',
RTRIM(LTRIM(PDSHCM)) as 'Ship Commodity Class',
RTRIM(LTRIM(PDSHCN)) as 'Ship Conditions Code',
RTRIM(LTRIM(PDUOM1)) as 'UOM Primary',
PDPQOR as 'Units Pri Qty Ordered',
RTRIM(LTRIM(PDUOM2)) as 'UOM Secondary',
PDSQOR as 'Units Sec Qty Ordered',
RTRIM(LTRIM(PDUOM3)) as 'UOM Pur',
RTRIM(LTRIM(PDVLUM)) as 'Volume UOM',
RTRIM(LTRIM(PDGLC)) as 'G L Offset',
PDCTRY as 'Century',
PDFY as 'Fiscal Year',
RTRIM(LTRIM(PDSTTS)) as 'Line Status',
RTRIM(LTRIM(PDRCD)) as 'Reason Code',
RTRIM(LTRIM(PDFUF1)) as 'AIA Doc Flag',
RTRIM(LTRIM(PDFUF2)) as 'Post Quantities',
RTRIM(LTRIM(PDOMCU)) as 'Project Business Unit',
RTRIM(LTRIM(PDOBJ)) as 'Object Acct',
RTRIM(LTRIM(PDSUB)) as 'Subsidiary',
RTRIM(LTRIM(PDSBLT)) as 'Subledger Type',
RTRIM(LTRIM(PDSBL)) as 'Subledger G L',
RTRIM(LTRIM(PDASID)) as 'Serial No',
PDCCMP as 'Cost Component No',
RTRIM(LTRIM(PDTAG)) as 'Tag Ref',
RTRIM(LTRIM(PDARTG)) as 'Code Approval Routing',
RTRIM(LTRIM(STR(PDCORD,3))) as 'Change Order No',
RTRIM(LTRIM(PDCHDT)) as 'Change Order Type',
PDDOCC as 'Doc Change Order',
RTRIM(LTRIM(PDTORG)) as 'Transaction Originator',
RTRIM(LTRIM(PDUSER)) as 'User ID',
RTRIM(LTRIM(PDPID)) as 'Program ID',
RTRIM(LTRIM(PDJOBN)) as 'Work Station ID',
PDUPMJ as 'Date_Updated_Temp'        
FROM %v_SCHEMA1%.F4311 A 
LEFT JOIN %v_SCHEMA1%.F0101 B ON A.PDAN8 = B.ABAN8
WHERE (A.PDKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (A.PDTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.PDKCOO <> ''   
    
COM *********************************************************
COM *** Import Purchase Order Receiving Table
COM *********************************************************

SELECT LTRIM(PRMATC) as 'Type Match Record Type',
LTRIM(STR(PRDOCO,8)) as 'PO Order No',
PRTRDJ as 'Order_Date_Temp',
LTRIM(STR(PRAN8,8)) as 'Add No',
RTRIM(LTRIM(C.ABALPH)) as 'Name_Alpha', 
LTRIM(PRKCOO) as 'Order Co Order No',
LTRIM(PRDCTO) as 'Order Type',
PRLNID/1000 as 'Line No',
LTRIM(STR(PRITM,8)) as 'Item No Short',
LTRIM(PRLITM) as 'Item No2',
LTRIM(PRAITM) as 'Item No3',
PRRCDJ as 'Date_Received_Temp',
PRUORG/1000 as 'Units Order Trans Qty',
PRUPTD/1000 as 'Units Paid to Date',
PRUREC/1000 as 'Units Received',
PRUOPN/1000 as 'Units Open',
PRQTYR as 'Units Returned',
PRECST/100 as 'Amt Extended Cost',
PRAPTD/100 as 'Amt Paid to Date',
PRAOPN/100 as 'Amt Open',
PRAREC/100 as 'Amt Received',
LTRIM(PRCRCD) as 'Cur Code From',
PRCRR as 'Cur Conversion Rate',
PRFRRC/10000 as 'Foreign Unit Price',
PRFEC/100 as 'Foreign Extended Price Amt',
PRFAP/100 as 'Foreign Open Amt',
PRFAPT/100 as 'Foreign Amt Paid to Date',
PRFREC/100 as 'Received Foreign Amt',
PRFCLO/100 as 'Foreign Closed Amt',
PRDRQJ as 'Date_Requested_Temp',
PRPDDJ as 'Date_Scheduled_Pick_Temp',
LTRIM(PRNXTR) as 'Status Code Next',
LTRIM(PRLTTR) as 'Status Code Last',
LTRIM(PRVINV) as 'Supplier Invoice No',
LTRIM(PRPTC) as 'Pmt Terms Code',
LTRIM(STR(PRDOC,8)) as 'Invoice No',
LTRIM(PRDCT) as 'Doc Type',
LTRIM(PRSFX) as 'Doc Pay Item',
PRDGL as 'GL_Date_Temp',
LTRIM(PRSFXO) as 'Order Suffix',
PRNLIN as 'No of Lines',
PRALIN as 'Line Associated',
LTRIM(PRRTBY) as 'Written By Program',
LTRIM(PRDMCT) as 'Agreement No Distribution',
PRDMCS as 'Agreement Supplement Distribution',
LTRIM(PRBALU) as 'Contract Balances Upd Y N',
LTRIM(PRIMCU) as 'Item Business Unit',
LTRIM(PRLOCN) as 'Location',
LTRIM(PRLOTN) as 'Lot Serial No',
LTRIM(PRLOTG) as 'Lot Grade',
PRLOTP/1000 as 'Lot Potency',
LTRIM(PRVRMK) as 'Supplier Remark',
LTRIM(PRCNID) as 'Container I D',
PROPDJ as 'Date_Orig_Promised_Deliv_Temp',
LTRIM(PRRCD) as 'Reason Code',
LTRIM(PRPST) as 'Pay Status Code',
LTRIM(PRLAND) as 'Code Landed Cost',
LTRIM(PRPRP5) as 'Purchasing Cat Code 5',
LTRIM(PRLVLA) as 'Level Cost',
LTRIM(PRILOG) as 'Code Invoice Logging',
LTRIM(PRDLOG) as 'Final Rcpt Flag Y or BLANK',
LTRIM(PRRTGC) as 'Routing Process Y N',
LTRIM(PRRCPF) as 'Leadtime Recalculated Y N',
LTRIM(PRAVCH) as 'Code Eval Receipt Settlement',
LTRIM(PRLNTY) as 'Line Type',
LTRIM(PRGLC) as 'G L Offset',
LTRIM(PRMCU) as 'Business Unit',
LTRIM(PRCO) as 'Co',
LTRIM(PRAID) as 'Acct ID',
LTRIM(PRANI) as 'Acct No Input Mode Unknown',
LTRIM(PROMCU) as 'Project Business Unit',
LTRIM(PROBJ) as 'Object Acct',
LTRIM(PRSUB) as 'Subsidiary',
LTRIM(PRASID) as 'Serial No',
LTRIM(PRSBL) as 'Subledger G L',
LTRIM(PRSBLT) as 'Subledger Type',
LTRIM(PRKCO) as 'Doc Co',
PRJELN as 'Journal Entry Line No',
LTRIM(PRVANI) as 'Acct No Rec Not Vouchered',
LTRIM(PRTX) as 'Purchasing Taxable Y N',
LTRIM(PREXR1) as 'Tax Expl Code 1',
LTRIM(PRTXA1) as 'Tax Rate Area',
LTRIM(PRUOM) as 'UOM as Input',
PRUCLO as 'Units Closed',
PRQTYS as 'Units Stocked',
PRQTYW as 'Units Reworked',
PRQTYC as 'Units Scrapped',
PRQTYJ as 'Units Rejected',
PRQTYA as 'Units Adjusted',
LTRIM(PRUOM3) as 'UOM Purchasing',
PRPRRC/10000 as 'Amt Unit Cost',
PRACLO/100 as 'Amt Closed',
LTRIM(PRTORG) as 'Trans Originator',
LTRIM(PRUSER) as 'User ID',
LTRIM(PRPID) as 'Program ID',
LTRIM(PRJOBN) as 'Work Station ID',
LTRIM(PRTERM) as 'Terminal Identification',
PRUPMJ as 'Date_Updated_Temp',
PRTDAY as 'Time of Day'  
FROM %v_SCHEMA1%.F43121 A 
LEFT JOIN %v_SCHEMA1%.F0101 B ON A.PRAN8 = B.ABAN8
WHERE (A.PRKCOO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (A.PRTRDJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.PRKCOO <> ''
 
COM *********************************************************
COM *** Import Accounts Payable Table
COM *********************************************************

SELECT LTRIM(STR(RPDOC,8)) as 'Invoice No',
RPDIVJ as 'Invoice_Date_Temp',
LTRIM(RPKCO) as 'Doc Co',
LTRIM(RPDCT) as 'Doc Type',
LTRIM(RPSFX) as 'Doc Pay Item',
LTRIM(STR(RPAN8,8)) as 'Add No',
RTRIM(LTRIM(C.ABALPH)) as 'Name_Alpha', 
RPAG/100 as 'Amt Gross',
RPAAP/100 as 'Amt Open',
RNPAAP/100 as 'Pmt Amt',
RNPFAP/100 as 'Pmt Amt Foreign',
RMVLDT as 'Cleared_Date_Temp',
LTRIM(RMCBNK) as 'Bank Acct No Vendor',
RMDMTJ as 'Date_Match_Check_or_Item_Temp',
LTRIM(STR(RPPYE,8)) as 'Payee Add No',
LTRIM(RPRMK) as 'Name Remark',
LTRIM(STR(RPSNTO,8)) as 'Add No Approver',
RPDSVJ as 'Date_Service_Tax_Temp',
RPDDJ as 'Date_Net_Due_Temp',
RPDDNJ as 'Date_Disc_Due_Julian_Temp',
RPDGJ as 'GL_Date_Temp',
RPFY as 'Fiscal Year',
RPCTRY as 'Century',
RPPN as 'Period No General Ledger',
LTRIM(RPCO) as 'Co',
LTRIM(STR(RPICU,8)) as 'Batch No',
LTRIM(RPICUT) as 'Batch Type',
RPDICJ as 'Date Batch Julian_Temp',
LTRIM(RPBALJ) as 'Balanced Journal Entries',
LTRIM(RPPST) as 'Pay Status Code',
RPADSC/100 as 'Disc Available',
RPADSA/100 as 'Disc Taken',
RPATXA/100 as 'Amt Taxable',
RPATXN/100 as 'Amt Non Taxable',
RPSTAM/100 as 'Amt Tax',
LTRIM(RPTXA1) as 'Tax Rate Area',
LTRIM(RPEXR1) as 'Tax Expl Code 1',
LTRIM(RPCRRM) as 'Cur Mode Foreign Dom Entry',
LTRIM(RPCRCD) as 'Cur Code From',
RPCRR as 'Cur Conversion Rate Spot Rate',
RPACR/100 as 'Amt Cur',
RPFAP/100 as 'Amt Foreign Open',
RPCDS/100 as 'Amt Foreign Disc Available',
RPCDSA/100 as 'Amt Foreign Disc Taken',
RPCTXA/100 as 'Amt Foreign Taxable',
RPCTXN/100 as 'Amt Foreign Non Taxable',
RPCTAM/100 as 'Amt Foreign Tax',
RPSFXE as 'Pay Item Extension No',
LTRIM(RPDCTA) as 'Doc Type Adjusting',
LTRIM(RPGLC) as 'G L Offset',
LTRIM(RPGLBA) as 'G L Bank Acct',
LTRIM(RPPOST) as 'G L Posted Code',
LTRIM(RPAM) as 'Acct Mode G L',
LTRIM(RPAID2) as 'Acct ID',
LTRIM(RPMCU) as 'Business Unit',
LTRIM(RPOBJ) as 'Object Acct',
LTRIM(RPSUB) as 'Subsidiary',
LTRIM(RPSBLT) as 'Subledger Type',
LTRIM(RPSBL) as 'Subledger G L',
LTRIM(RPBAID) as 'Bank Transit Short ID',
LTRIM(RPPTC) as 'Pmt Terms Code',
LTRIM(RPVOD) as 'Void Flag',
LTRIM(RPOKCO) as 'Doc Co Original Order',
LTRIM(RPODCT) as 'Doc Type Original',
LTRIM(STR(RPODOC,8)) as 'Doc Original',
LTRIM(RPOSFX) as 'Doc Pay Item Original',
LTRIM(RPCRC) as 'Pmt Handling Code',
LTRIM(RPVINV) as 'Supplier Invoice No',
LTRIM(RPPKCO) as 'Doc Co Purchase Order',
LTRIM(RPPO) as 'Purchase Order',
LTRIM(RPPDCT) as 'Doc Type Purchase Order',
RPLNID/1000 as 'Line No',
LTRIM(RPSFXO) as 'Order Suffix',
RPOPSQ/100 as 'Sequence No Operations',
LTRIM(RPVR01) as 'Reference',
LTRIM(RPUNIT) as 'Unit',
LTRIM(RPMCU2) as 'Business Unit 2',
LTRIM(RPRF) as 'Frequency Recurring',
RPDRF as 'Recurring Freq of Pmts',
LTRIM(RPCTL) as 'Control Statement Field',
LTRIM(RPFNLP) as 'Closed Item As Of Processing',
RPU/100 as 'Units',
LTRIM(RPUM) as 'UOM',
LTRIM(RPPYIN) as 'Pmt Instrument',
LTRIM(RPTXA3) as 'Tax Rate Area 3 Withholding',
LTRIM(RPEXR3) as 'Tax Expl Code 3 Withholding',
LTRIM(RPRP1) as 'AR AP Miscellaneous Code 1',
LTRIM(RPRP2) as 'AR AP Miscellaneous Code 2',
LTRIM(RPRP3) as 'AR AP Cash Rcpts Inv Reg Code',
LTRIM(RPAC07) as 'Cat Code Add Book 07',
LTRIM(RPTNN) as 'Flag for 1099',
LTRIM(RPDMCD) as 'Dom Entry w Mult Cur Distr',
LTRIM(STR(RPITM,8)) as 'Item No Short',
RPHCRR as 'Historical Cur Conv Rate',
RPHDGJ as 'Historical_Date_Julian_Temp',
LTRIM(RPTORG) as 'Transaction Originator',
LTRIM(RPUSER) as 'User ID',
LTRIM(RPPID) as 'Program ID',
RPUPMJ as 'Date_Updated_Temp',
RPUPMT as 'Time Last Updated',
LTRIM(RPJOBN) as 'Work Station ID'
FROM %v_SCHEMA1%.F0411 A 
LEFT JOIN (SELECT * 
FROM %v_SCHEMA1%.F0414 A
LEFT JOIN %v_SCHEMA1%.F0413 B ON A.RNPYID = B.RMPYID) B ON A.RPDOC = B.RNDOC and A.RPCO = B.RNCO and A.RPDCT = B.RNDCT and A.RPSFX = B.RNSFX
LEFT JOIN %v_SCHEMA1%.F0101 C ON A.RPAN8 = C.ABAN8
WHERE (A.RPCO IN (%v_CompanyCode1%, %v_CompanyCode2%, %v_CompanyCode3%, %v_CompanyCode4%, %v_CompanyCode5%, %v_CompanyCode6%, %v_CompanyCode7%, %v_CompanyCode8%, %v_CompanyCode9%, %v_CompanyCode10%, %v_CompanyCode11%, %v_CompanyCode12%, %v_CompanyCode13%, %v_CompanyCode14%, %v_CompanyCode15%)) 
AND (A.RPDGJ BETWEEN %v_BeginAuditPeriod% AND %v_EndAuditPeriod%) 
AND A.RPCO <> ''