<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ParseHL7.aspx.cs" Inherits="ParseHL7" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Jumping Jack</title>
    <link href="../Styles/Site.css" rel="Stylesheet" type="text/css" />
    <base target="_self" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link href="../Styles/Site.css" rel="Stylesheet" type="text/css" />
    <base target="_self" />
    <script language="javascript" type="text/javascript" src="../javascript/popup.js"></script>
    <script language="javascript" type="text/javascript" src="../javascript/jquery-1.11.3.js"></script>
    <script language="Javascript" type="text/javascript">

        function ParseDetail(lbl, data) {
            var fieldNames = [];
            fieldNames['MSH'] = [' ', ' ', 'Sending Application', 'Sending Facility', 'Receiving Application', 'Receiving Facility', 'Date/Time of Message', '', 'Message Type/Event Code', 'Current (eGate) Date/Time', 'Processing ID(Prod or Test)', 'Version ID', 'NextM Sequence Number', 'Epic Alert'];
            fieldNames['EVN'] = ['Event Type Code', 'Date/Time of Event', 'Business Process Code', 'Event Reason Code', 'User ID'];
            fieldNames['PID'] = ['', 'Medical Record Number^Facility ID', 'Patient ID (internal ID)', 'PHS#', 'Patient Last^First^Middle^Suffix Name', 'Mothers Maiden Name(Last)', 'Date of Birth', 'Sex', 'Patient Alias Last^First^Middle^Suffix Name', 'Race code1^code2^text', 'Patient address line1^line2^city^state^zip^country', 'Shared Care Flag', 'Phone / Email - Home~Cell~PrimaryEmail~SecondaryEmail', 'Phone Number - Business', 'Language - Patient', 'Marital Status', 'Religion', 'Patient Account Number', 'SSN - Patient', 'Dormant', 'Mothers MRN', 'VIP Indicator', 'Education level&country', 'Ethnic group1^group2^text', 'HIPAA Acknowledgement Signed', 'Country/Citizenship', 'Veterans Military Status', '', 'Date/Time of Death', 'Patient Death Indicator'];
            fieldNames['MRG'] = ['Merged Patient ID - Internal', '', 'Source ECD', 'Merged Patient Medical Record Number^Facility ID', 'Source Visit Number'];
            fieldNames['PV1'] = ['', 'Patient Class', 'Nursing Station/Clinic^Room^Bed^Facility', '', '', 'Previous Location(Clinic,room,bed,fac.)', 'Attending Doctor ID^Last^First Name', 'Referring Doctor ID^Last^First Name', 'Consulting Doctor ID^Last^First Name', 'Hospital Service', 'Encounter Status Code', '', '', 'Admit Source', '', '', 'Admitting Doctor ID^Last^First Name', 'Patient Type', 'Visit Number', 'Financial Class', '', '', '', 'Encounter location', 'Encounter Provider Organization Name^Organization Name Type Code^ID', '', '', '', '', '', '', '', '', '', 'Reason for Visit', 'Discharge Disposition', '', '', '', '', '', '', 'Expected Admit Date', 'Admit Date/Time', 'Discharge Date/Time', '', '', '', '', 'Alternate Visit ID(ECD)', '', 'PCP ID^Las^First Name', 'HAR'];
            fieldNames['DG1'] = ['Set ID', '', 'ICD9 Code', 'Diagnosis Description', '', 'Diagnosis Type'];
            fieldNames['IN1'] = ['Set ID', 'Insurance Plan Name', 'Insurance Company ID', 'Insurance Company Name', 'Insurance Company address line1^line2^city^state^zip', '', 'Insurance Co. Phone Number', 'Group Number', 'Group Name', '', '', '', '', '', 'Plan Type', 'Insured Last^First^Middle^Suffix Name', 'Patients Relationship to Insured', 'Insureds Date of Birth', 'Insureds address line1^line2^city^state^zip', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Policy Number', '', '', '', '', 'Insurance Plan ID', 'Insureds Employment Status', 'Insureds Sex', 'Insureds Employer Address line1^line2^city^state^zip'];
            fieldNames['GT1'] = ['', '', 'Guarantor Last^First^Middle^Suffix Name', '', 'Guarantor Address line1^line2^city^state^zip', 'Guarantor Home Phone Number', 'Guarantor Business Phone Number', 'Guarantor Date of Birth', '', '', 'Guarantor Relationship to Patient', '', '', '', '', 'Guarantor Employer Name', 'Guarantor Employer Address line1^line2^city^state^zip'];
            fieldNames['NK1'] = ['Set ID(only if multiple NK1 segments sent)', 'Next of Kin Last^First^Middle^Suffix Name', 'Relationship', 'Next of Kin Address line1^line2^city^state^zip', 'Phone Number', 'Busness Phone Number', 'Contact Role', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Contact Persons Last^First^Middle^Suffix Name', 'Contact Persons Telephone(home~work)', 'Contact Persons Address line1^line2^city^state^zip'];
            fieldNames['ZM1'] = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Employer Name', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Resident PCP (Code, LN, FN)', 'PCP Telephone', '', '', 'RSO Description', '', '', '', '', '', '', 'PCP Address line1^line2^city^state^zip', 'Patient Alternate Address line1^line2^city^state^zip', 'Patient Alternate Phone Number', 'Precaution Flag', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
            fieldNames['ZM2'] = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Patient Employer Address line1^line2^city^state^zip', 'Patient Employer Phone Number', '', '', 'RSO Group Code', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Duplicate MRN', '', '', '', 'Mass HIway', 'Special Needs', 'Preliminary Cause of Death', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
            fieldNames['NTE'] = ['Set ID - NTE', 'Source of Comment', 'Comment', 'Comment Type'];
            fieldNames['OBR'] = ['Set ID – OBR', 'Placer Order Number', 'Filler Order Number', 'Universal Service ID', 'Priority', 'Requested Date/time', 'Observation Date/Time', 'Observation End Date/Time', 'Collection Volume', 'Collector Identifier', 'Specimen Action Code', 'Danger Code', 'Relevant Clinical Info.', 'Specimen Received Date/Time', 'Specimen Source', 'Ordering Provider', 'Order Callback Phone Number', 'Placer field 1', 'Placer field 2', 'Filler Field 1', 'Filler Field 2', 'Results Rpt/Status Chng – Date/Time', 'Charge to Practice', 'Diagnostic Serv Sect ID', 'Result Status', 'Parent Result', 'Quantity/Timing', 'Result Copies To', 'Parent', 'Transportation Mode', 'Reason for Study', 'Principal Result Interpreter', 'Assistant Result Interpreter', 'Technician', 'Transcriptionist', 'Scheduled Date/Time', 'Number of Sample Containers', 'Transport Logistics of Collected Sample', 'Collector’s Comment', 'Transport Arrangement Responsibility', 'Transport Arranged', 'Escort Required', 'Planned Patient Transport Comment'];
            fieldNames['OBX'] = ['Set ID – Obx', 'Value Type', 'Observation Identifier', 'Observation Sub-Id', 'Observation Value', 'Units', 'Reference Range', 'Abnormal Flags', 'Probability', 'Nature of Abnormal Test', 'Observ Result Status', 'Data Last Obs Normal Values', 'User Defined Access Checks', 'Date/Time of the Observation', 'Producer’s Id', 'Responsible Observer', 'Observation Method'];
            fieldNames['ORC'] = ['Order Control','Placer Order Number','Filler Order Number','Placer Group Number','Order Status','Response Flag','Quantity/Timing','Parent Order','Date/Time of Transaction','Entered By','Verified By','Ordering Provider','Enterers Location','Call Back Phone Number','Order Effective Date/Time','Order Control Code Reason','Entering Organization','Entering Device','Action By','Advanced Beneficiary Notice Code','Ordering Facility Name','Ordering Facility Address','Ordering Facility Phone Number','Ordering Provider Address','Order Status Modifier','Advanced Beneficiary Notice Override Reason','Fillers Expected Availability Date/Time','Confidentiality Code','Order Type','Enterer Authorization Mode','Parent Universal Service Identifier'];
            fieldNames['FT1'] = ['Set ID - FT1','Transaction ID','Transaction Batch ID','Transaction Date','Transaction Posting Date','Transaction Type','Transaction Code','Transaction Description','Transaction Description - Alt','Transaction Quantity','Transaction Amount - Extended','Transaction Amount - Unit','Department Code','Insurance Plan ID','Insurance Amount','Assigned Patient Location','Fee Schedule','Patient Type','Diagnosis Code - FT1','Performed By Code','Ordered By Code','Unit Cost','Filler Order Number','Entered By Code','Procedure Code','Procedure Code Modifier','Advanced Beneficiary Notice Code','Medically Necessary Duplicate Procedure Reason.','NDC Code','Payment Reference ID','Transaction Reference Key'];
            var current;
            var eleID = 'tagID';
            var newVal = 'Tag: ' + lbl;
            ChangeText(eleID, newVal);
            var dataArr = data.split('|');

            for (var lblCnt = 1; ((lblCnt < dataArr.length) && (lblCnt < fieldNames[lbl].length)); lblCnt++) {
                var biggerVal = Math.max(lblCnt, dataArr.length + 1);
                if (biggerVal == lblCnt) {
                    newVal = '';
                } else if (lbl != "MSH") {
                    newVal = '<b>' + lblCnt + ' ' + fieldNames[lbl][lblCnt - 1] + '</b>' + ': ' + dataArr[lblCnt - 1];
                } else {
                    if (lblCnt == 1) {
                        newVal = '<b>' + lblCnt + '</b>: ';
                    }

                    else {
                        //for MSH they want #1 in the #2 slot
                        newVal = '<b>' + lblCnt + ' ' + fieldNames[lbl][lblCnt - 1] + '</b>' + ': ' + dataArr[lblCnt - 2];
                    }
                }
                eleID = 'lblID' + lblCnt;
                ChangeText(eleID, newVal);
            }

            ToggleVisibility('tListView');
        }
        function ChangeText(eleID, newVal) {
            var aNode = document.getElementById(eleID);
            aNode.innerHTML = newVal;
        }
        function ToggleVisibility(eleId) {
            if (document.getElementById(eleId).style.visibility == 'hidden') {
                document.getElementById(eleId).style.visibility = 'visible';
            }
        }

    </script>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        <asp:Label runat="server" Text="Enter your HL7 below:" Font-Bold="true" Font-Size="Large"> </asp:Label>
     </div>
    <div>
        <asp:textbox id="inputHL7" CssClass="Contact_Input" maxlength="1200" Rows="8" Columns="100" wrap="true" TextMode="multiline" runat="server"/>
    </div>
    <div>
        <button type="submit" style="width: 85px">Parse</button>
    </div>
        <div id="tableHere">
            
        </div>
    </form>
</body>
</html>
