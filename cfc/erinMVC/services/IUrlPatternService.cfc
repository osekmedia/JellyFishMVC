/**
* @author Erin Duvall
* @extends IPatternParser
**/
interface {
	public struct function parseUrlPattern( required string pattern, struct queryParams = {}, struct formParams = {}, required string apiFolder );
}