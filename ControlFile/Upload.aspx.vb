Imports System.IO
Imports Microsoft.VisualBasic.CompilerServices

Public Class Upload
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
        If Not Directory.Exists(MyBase.Server.MapPath(Conversions.ToString(Operators.ConcatenateObject(Operators.ConcatenateObject("~/Uploads/", Me.Session("Ruta")), "/")))) Then
            Directory.CreateDirectory(MyBase.Server.MapPath(Conversions.ToString(Operators.ConcatenateObject(Operators.ConcatenateObject("~/Uploads/", Me.Session("Ruta")), "/"))))
        End If

    End Sub
    Public Function EncodeBase64(ByVal input As String) As String
        Return Convert.ToBase64String(Encoding.UTF8.GetBytes(input))
    End Function


End Class