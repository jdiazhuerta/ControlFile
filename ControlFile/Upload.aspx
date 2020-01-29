<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Upload.aspx.vb" Inherits="ControlFile.Upload" %>

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



    <style type="text/css">
       
        .illustration {
          text-align: center;
          padding: 0 0 20px;
          font-size: 100px;
          color: rgb(174,163,165);
        }

        #dropSection
        {
            height: 300px;            
            background-color: skyblue;
        }
        
        #btnUpload
        {
            display: none;
        }
      

    </style>
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

    <div id="dropSection">

        <div class="illustration"><i class="icon ion-social-dropbox"></i></div>
                    <div class="col text-center text-black-50">
                        <small><strong>Second:</strong> Drag your file here</small>
                    </div>
        
    </div>
    <br />
    

<div>
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="row">
                    <div class="col text-center">
                        <input type="text" placeholder="# Document" id="Docto"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col text-center text-black-50">
                        <small><strong>First:</strong> Enter the delivery number</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</div>


    


    <div id="uploadedFiles">
    </div>
    <input type="button" id="btnUpload" value="Upload" />
    <div class="footer-basic">
        <footer>
            <p class="copyright">360Soft © 2020</p>
        </footer>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    
    <script src="Scripts/filedrop.js"></script>
    <script type="text/javascript">        
        $(function () {
            $("#dropSection").filedrop({
                fallback_id: 'btnUpload',
                fallback_dropzoneClick: true,
                url: '<%=ResolveUrl("~/HandlerVB.ashx")%>',
                //allowedfiletypes: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/doc'],
                allowedfileextensions: ['.doc', '.docx', '.pdf', '.jpg', '.jpeg', '.png', '.gif'],
                paramname: 'fileData',
                data: {
                    param1: 'value1', 			// send POST variables
                    param2: function () {
                        return $("#Docto").val(); // calculate data at time of upload
                    },
                },
                maxfiles: 1, //Maximum Number of Files allowed at a time.
                maxfilesize: 2, //Maximum File Size in MB.
                dragOver: function () {
                    $('#dropSection').addClass('active');
                },
                dragLeave: function () {
                    $('#dropSection').removeClass('active');
                },
                drop: function () {
                    $('#dropSection').removeClass('active');                    
                },
                uploadFinished: function (i, file, response, time) {

                    $('#uploadedFiles').append($("#Docto").val() + " - " + file.name + '<br />');

                    $("#Docto").val("");

                },
                afterAll: function (e) {
                    
                    //To do some task after all uploads done.
                    alert("Upload Finished!")
                },
                beforeSend: function (file, i, done) {
                    var Doc = ""
                    Doc = $("#Docto").val()
                    if (Doc != "") {
                        //alert(Doc.length)
                        if (Doc.length >= 10) {
                            if (confirm('Upload File and related with Document ?')) {
                                done();
                            }
                        }
                        else {
                            alert("Document length must have at least 10 characters");
                        }
                    } else {
                        alert ("You need to capture # Document first!");
                    }

                    // file is a file object
                    // i is the file index
                    // call done() to start the upload
                }
            })
        })
    </script>
</body>
</html>