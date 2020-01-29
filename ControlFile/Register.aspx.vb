Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.CompilerServices
Public Class Register
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.rema.Visible = False
        Me.rpas.Visible = False
        Me.rpasr.Visible = False
        Me.rnam.Visible = False
        If (Me.email.Text = "") Then
            Me.rema.Text = "Es necesario ingresar un correo."
            Me.rema.Visible = True
        ElseIf Not Me.validar_Mail(Strings.LCase(Me.email.Text)) Then
            Me.rema.Text = "Formato correo no valido"
            Me.rema.Visible = True
        Else
            Dim table1 As New DataTable
            Me.Session.Timeout = 10
            If (Me.CreaDataTable(("SELECT Id, Email, Password, Name, Type, Path FROM Users WHERE Email = '" & Me.email.Text & "'")).Rows.Count > 0) Then
                Me.rema.Text = "Correo ya esta registrado."
                Me.rema.Visible = True
            Else
                If (Me.password.Text = "") Then
                    Me.rpas.Text = "Es necesario ingresar un password."
                    Me.rpas.Visible = True
                ElseIf (Me.password.Text <> Me.passwordr.Text) Then
                    Me.rpas.Text = "El password tiene que coincidir."
                    Me.rpas.Visible = True
                End If
                If (Me.passwordr.Text = "") Then
                    Me.rpasr.Text = "Es necesario ingresar un password."
                    Me.rpasr.Visible = True
                ElseIf (Me.password.Text <> Me.passwordr.Text) Then
                    Me.rpas.Text = "El password tiene que coincidir."
                    Me.rpas.Visible = True
                End If
                If (Me.name.Text = "") Then
                    Me.rnam.Text = "Es necesario ingresar su nombre."
                    Me.rnam.Visible = True
                End If
                If (((Not Me.rema.Visible And Not Me.rpas.Visible) And Not Me.rpasr.Visible) And Not Me.rnam.Visible) Then
                    Dim tabla As New DataTable
                    tabla = Me.CreaDataTable("select max(id) from users")
                    If (tabla.Rows.Count > 0) Then
                        Dim num As Integer = CInt(Math.Round(CDbl((Conversions.ToDouble(Me.Valor(tabla, 0, 0)) + 1))))
                        Dim textArray1 As String() = New String(9 - 1) {}
                        textArray1(0) = "INSERT INTO Users VALUES('"
                        textArray1(1) = Me.email.Text
                        textArray1(2) = "','"
                        textArray1(3) = Me.password.Text
                        textArray1(4) = "','"
                        textArray1(5) = Me.name.Text
                        textArray1(6) = "','NRML','path','"
                        textArray1(7) = Conversions.ToString(num)
                        textArray1(8) = "')"
                        EjecutaComando(String.Concat(textArray1))
                        Me.Session("IdUser") = num
                        Me.Session("Email") = Me.email.Text
                        Me.Session("Password") = Me.password.Text
                        Me.Session("Name") = Me.name.Text
                        Me.Session("Type") = "NRML"
                        Me.Session("Ruta") = Me.EncodeBase64(Me.email.Text)
                        Me.Session.Timeout = 10
                        MyBase.Response.Redirect("Upload.aspx")
                    End If
                End If
            End If
        End If

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


End Class