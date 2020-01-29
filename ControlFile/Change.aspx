<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Change.aspx.vb" Inherits="ControlFile.Change" %>

<!DOCTYPE html>

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

    <div class="register-photo">
        <div class="form-container">
            <div class="image-holder"></div>
            <form id="form1" runat="server">
                <h2 class="text-center"><strong>Change</strong> password.</h2>
                <div class="form-group">
                    <asp:TextBox ID="passwordo"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Old Password" MaxLength="20"></asp:TextBox>
                    <div class="form-group">                                    
                        <asp:Label ID="paso" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="password"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Password" MaxLength="20"></asp:TextBox>
                    <div class="form-group">                                    
                        <asp:Label ID="pas" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="passwordr"  type="password" name="password" CssClass="form-control" runat="server" TextMode="Password"  placeholder="Password (repeat)" MaxLength="20"></asp:TextBox>
                    <div class="form-group">                                    
                        <asp:Label ID="pasr" runat="server" Text="" ForeColor="Red" Visible="False"></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    
                    <asp:Button type ="submit"  ID="Button1" runat="server" Text="Update"  CssClass="btn btn-primary active btn-block" />
                </div>
            </form>
        </div>
    </div>


    <div class="footer-basic">
        <footer>
            <p Class="copyright">360Soft © 2020</p>
        </footer>
    </div>
    <script src = "assets/js/jquery.min.js" ></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>