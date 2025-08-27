VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Employee Search"
   ClientHeight    =   4000
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4000
   ScaleWidth      =   6000
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtSearch 
      Height          =   375
      Left            =   120
      Top             =   240
      Width           =   2000
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search"
      Height          =   375
      Left            =   2400
      Top             =   240
      Width           =   1215
   End
   Begin MSComctlLib.ListView ListView1
      Height          =   2500
      Left            =   120
      Top             =   800
      Width           =   5700
      View            =   3 ' Report view
   End
End

Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim cn As ADODB.Connection
Dim cmd As ADODB.Command
Dim rs As ADODB.Recordset

Private Sub Form_Load()
    ' Setup ListView columns
    With ListView1.ColumnHeaders
        .Clear
        .Add , , "Name", 2000
        .Add , , "Job", 2000
        .Add , , "EmpNo", 1000
    End With
End Sub

Private Sub cmdSearch_Click()
    Dim searchTerm As String
    searchTerm = txtSearch.Text
    
    Set cn = New ADODB.Connection
    ' TODO: Replace placeholders with actual values
    cn.Open "Provider=OraOLEDB.Oracle;Data Source=ORCL;User Id=hr;Password=hr;"

    Set cmd = New ADODB.Command
    With cmd
        .ActiveConnection = cn
        .CommandText = "SEARCH_EMPLOYEES"
        .CommandType = adCmdStoredProc
        .Parameters.Append .CreateParameter("p_emp_name", adVarChar, adParamInput, 100, searchTerm)
        ' Oracle REF CURSOR is automatically returned as a Recordset when executed
    End With
    
    Set rs = cmd.Execute()
    
    ListView1.ListItems.Clear
    Do While Not rs.EOF
        Dim itm As ListItem
        Set itm = ListView1.ListItems.Add(, , rs!ename)
        itm.SubItems(1) = rs!job
        itm.SubItems(2) = CStr(rs!empno)
        rs.MoveNext
    Loop
    
    rs.Close
    cn.Close
End Sub
