<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FileList.aspx.vb" Inherits="ControlFile.FileList" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net"  %>
<%@ Import Namespace="System.Xml"  %>

<!DOCTYPE html>

<script runat="server">
    Public Const ch As String = Chr(34)
    <System.Web.Services.WebMethod()>
    Public Shared Function Consulta(ByVal Tipo As String, ByVal Id As String, ByVal Valores As String) As String
        Dim respuesta As String
        respuesta = ""
        Dim IdUser As String = HttpContext.Current.Session("IdUser").ToString()
        If Tipo = "Qry" Then
            Dim tablaE As New Data.DataTable

            If HttpContext.Current.Session("Type").ToString = "ADMIN" Then
                If Valores = "" Then
                    tablaE = CreaDataTable_("SELECT Document, Org_File, Version, DateTime, Fnl_File FROM Documents WHERE ID = " & IdUser & " AND Active = 1")
                Else
                    tablaE = CreaDataTable_("SELECT Document, Org_File, Version, DateTime, Fnl_File FROM Documents WHERE ID = " & IdUser & " AND Active = 1 AND ( Document like '%" & Valores & "%' OR Org_File like '%" & Valores & "%' ) ")
                End If
            Else
                If Valores = "" Then
                    tablaE = CreaDataTable_("SELECT Document, Org_File, Version, DateTime, Fnl_File as Fnl_Fl FROM Documents WHERE ID = " & IdUser & " AND Active = 1")
                Else
                    tablaE = CreaDataTable_("SELECT Document, Org_File, Version, DateTime, Fnl_File as Fnl_Fl FROM Documents WHERE ID = " & IdUser & " AND Active = 1 AND ( Document like '%" & Valores & "%' OR Org_File like '%" & Valores & "%' ) ")
                End If
            End If



            If tablaE.Rows.Count > 0 Then

                respuesta = "{" & ch & "ID" & ch & ":" & ch & Id & ch & "," &
            ch & "PRGM" & ch & ":" & ch & "W3siaiIn1d" & ch & "," &
            ch & "success" & ch & ":true," &
            ch & "detalle" & ch & ":false," &
            ch & "message" & ch & ":" & ch & "Se han encontrado " & tablaE.Rows.Count & " registro(s)" &
            ch & ", " & ch & "data" & ch & ":{"

                For x = 0 To tablaE.Rows.Count - 1


                    respuesta = respuesta & "" & ch & "" & x & "" & ch & ":{"
                    For y = 0 To tablaE.Columns.Count - 1
                        If (y = tablaE.Columns.Count - 1) Then
                            respuesta = respuesta & ch & Name_(tablaE, y) & ch & ":" & ch & "Uploads/" & HttpContext.Current.Session("Ruta").ToString() & "/" & Valor_(tablaE, x, y) & "" & ch & ","
                        Else
                            respuesta = respuesta & ch & Name_(tablaE, y) & ch & ":" & ch & "" & Valor_(tablaE, x, y) & "" & ch & ","
                        End If


                    Next
                    respuesta = respuesta.Substring(0, respuesta.Length - 1)
                    respuesta = respuesta & "},"
                Next
                respuesta = respuesta.Substring(0, respuesta.Length - 1)
                respuesta = respuesta & "}}"

            Else
                respuesta = "{" & ch & "ID" & ch & ":" & ch & Id & ch & "," &
        ch & "PRGM" & ch & ":" & ch & "W3siaiIn1d" & ch & "," &
        ch & "success" & ch & ":false," &
        ch & "detalle" & ch & ":false," &
        ch & "message" & ch & ":" & ch & "No se encontraron registros" & ch
                respuesta = respuesta & "}"
            End If

        ElseIf Tipo = "Cmd" Then

            Dim ruta_ftp As String = ConfigurationSettings.AppSettings("ruta_ftp")
            Dim ruta_upload As String = ConfigurationSettings.AppSettings("ruta_upload")
            Dim sw As New StreamWriter(ruta_ftp & "RDOC-" & Valores & ".URL", False)
            sw.Write("DOC|" & Valores & "|")
            sw.Write(sw.NewLine)
            sw.Write("URL||")
            sw.Close()
            'Dim tablaE As New Data.DataTable
            'tablaE = CreaDataTable_("SELECT Document, Org_File, Version, DateTime, Fnl_File FROM Documents WHERE  Document = '" & Valores & "'")
            'For x = 0 To tablaE.Rows.Count - 1
            'System.IO.File.Delete(ruta_upload & "\" & Valor_(tablaE, x, 0) & ".XML")
            'Next


            Dim Query As String
            Query = "DELETE  FROM Documents WHERE Id = " & IdUser & " AND Document = '" & Valores & "'"
            EjecutaComando_(Query)
            respuesta = "{" & ch & "ID" & ch & ":" & ch & Id & ch & "," &
            ch & "PRGM" & ch & ":" & ch & "W3siaiIn1d" & ch & "," &
            ch & "success" & ch & ":true," &
            ch & "detalle" & ch & ":true," &
            ch & "message" & ch & ":" & ch & "Se ejecuto la sentencia!" & ch
            respuesta = respuesta & "}"


        End If


        Return respuesta
    End Function


    Public Shared Function CreaDataTable_(ByVal Comando As String) As Data.DataTable
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

    Public Shared Sub EjecutaComando_(ByVal Comando As String)
        Dim scnn As String

        scnn = ConfigurationSettings.AppSettings("conexion")
        Dim cnn As SqlConnection
        cnn = New SqlConnection(scnn)
        cnn.Open()
        Dim cmd As SqlCommand
        cmd = New SqlCommand(Comando, cnn)
        Try
            cmd.ExecuteNonQuery()
            If Not InStr(Comando, "INSERT INTO USUARIOS VALUES (") Then
                'MsgBox("Datos Guardados.", MsgBoxStyle.Exclamation, My.Application.Info.Title)
            End If
        Catch ex As Exception
            If InStr(ex.Message, "duplicate") Then
                'log_("Indice duplicado.")
            Else
                'log_(ex.Message)
            End If
        End Try
        cnn.Close()
    End Sub

    Public Shared Function Valor_(ByVal Tabla As Data.DataTable, ByVal fila As Integer, ByVal columna As Integer) As String
        Dim ValorRetorno As String
        ValorRetorno = Trim(Tabla.Rows(fila)(columna).ToString).ToString
        ValorRetorno = System.Web.HttpUtility.JavaScriptStringEncode(ValorRetorno)
        Return ValorRetorno
    End Function

    Public Shared Function Name_(ByVal Tabla As Data.DataTable, ByVal columna As Integer) As String
        Dim ValorRetorno As String
        ValorRetorno = Trim(Tabla.Columns(columna).ColumnName).ToString
        Return ValorRetorno
    End Function

    Public Function EncodeBase64(input As String) As String
        Return System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(input))
    End Function



</script>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>FileManager</title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
        <link rel="stylesheet" href="assets/css/Footer-Basic.css">
        <link rel="stylesheet" href="assets/css/Login-Form-Clean.css">
        <link rel="stylesheet" href="assets/css/Navigation-Clean.css">
        <link rel="stylesheet" href="assets/css/Newsletter-Subscription-Form.css">
        <link rel="stylesheet" href="assets/css/Registration-Form-with-Photo.css">
        <link rel="stylesheet" href="assets/css/styles.css">
    </head>
                                    <body>

                                    <div>
                                    <nav class="navbar navbar-light navbar-expand-md navigation-clean">
            <div class="container"><a class="navbar-brand" href="#">File Manager</a><button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse"
                    id="navcol-1">
                    <ul class="nav navbar-nav ml-auto">

                        <li class="dropdown nav-item">
                            <a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Menu</a>

                            <div class="dropdown-menu" role="menu">
                                <a class="dropdown-item" role="presentation" href="Upload.aspx">UpLoad</a>
                                <a class="dropdown-item" role="presentation" href="FileList.aspx">File List</a>
                                <a class="dropdown-item" role="presentation" href="Change.aspx">Change Password</a>
                                <a class="dropdown-item" role="presentation" href="LogOut.aspx">Log Out</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

    <div>
        <div class="container">
            <div class="row">
                <div class="col"></div>
                <div class="col"><input type="text" placeholder="Search" id="Serch" style="font-size: 10px;" onchange ="Consulta($(this).val())"/></div>
                <div class="col"></div>
            </div>
        </div>
    </div>    

<div style="margin: 10px;">
    <div class="table-responsive table-borderless text-monospace" style="margin: 0px;padding: 0px;font-size: 10px;">
        <table class="table table-striped table-bordered table-sm">
            <thead>
                <tr>
                    <th>Document</th>
                    <th>File</th>
                    <th>Version</th>
                    <th>Date Time</th>
                    <th>Options</th>
                </tr>
            </thead>
            <tbody id="Detalle">
  
            </tbody>
        </table>
    </div>
                                                                                                                                                                        </div>

    <div class="footer-basic">
        <footer>
                                                                                                        <p Class="copyright">360Soft © 2020</p>
        </footer>
    </div>
    <script src = "assets/js/jquery.min.js" ></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            valores = '{'
            valores += '"Tipo":"' + 'Qry' + '",';
            valores += '"Id":"' + 'CONSULTA' + '",';
            valores += '"Valores":""}';
            //alert(valores)
            enviar("Consulta", valores);
        });

        function Consulta(valor) {
//            var valor = '';
//          valor = $("#Serch").val();
          $(document).ready(function () {
              valores = '{'
              valores += '"Tipo":"' + 'Qry' +    '",';
              valores += '"Id":"' + 'CONSULTA' + '",';
              valores += '"Valores":"' + valor + '"}';
              //alert(valores)
              enviar("Consulta", valores);
          });
      }
      function enviar(ID, Valores) {
                //alert(ID)
                //alert(Valores)
                //'{ide: "' + ide + '",anio: "' + anio + '",mes: "' + mes + '",tipo: "' + tipo + '"}'
                $.ajax({
                    type: "POST",
                    url: "FileList.aspx/" + ID,
                    data: Valores,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    }
                });
       }

      function inicioEnvio() {
                //    alert ("Inicio envio...");
      }
        function OnSuccess(datos) {
                
                var obj = jQuery.parseJSON(datos.d);
            var Resultado = "";
            var chr = '"';
            if (obj.success) {                    
                    switch (obj.ID) {
                        case 'CONSULTA':
                            $("#Detalle").empty();
                            $.each(obj.data, function (key, value) {

                                var Document = ''

                                $.each(value, function (key, value) {

                                    switch (key) {
                                        case 'Document': 
                                            Resultado = Resultado + "<tr><td>" + value + "</td>"
                                            Document = value
                                            break;
                                        case 'Org_File':                                            
                                            Resultado = Resultado + "<td>" + value +"</td>"
                                            break;
                                        case 'Version':
                                            Resultado = Resultado + "<td>" + value +"</td>"
                                            break;
                                        case 'DateTime':
                                            Resultado = Resultado + "<td>" + value +"</td>"
                                            break;
                                        case 'Fnl_File':
                                            Resultado = Resultado + "<td> <button> <a href='" + value + "' target='_blank'> See</a> </button> <button onclick='Rmv(" + chr + Document + chr + ")'>Rmv</button>  </td> </tr>"
                                            break;
                                        case 'Fnl_Fl':
                                            Resultado = Resultado + "<td> <button> <a href='" + value + "' target='_blank'> See</a> </button>  </td> </tr>"
                                            break;

                                    }
                                });
                            });                   
                            //alert(Resultado)
                            $("#Detalle").append(Resultado)
                            break;
                        case 'DELETE':
                            Consulta('')
                            break;
                        
                        default:
                        alert(datos);
                    }
                }
                else {
                    alert(obj.message)
                    $("#Detalle").empty();
                }
            }

      function problemas() {
                alert("Error de transaccion.");
            }

      function scp(Valor) {
                Valor = encodeURI(Valor);
                return Valor
            }
        function Rmv(Document) {

            if (confirm('Delete File related to document ' + Document + ' ?')) {
                valores = '{'
                valores += '"Tipo":"' + 'Cmd' + '",';
                valores += '"Id":"' + 'DELETE' + '",';
                valores += '"Valores":"'+Document+'"}';
                //alert(valores)
                enviar("Consulta", valores);         
            }




        }

    </script>
  
</body>
        
</html>
