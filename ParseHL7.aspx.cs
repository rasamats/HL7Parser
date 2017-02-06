using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;


public partial class ParseHL7 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            string text = inputHL7.Text;
            HtmlTable table = new HtmlTable();
            HtmlTable parsedTable = new HtmlTable();
            
            HtmlTableRow row;
            HtmlTableRow pRow;

            HtmlTableCell cell1;
            HtmlTableCell cell2;

            HtmlTableCell pCell;
            //parsedHL7.Text="<Table>";
            string[] arrStr = Regex.Split(text, @"\r?\n|\r");
           
            for (int i = 0; i < arrStr.Length; i++)
            {
                if (arrStr[i] == "") continue;
                row = new HtmlTableRow();
                int ind = arrStr[i].IndexOf("|");
                string linkName = arrStr[i].Substring(0, ind);
                string rest = arrStr[i].Substring(ind+1);
                string[] supportedLinks = { "MSH", "EVN", "PID", "MRG","PV1","DG1","IN1","GT1","NK1","ZM1","ZM2","NTE","OBR","OBX","ORC","FT1" };
                if (!supportedLinks.Contains(linkName)) continue;
                cell1 = new HtmlTableCell();
                HyperLink hl = new HyperLink();
                hl.NavigateUrl = "javascript:ParseDetail('" + linkName + @"','" + rest + @"')";
                hl.Text = linkName;
                cell1.Controls.Add(hl);
                row.Cells.Add(cell1);

                cell2 = new HtmlTableCell();
                cell2.InnerText = rest;
                row.Cells.Add(cell2);
                table.Rows.Add(row);
                
            }
            this.Controls.Add(table);

            //parsedTable.Visible = false;
            parsedTable.ID = "tListView";
            pRow = new HtmlTableRow();
            pCell = new HtmlTableCell();

            Label pLabel = new Label();
            pLabel.ID = "tagID";
            pLabel.Text = "TagValue";
            pCell.Controls.Add(pLabel);
            pRow.Cells.Add(pCell);
            parsedTable.Rows.Add(pRow);
            for (int lblCnt = 1; lblCnt < 75; lblCnt++)
            {
                if ((lblCnt%2) == 1)
                {
                    pRow = new HtmlTableRow();
                }
                pCell = new HtmlTableCell();
                pLabel = new Label();
                pLabel.ID = "lblID" + lblCnt;
                pLabel.Text = lblCnt + ": ";
                pCell.Controls.Add(pLabel);
                pRow.Cells.Add(pCell);
                if ((lblCnt % 2) == 0)
                {
                    parsedTable.Rows.Add(pRow);
                }
            }
            
            this.Controls.Add(parsedTable);
        }
    }
}