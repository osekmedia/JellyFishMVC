<link rel="stylesheet" href="/css/article.css">

<section id="article">
	<cfoutput query="VARIABLES.viewdata.news.data">
		<header>#title#</header>
		<p>Date: #pubDate#</p>
		<p>#description#</p>
	</cfoutput>
</section>

