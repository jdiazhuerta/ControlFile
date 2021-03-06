﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="index.aspx.vb" Inherits="ControlFile.index" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>FileManager</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/Footer-Basic.css">
    <link rel="stylesheet" href="assets/css/Login-Form-Clean.css">
    <link rel="stylesheet" href="assets/css/Newsletter-Subscription-Form.css">
    <link rel="stylesheet" href="assets/css/Registration-Form-with-Photo.css">
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>  

    <div class="login-clean">
        
        <form id="form1" runat="server">

            <h2 class="sr-only">Login Form</h2>
            <div class="illustration"><i class="icon ion-social-dropbox"></i></div>
            <div class="form-group">                
                <asp:TextBox ID="email" type="email" name="email" runat="server" CssClass ="form-control" placeholder="Email" MaxLength="50"></asp:TextBox>

            </div>
            <div class="form-group">
                
                <asp:TextBox ID="password"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Password" MaxLength="20"></asp:TextBox>
            </div>

            <div class="form-group">                                    
                <asp:Label ID="RFV" runat="server" Text="Usuario o Password no válido." ForeColor="Red" Visible="False"></asp:Label>
            </div>
            <a class="forgot" href="Forgot.aspx">Forgot your email or password?</a>
            <div class="form-group">
                <asp:Button type ="submit"  ID="Button1" runat="server" Text="Log In"  CssClass="btn btn-primary active btn-block" />
            </div>
            <a class="forgot" >Register</a>
            <a class="forgot" href="Register.aspx">You don´t have an account yet?</a>
            


        </form>
    </div>
    <div class="footer-basic">
        <footer>
            <p class="copyright">360Soft © 2020</p>
        </footer>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
