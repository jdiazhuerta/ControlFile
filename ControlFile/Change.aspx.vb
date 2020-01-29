Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.CompilerServices
Public Class Change
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Operators.ConditionalCompareObjectEqual(Me.Session("Email"), "", False) Then
            Me.Session("IdUser") = ""
            Me.Session("Email") = ""
            Me.Session("Password") = ""
            Me.Session("Name") = ""
            Me.Session("Type") = ""
            Me.Session("Ruta") = ""
            MyBase.Response.Redirect("index.aspx")
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

    Public Sub EjecutaComando(ByVal Comando As String)
        Dim connection As New SqlConnection(ConfigurationSettings.AppSettings("conexion"))
        connection.Open()
        Dim command As New SqlCommand(Comando, connection)
        Try
            command.ExecuteNonQuery()
        Catch exception1 As Exception
            Dim ex As Exception = exception1
            ProjectData.SetProjectError(ex)
            Dim flag1 As Boolean = (Strings.InStr(ex.Message, "duplicate", CompareMethod.Binary) <> 0)
            ProjectData.ClearProjectError()
        End Try
        connection.Close()
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.paso.Visible = False
        Me.pas.Visible = False
        Me.pasr.Visible = False
        If (Me.passwordo.Text = "") Then
            Me.paso.Text = "Es necesario ingresar un password."
            Me.paso.Visible = True
        Else
            Dim table1 As New DataTable
            Me.Session.Timeout = 10
            If (Me.CreaDataTable(Conversions.ToString(Operators.ConcatenateObject(Operators.ConcatenateObject(Operators.ConcatenateObject(Operators.ConcatenateObject("SELECT Id, Email, Password, Name, Type, Path FROM Users WHERE Email = '", Me.Session("Email")), "' and Password = '"), Me.passwordo.Text), "'"))).Rows.Count <= 0) Then
                Me.paso.Text = "El password no coincide."
                Me.paso.Visible = True
            Else
                If (Me.password.Text = "") Then
                    Me.pas.Text = "Es necesario ingresar un password."
                    Me.pas.Visible = True
                ElseIf (Me.password.Text <> Me.passwordr.Text) Then
                    Me.pas.Text = "El password tiene que coincidir."
                    Me.pas.Visible = True
                End If
                If (Me.passwordr.Text = "") Then
                    Me.pasr.Text = "Es necesario ingresar un password."
                    Me.pasr.Visible = True
                ElseIf (Me.password.Text <> Me.passwordr.Text) Then
                    Me.pasr.Text = "El password tiene que coincidir."
                    Me.pasr.Visible = True
                End If
                If ((Not Me.paso.Visible And Not Me.pas.Visible) And Not Me.pasr.Visible) Then
                    Dim tabla As New DataTable
                    tabla = Me.CreaDataTable("select max(id) from users")
                    If (tabla.Rows.Count > 0) Then
                        Dim num1 As Integer = CInt(Math.Round(CDbl((Conversions.ToDouble(Me.Valor(tabla, 0, 0)) + 1))))
                        EjecutaComando(Conversions.ToString(Operators.ConcatenateObject(Operators.ConcatenateObject(("UPDATE Users Set Password = '" & Me.password.Text & "' WHERE email = '"), Me.Session("Email")), "'")))
                        Me.Session("Password") = Me.password.Text
                        MyBase.Response.Redirect("Upload.aspx")
                    End If
                End If
            End If
        End If

    End Sub
End Class