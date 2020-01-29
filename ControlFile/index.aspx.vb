Imports System.Data
Imports System.Data.SqlClient

Public Class index
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Session("IdUser") = ""
        Me.Session("Email") = ""
        Me.Session("Password") = ""
        Me.Session("Name") = ""
        Me.Session("Type") = ""
        Me.Session("Ruta") = ""

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim tabla As New DataTable
        Dim textArray1 As String() = New String() {"SELECT Id, Email, Password, Name, Type, Path FROM Users WHERE Email = '", Me.email.Text, "' and Password = '", Me.password.Text, "'"}
        tabla = Me.CreaDataTable(String.Concat(textArray1))
        Me.Session.Timeout = 10
        If (tabla.Rows.Count <= 0) Then
            Me.RFV.Visible = True
        Else
            Me.Session("IdUser") = Me.Valor(tabla, 0, 0)
            Me.Session("Email") = Me.Valor(tabla, 0, 1)
            Me.Session("Password") = Me.Valor(tabla, 0, 2)
            Me.Session("Name") = Me.Valor(tabla, 0, 3)
            Me.Session("Type") = Me.Valor(tabla, 0, 4)
            Me.Session("Ruta") = Me.EncodeBase64(Me.Valor(tabla, 0, 1))
            Me.Session.Timeout = 10
            MyBase.Response.Redirect("Upload.aspx")
        End If

    End Sub
    Public Function CreaDataTable(ByVal Comando As String) As Data.DataTable
        Dim scnn As String
        scnn = ConfigurationSettings.AppSettings("conexion")
        Dim da As SqlDataAdapter
        Dim dt As New Data.DataTable
        'MsgBox(Comando)
        Try
            da = New SqlDataAdapter(Comando, scnn)
            da.Fill(dt)
            Return dt
        Catch ex As Exception

            'log_("Error: " & ex.Message)
            Return dt
        End Try
    End Function

    Public Function Valor(ByVal Tabla As Data.DataTable, ByVal fila As Integer, ByVal columna As Integer) As String
        Dim ValorRetorno As String
        ValorRetorno = Trim(Tabla.Rows(fila)(columna).ToString).ToString
        Return ValorRetorno
    End Function

    Public Function EncodeBase64(ByVal input As String) As String
        Return Convert.ToBase64String(Encoding.UTF8.GetBytes(input))
    End Function





End Class