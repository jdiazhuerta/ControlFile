Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.CompilerServices
Public Class Forgot
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Function validar_Mail(ByVal sMail As String) As Boolean
        Return Regex.IsMatch(sMail, "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$")
    End Function



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
        If (Me.email.Text = "") Then
            Me.rema.Text = "Es necesario ingresar un correo."
            Me.rema.Visible = True
        ElseIf Not Me.validar_Mail(Strings.LCase(Me.email.Text)) Then
            Me.rema.Text = "Formato correo no valido."
            Me.rema.Visible = True
        Else
            Dim tabla As New DataTable
            tabla = Me.CreaDataTable(("SELECT Id, Email, Password, Name, Type, Path FROM Users WHERE Email = '" & Me.email.Text & "'"))
            Me.Session.Timeout = 10
            If (tabla.Rows.Count > 0) Then
                Dim strTo As String() = New String() {Me.email.Text}
                'New SendEmail().SendEmailMessage(ConfigurationSettings.AppSettings("user_s"), strTo, "RECUPERAR CONTRASEÑA", ("El password de su cuenta es: " & Me.Valor(tabla, 0, 2) & ". Se sugiere hacer el cambio de Password."), New String(2  - 1) {}, ConfigurationSettings.AppSettings("user_s"), ConfigurationSettings.AppSettings("pass_s"), ConfigurationSettings.AppSettings("host_s"), ConfigurationSettings.AppSettings("port_s"))
            Else
                Me.rema.Text = "Correo no está registrado."
                Me.rema.Visible = True
            End If
        End If

    End Sub
End Class