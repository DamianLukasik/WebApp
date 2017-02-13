<%-- 
    Document   : index
    Created on : 2017-02-10, 14:45:38
    Author     : user
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date" %>
<%@page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Today's date</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
    </head>
    <%
        Date date = new Date();
        int timeSize = 5;
        
        ArrayList<String> resource = new ArrayList<String>();
        resource.add("Woda 1");
        resource.add("Woda 2");
        resource.add("Woda 3");
        resource.add("Woda 4");
        resource.add("Woda 5");
        
        ArrayList<String> itimespend = new ArrayList<String>();
        itimespend.add("Węgiel 1");
        itimespend.add("Węgiel 2");
        itimespend.add("Węgiel 3");
        itimespend.add("Węgiel 4");
        itimespend.add("Węgiel 5");
    %>
    <body>
        <h1>Today's date</h1>
        <p>Today is <%= date %></p>
        <br>
        
        <!--
        <button>Pobierz plik główny</button>
        -->
        
        <form name="uploadForm" action="index.jsp" method="POST" enctype="multipart/form-data">
        
            <%
                String saveFile = new String();
                String contentType = request.getContentType();

                if((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))                {
                
                    DataInputStream in = new DataInputStream(request.getInputStream());
                    
                    int formDataLength = request.getContentLength();
                    byte dataBytes[] = new byte[formDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
                    
                    while(totalBytesRead < formDataLength){
                        byteRead = in.read(dataBytes,totalBytesRead, formDataLength);
                        totalBytesRead += byteRead;
                    }    
                    
                    String file = new String(dataBytes);
                    
                    saveFile = file.substring(file.indexOf("filename=\"")+10);
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));

                    int lastIndex = contentType.lastIndexOf("*");

                    String boundary = contentType.substring(lastIndex + 1, contentType.length());

                    int pos;


                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;

                    int boundaryLocation = file.indexOf(boundary, pos) - 4;

                    int startPos = ((file.substring(0, pos)).getBytes()).length;
                    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                    
                    saveFile = "C:/uploadFile/" + saveFile; 
                    
                    File ff = new File(saveFile);
                    
                    try{
                        FileOutputStream fileOut = new FileOutputStream(ff);
                        fileOut.write(dataBytes, startPos, (endPos - startPos));
                        fileOut.flush();
                        fileOut.close();                    
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    
                }
                %>


            <div class="browse-wrap">
                <div class="title">Pobierz plik główny</div>
                <input type="file" name="upload" class="upload" title="Wybierz plik do odczytania">
            </div>
            <span class="upload-path"></span> 
                        
  
            <script>
                // Span
                var span = document.getElementsByClassName('upload-path');
                // Button
                var uploader = document.getElementsByName('upload');
                // On change
                for( item in uploader ) {
                  // Detect changes
                  uploader[item].onchange = function() {
                    // Echo filename in span
                    span[0].innerHTML = this.files[0].name;
                  }
                }    
            </script>
                
            <!-- 
            <input type="file" name="file" value="" width="100" />            
            -->
            <input type="submit" value="Submit" name="submit" />
        </form>
        <br>
        <table>
        <%
            for ( int i =0; i < timeSize ; i++)
            {              
            %>
            <tr>
                <td> <%=resource.get(i)%></td>
                <td> <%=itimespend.get(i)%></td>
            </tr>
            <%       
            }
        %>
        </table>        
        <br>
    </body>
</html>
