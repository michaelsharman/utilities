<cfscript>
try
{
	include "dates.cfm";
	include "file.cfm";
	include "random.cfm";

	dateStart = getStartOfMonth();
	dateEnd = getEndOfMonth();
	fileSeparator = getFileSeparator();
	lineSeparator = getLineSeparator();
	random = generateRandomKey();
}
catch (any e)
{
	dump(var=e);
	abort;
}
</cfscript>

<cfoutput>
<h3>Dates</h3>
<p>Start of month: #dateStart#</p>
<p>End of month: #dateEnd#</p>

<h3>File System</h3>
<p>File separator: #fileSeparator#</p>
<p>Line break character(s): #asc(lineSeparator)#</p>

<h3>Random String</h3>
<p>Key: #random#</p>
</cfoutput>
