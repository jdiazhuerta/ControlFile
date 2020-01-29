
Imports Microsoft.VisualBasic.CompilerServices
Public Class FileList
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

End Class