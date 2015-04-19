<!--- 
Erin Duvall
10/21/2014
This is the layout template file. All views are loaded into the file using the mainContent variable.
--->

<!DOCTYPE html>
<html>
	<head>
		<meta charset='utf-8'/>
		<title>Tucson Local News</title>

		<link rel="stylesheet" href="/css/global.css">
		<link rel="stylesheet" href="/css/colorbox.css">

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="/js/jquery.colorbox-min.js"></script>
		<script src="/js/global.js"></script> 

	</head>
	<body>
		
		<header id="top">
			<h1>Tucson Local News</h1>
		</header>
		<section id="view">
			<cfoutput>#mainContent#</cfoutput>
		</section>
		<!---<section id="footer">
			<p>Developed by: <a href="mailto:osekmedia@gmail.com">Erin Duvall</a></p>
		</section>--->
		
	</body>
</html>
