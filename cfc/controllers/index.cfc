/**
* @author Erin Duvall
* @description index page controller
* @extends controller
* @accessors true
**/

component {

	public controller function init() {
		SUPER.init();
		return this;
	}

	public struct function index() {
		var loc = {};

		loc.news = APPLICATION.mvc.model.new( "news" );
		loc.returnObj = { news = loc.news.get() };

		return loc.returnObj;
	}

	public struct function article() {
		var loc = {};
		loc.key = StructKeyExists(ARGUMENTS, "key") ? ARGUMENTS.key : 0;
		loc.news = APPLICATION.mvc.model.new( "news" );
		loc.returnObj = { news = loc.news.details( loc.key ) };

		return loc.returnObj;
	}

}