<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Register.aspx.vb" Inherits="ControlFile.Register" %>

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
    
    
    <div class="register-photo">
        <div class="form-container">
            <div class="image-holder"></div>
            <form id="form1" runat="server">
                <h2 class="text-center"><strong>Create</strong> an account.</h2>
                <div class="form-group">                    
                    <asp:TextBox ID="email" type="email" name="email" runat="server" CssClass ="form-control" MaxLength="50" placeholder="Email"></asp:TextBox>
                </div>
                    <div class="form-group">                                    
                        <asp:Label ID="rema" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                <div class="form-group">                    
                    <asp:TextBox ID="password"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Password" MaxLength="20"></asp:TextBox>
                </div>
                    <div class="form-group">                                    
                        <asp:Label ID="rpas" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                <div class="form-group">                    
                    <asp:TextBox ID="passwordr"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Password (repeat)" MaxLength="20"></asp:TextBox>
                </div>
                    <div class="form-group">                                    
                        <asp:Label ID="rpasr" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                <div class="form-group">
                    <asp:TextBox ID="name" type="text" name="name" runat="server" CssClass ="form-control" MaxLength="50" placeholder="Name"></asp:TextBox>
                </div>
                       <div class="form-group">                                    
                        <asp:Label ID="rnam" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                <div class="form-group">                    
                    <asp:Button type ="submit"  ID="Button1" runat="server" Text="Sign Up"  CssClass="btn btn-primary active btn-block" />
                </div>
                    <a class="already" href="index.aspx">You already have an account? Login here.</a>
            </form>
        </div>
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

