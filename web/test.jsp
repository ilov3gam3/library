<!DOCTYPE html>
<html>
<head>
    <title>PDF.js Byte Array Rendering</title>
    <!-- Include PDF.js library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.6.347/pdf.js" integrity="sha512-P/HN5l+O8ovwpe3layxRDin3RTk1kbHlnxe3KBmqqhjrVUebBE769mPVvGO5qcZGJG4uJAppkmchRMrFainTFg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.6.347/pdf.worker.js" integrity="sha512-pJzvZrVxPmP3FaObZnxajtAkLVTmPZguSaaBlOg3DD89rtKOA/wDj/YkQ6cYKBv2GamBBv+iAI0wEIpSXtMs5w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<h1>PDF.js Byte Array Rendering</h1>
<iframe src="http://docs.google.com/gview?url=/uploads/94bf775e-ef9f-4735-a658-38a27001e7cc.pdf&embedded=true"
        style="width:600px; height:500px;" frameborder="0"></iframe>
<%--<script>
    var pdfViewer = document.getElementById('pdf-container');
    var pdfBytes;

    // Fetch the PDF byte array from your endpoint
    fetch('http://localhost:8080/library/user/view-pdf?book_id=7')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.arrayBuffer();
        })
        .then(data => {
            pdfBytes = new Uint8Array(data);

            // Initialize the PDF.js viewer
            pdfjsLib.getDocument({ data: pdfBytes }).promise.then(function (pdf) {
                var numPages = pdf.numPages;
                var pageNum = 1;  // Start with the first page

                function renderPage(pageNum) {
                    pdf.getPage(pageNum).then(function (page) {
                        var canvas = document.createElement('canvas');
                        pdfViewer.appendChild(canvas);
                        var context = canvas.getContext('2d');
                        var viewport = page.getViewport({ scale: 1 });

                        canvas.height = viewport.height;
                        canvas.width = viewport.width;

                        var renderContext = {
                            canvasContext: context,
                            viewport: viewport
                        };

                        page.render(renderContext);

                        if (pageNum < numPages) {
                            // Render the next page if available
                            renderPage(pageNum + 1);
                        }
                    });
                }

                renderPage(pageNum);
            }).catch(error => {
                console.error('Error loading PDF: ', error);
            });
        })
        .catch(error => {
            console.error('Error fetching PDF: ', error);
        });
</script>--%>
<%--<script>--%>
<%--    var pdfViewer = document.getElementById('pdf-container');--%>
<%--    var pdfBytes;--%>

<%--    // Fetch the PDF byte array from your endpoint--%>
<%--    fetch('http://localhost:8080/library/user/view-pdf?book_id=4')--%>
<%--        .then(response => {--%>
<%--            if (!response.ok) {--%>
<%--                throw new Error('Network response was not ok');--%>
<%--            }--%>
<%--            return response.arrayBuffer();--%>
<%--        })--%>
<%--        .then(data => {--%>
<%--            pdfBytes = new Uint8Array(data);--%>

<%--            // Initialize the PDF.js viewer--%>
<%--            pdfjsLib.getDocument({ data: pdfBytes }).promise.then(function (pdf) {--%>
<%--                var numPages = pdf.numPages;--%>

<%--                // Use a while loop and for loop to render pages--%>
<%--                var pageNum = 1;--%>
<%--                while (pageNum <= numPages) {--%>
<%--                    if (pageNum === numPages - 1){--%>
<%--                        console.log("done load")--%>
<%--                    }--%>
<%--                    pdf.getPage(pageNum).then(function (page) {--%>
<%--                        var canvas = document.createElement('canvas');--%>
<%--                        pdfViewer.appendChild(canvas);--%>
<%--                        var context = canvas.getContext('2d');--%>

<%--                        // Adjust the width and height of the viewport as needed--%>
<%--                        var viewport = page.getViewport({ scale: 2 });--%>

<%--                        canvas.height = viewport.height;--%>
<%--                        canvas.width = viewport.width;--%>

<%--                        var renderContext = {--%>
<%--                            canvasContext: context,--%>
<%--                            viewport: viewport--%>
<%--                        };--%>

<%--                        page.render(renderContext);--%>
<%--                        pdfViewer.appendChild(document.createElement('br'));--%>
<%--                    });--%>
<%--                    pageNum++;--%>
<%--                }--%>
<%--            }).catch(error => {--%>
<%--                console.error('Error loading PDF: ', error);--%>
<%--            });--%>
<%--        })--%>
<%--        .catch(error => {--%>
<%--            console.error('Error fetching PDF: ', error);--%>
<%--        });--%>
<%--</script>--%>
</body>
</html>
