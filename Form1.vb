Imports System.Data
Imports Oracle.ManagedDataAccess.Client   ' Recommended ODP.NET library

Public Class Form1
    Inherits System.Windows.Forms.Form

    ' Controls
    Private txtSearch As New TextBox()
    Private cmdSearch As New Button()
    Private ListView1 As New ListView()

    Public Sub New()
        ' Form properties
        Me.Text = "Employee Search"
        Me.Size = New Drawing.Size(620, 450)
        Me.StartPosition = FormStartPosition.CenterScreen

        ' TextBox
        txtSearch.Location = New Drawing.Point(20, 20)
        txtSearch.Width = 200
        Me.Controls.Add(txtSearch)

        ' Button
        cmdSearch.Text = "Search"
        cmdSearch.Location = New Drawing.Point(240, 20)
        cmdSearch.Width = 100
        AddHandler cmdSearch.Click, AddressOf cmdSearch_Click
        Me.Controls.Add(cmdSearch)

        ' ListView
        ListView1.Location = New Drawing.Point(20, 70)
        ListView1.Size = New Drawing.Size(560, 300)
        ListView1.View = View.Details
        ListView1.FullRowSelect = True
        ListView1.GridLines = True
        ListView1.Columns.Add("Name", 200)
        ListView1.Columns.Add("Job", 200)
        ListView1.Columns.Add("EmpNo", 100)
        Me.Controls.Add(ListView1)
    End Sub

    Private Sub cmdSearch_Click(sender As Object, e As EventArgs)
        Dim searchTerm As String = txtSearch.Text
        Dim connString As String = "Data Source=ORCL;User Id=hr;Password=hr;" ' TODO: update

        ListView1.Items.Clear()

        Try
            Using cn As New OracleConnection(connString)
                cn.Open()

                Using cmd As New OracleCommand("SEARCH_EMPLOYEES", cn)
                    cmd.CommandType = CommandType.StoredProcedure

                    ' Parameters
                    cmd.Parameters.Add("p_emp_name", OracleDbType.Varchar2).Value = searchTerm
                    cmd.Parameters.Add("p_results", OracleDbType.RefCursor).Direction = ParameterDirection.Output

                    ' Execute
                    Using dr As OracleDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            Dim item As New ListViewItem(dr("ename").ToString())
                            item.SubItems.Add(dr("job").ToString())
                            item.SubItems.Add(dr("empno").ToString())
                            ListView1.Items.Add(item)
                        End While
                    End Using
                End Using
            End Using
        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try
    End Sub

End Class
