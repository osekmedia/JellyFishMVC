/**
* @author Erin Duvall
* @description model to get news
* @accessors true
* @extends model
* @output false
**/

component {

	public model function init() {
		SUPER.init();
		return this;
	}

	public struct function get() {

		return _getNews( "SELECT description, id, pubdate, title From news WHERE category_id = 1 and pubdate <= now() AND pubdate > " & DateAdd( 'd', -30, now() ) & " ORDER BY source_id, pubdate DESC LIMIT 55" );
	}

	public struct function details( numeric id = 0 ) {

		return _getNews( "SELECT description, id, pubdate, title, link FROM news WHERE id = " & ARGUMENTS.id );
	}

	private struct function _getNews( required string sql ) {
		var loc = {
			returnObj = {},
			qry = new query()
		};

		//Test news query
		loc.result = loc.qry.execute(sql = ARGUMENTS.sql );
		loc.returnObj.data = loc.result.getResult();
		loc.returnObj.meta = loc.result.getPrefix();

		return loc.returnObj;
	}

}

