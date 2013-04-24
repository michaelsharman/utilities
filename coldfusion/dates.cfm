<cfscript>

/**
* @hint Returns a date object for the last day of the month
* @param d {date} Optional date object to return the end of month for
*/
public date function getEndOfMonth(date d)
{
	var dateToCheck = (structKeyExists(arguments, "d")) ? arguments.d : now();
	return createODBCDate(year(dateToCheck) & "/" & month(dateToCheck) & "/" & daysInMonth(dateToCheck));
}


/**
* @hint Returns a date object for the first day of the month
* @param d {date} Optional date object to return the start of month for
*/
public date function getStartOfMonth(date d)
{
	var dateToCheck = (structKeyExists(arguments, "d")) ? arguments.d : now();
	return createODBCDate(year(dateToCheck) & "/" & month(dateToCheck) & "/01");
}

</cfscript>
