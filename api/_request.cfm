<cfsetting enablecfoutputonly="yes">

<cfset VARIABLES.response = getPageContext().getResponse()>
<cfset response.setContentType("application/json")>

<cfif StructKeyExists( VARIABLES, "viewData")>
	<cfif IsStruct( VARIABLES.viewData )>
		<cfoutput>#SerializeJson( VARIABLES.viewData )#</cfoutput>
	</cfif>
</cfif>