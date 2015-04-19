
<link rel="stylesheet" href="/css/index.css">

<section>
	<cfoutput>
		<cfloop from="1" to="3" index="i">
			<section id="home#i#">
				<cfloop query="VARIABLES.viewdata.news.data">

					<article>
						<header>#title#</header>
						<p class="pubDate">#pubdate#</p>
						<p>#Left(description, 760)# <span><a href="/index/Tucson_Local_News/#URLEncodedFormat(Replace(title, ' ','_','ALL'))#/#id#/article.cfm">[ Read More ]</a></span></p>
					</article>

				</cfloop>
			</section>
		</cfloop>
		<br clear="both">
	</cfoutput>
</section>

