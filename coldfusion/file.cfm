<cfscript>

/**
* @hint Returns the operating system file path separator
*/
public string function getFileSeparator()
{
	return createObject("java", "java.io.File").separator;
}


/**
* @hint Returns the operating system line separator
*/
public any function getLineSeparator()
{
	return createObject("java", "java.lang.System").getProperty("line.separator");
}

</cfscript>
