Imports System.Web
Imports System.Web.Services
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.VisualBasic.CompilerServices

Public Class HandlerVB
    Implements System.Web.IHttpHandler

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim num As Integer
        Dim enumerator As IEnumerator
        Dim str As String = HttpContext.Current.Session("Ruta").ToString
        Dim str2 As String = HttpContext.Current.Session("IdUser").ToString
        Dim str3 As String = context.Request.Form("param2").ToString
        Dim tabla As DataTable = Me.CreaDataTable(("SELECT * from Documents WHERE Document = '" & str3 & "' ORDER BY Version DESC"))
        If (tabla.Rows.Count <= 0) Then
            num = 0
        Else
            num = Conversions.ToInteger(Me.Valor(tabla, 0, 2))
            EjecutaComando(("UPDATE Documents SET Active = 0 WHERE Document = '" & str3 & "' AND Version = " & Conversions.ToString(num)))
            num += 1
        End If
        Try
            enumerator = context.Request.Files.GetEnumerator
            Do While enumerator.MoveNext
                Dim str6 As String = Conversions.ToString(enumerator.Current)
                Dim file As HttpPostedFile = context.Request.Files(str6)
                Dim ruta As String = context.Server.MapPath(("~/Uploads/" & str & "/"))
                Dim str8 As String = Me.EncodeBase64((file.FileName & str3 & Conversions.ToString(num)))
                If Not Directory.Exists(ruta) Then
                    Directory.CreateDirectory(ruta)
                End If
                file.SaveAs((ruta & str8 & Path.GetExtension(file.FileName)))
                Dim textArray1 As String() = New String(12 - 1) {}
                textArray1(0) = "INSERT INTO Documents values ("
                textArray1(1) = str2
                textArray1(2) = ",'"
                textArray1(3) = str3
                textArray1(4) = "',"
                textArray1(5) = Conversions.ToString(num)
                textArray1(6) = ",'"
                textArray1(7) = file.FileName
                textArray1(8) = "','"
                textArray1(9) = str8
                textArray1(10) = path.GetExtension(file.FileName)
                textArray1(11) = "',getdate(),1)"
                Me.EjecutaComando(String.Concat(textArray1))
                Dim str5 As String = ConfigurationSettings.AppSettings("url")
                Dim textArray2 As String() = New String() {str5, str, "/", str8, path.GetExtension(file.FileName)}
                str5 = String.Concat(textArray2)
                Dim writer1 As New StreamWriter((ConfigurationSettings.AppSettings("ruta_ftp") & "DOC-" & str3 & ".URL"), False)
                writer1.Write(("DOC|" & str3 & "|"))
                writer1.Write(writer1.NewLine)
                writer1.Write(("URL|" & str5 & "|"))
                writer1.Close()
            Loop
        Finally
            If TypeOf enumerator Is IDisposable Then
                TryCast(enumerator, IDisposable).Dispose()
            End If
        End Try
        context.Response.StatusCode = 200
        context.Response.ContentType = "text/plain"
        context.Response.Write("Success")
    End Sub



    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
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