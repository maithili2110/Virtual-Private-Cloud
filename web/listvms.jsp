<%@ page import="java.sql.*" %>
<%@ page import="cmpe283Project.CloudManager" %>
<%--
  Created by IntelliJ IDEA.
  User: Varun
  Date: 4/11/2015
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../../favicon.ico">
    <title>List VMs</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootswatch/3.2.0/paper/bootstrap.min.css">
</head>
<body background="images/backgroundPic.jpg">
</br>
</br>
<%
    if(session.getAttribute("userName") == null) {
        response.sendRedirect("error.jsp?error=No session.. You must login to see the page");
    }
%>
<div class="container">
    <div class="row vcenter">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>List of VMs</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <%! String userName;
                                String vmName;
                            %>
                            <%
                                Connection con= null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;

                                String driverName = "com.mysql.jdbc.Driver";
                                String url = "jdbc:mysql://localhost:3306/cmpe283";
                                String user = "root";
                                String dbpsw = "";

                                String usrName = request.getParameter("userName");
                                String powerStats = "";
                                String sql = "select * from vm_users where userName=?";
                                try {
                                    Class.forName(driverName);
                                    con = DriverManager.getConnection(url, user, dbpsw);
                                    ps = con.prepareStatement(sql);
                                    ps.setString(1, usrName);
                                    rs = ps.executeQuery();
                                    while(rs.next())
                                    {
                                        userName = rs.getString("userName");
                                        vmName = rs.getString("vmName");
                                        if(usrName.equals(userName))
                                        {
                                            powerStats = CloudManager.getPowerStatus(vmName);
                                            if(powerStats != null) {
                                                out.println("<label style='margin-left: 100px'>VM Name: "+ vmName + "&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Power Status: "+ powerStats +"</label></br>");
                                            }
                                        }
                                    }
                                    rs.close();
                                    ps.close();
                                }
                                catch(Exception sqe)
                                {
                                    out.println(sqe);
                                }
                            %>
                        </div>
                    </form>
                </div>
                <div class="panel-footer clearfix">
                    <div class="pull-left">
                        <a href="welcome.jsp" class="btn btn-primary">Go Back to Home?</a>
                    </div>
                    <div class="pull-right">
                        <a href="logout.jsp" class="btn btn-primary">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
