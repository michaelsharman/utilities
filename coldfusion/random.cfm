<cfscript>

/**
* Returns a random key based on specific rules
* Usage:
* 	myKey = generateRandomKey();
* 	generateRandomKey(case="mixed", format="alphanumeric", length="8");
* @author Michael Sharman (michael@chapter31.com)
* @param case {string} Whether upper, lower or mixed
* @param format {string} Whether to generate `numeric`, `string`, `alphanumeric` or `special` (includes alphanumeric and special characters such as ! @ & etc)
* @param invalidCharacters {string} List of invalid characters which will be excluded from the key. This overrides the default list
* @param length {string} The length of the key to generate
* @param numericPrefix {string} Number of random digits to start the key with (the rest of the key will be whatever the 'format' is)
* @param numericSuffix {string} Number of random digits to end the key with (the rest of the key will be whatever the 'format' is)
* @param fixedPrefix {string} A prefix prepended to the generated key. The length of which is subtracted from the 'length' argument
* @param fixedSuffix {string} A suffix appended to the generated key. The length of which is subtracted from the 'length' argument
* @param specialChars {string} List of special chars to help generate key from. Overrides the default 'characterMap.special' list
* @param debug {boolean} Returns cfcatch information in the event of an error. Try turning on if function returns no value.
*/
public string function generateRandomKey(string case="upper", string format="alphanumeric", string invalidCharacters="", numeric length=8, numeric numericPrefix=0, numeric numericSuffix=0, string fixedPrefix="", string fixedSuffix="", string specialChars="", boolean debug=false)
{
	var i = 0;
	var key = "";
	var keyCase = arguments.case;
	var keyLength = arguments.length;
	var uniqueChar = "";
	var invalidChars = "o,i,l,s,O,I,L,S";	 //Possibly confusing characters we will remove
	var characterMap = {};
	var characterLib = "";
	var libLength = 0;

	try
	{
		characterMap.numeric = "0,1,2,3,4,5,6,7,8,9";
		characterMap.stringLower = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
		characterMap.stringUpper = UCase(characterMap.stringLower);
		characterMap.stringCombined = listAppend(characterMap.stringLower, characterMap.stringUpper);

		if (len(trim(arguments.specialChars)))
		{
			characterMap.special = arguments.specialChars;
		}
		else
		{
			characterMap.special = "!,@,##,$,%,^,&,*,(,),_,-,=,+,/,\,[,],{,},<,>,~";
		}

		switch (arguments.format)
		{
			case "numeric":
				characterLib = characterMap.numeric;
				break;
			case "string":
				if (keyCase == "upper")
				{
					characterLib = characterMap.stringUpper;
				}
				else if (keyCase == "lower")
				{
					characterLib = characterMap.stringLower;
				}
				else if (keyCase == "mixed")
				{
					characterLib = characterMap.stringCombined;
				}
				break;
			case "alphanumeric":
				invalidChars = invalidChars.concat(",0,1,5");	//Possibly confusing chars removed
				if (keyCase == "upper")
				{
					characterLib = listAppend(characterMap.numeric, characterMap.stringUpper);
				}
				else if (keyCase == "lower")
				{
					characterLib = listAppend(characterMap.numeric, characterMap.stringLower);
				}
				else if (keyCase == "mixed")
				{
					characterLib = listAppend(characterMap.numeric, characterMap.stringCombined);
				}
				break;
			case "special":
				invalidChars = invalidChars.concat(",0,1,5");		//Possibly confusing chars removed
				if (keyCase == "upper")
				{
					characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringUpper), characterMap.special);
				}
				else if (keyCase == "lower")
				{
					characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringLower), characterMap.special);
				}
				else if (keyCase == "mixed")
				{
					characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringCombined), characterMap.special);
				}
				break;
		}

		if (len(trim(arguments.invalidCharacters)))
		{
			invalidChars = arguments.invalidCharacters;
		}

		if (len(trim(arguments.fixedPrefix)))
		{
			key = arguments.fixedPrefix;
			keyLength = keyLength - len(trim(arguments.fixedPrefix));
		}

		if (len(trim(arguments.fixedSuffix)))
		{
			keyLength = keyLength - len(trim(arguments.fixedSuffix));
		}

		libLength = listLen(characterLib);

		for (i = 1;i <= keyLength;i=i+1)
		{
			do
			{
				if (arguments.numericPrefix > 0 && i <= arguments.numericPrefix)
				{
					uniqueChar = listGetAt(characterMap.numeric, randRange(1, listLen(characterMap.numeric)));
				}
				else if (arguments.numericSuffix > 0 && keyLength-i < arguments.numericSuffix)
				{
					uniqueChar = randRange(characterMap.numeric, randRange(1, listLen(characterMap.numeric)));
				}
				else
				{
					uniqueChar = listGetAt(characterLib, randRange(1, libLength));
				}
			}
			while (listFind(invalidChars, uniqueChar));
			key = key.concat(uniqueChar);
		}

		if (len(trim(arguments.fixedSuffix)))
		{
			key = key.concat(trim(arguments.fixedSuffix));
		}
	}
	catch (Any e)
	{
		if (arguments.debug)
			key = e.message & " " & e.detail;
		else
			key = "";
	}

	return key;
}

</cfscript>
