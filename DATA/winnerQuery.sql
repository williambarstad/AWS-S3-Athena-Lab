SELECT RACES."name" raceName,
	RACES.DATE raceDate,
	DRIVERS.FORENAME || ' ' || DRIVERS.SURNAME Winner ,
	DRIVERS.NUMBER carNumber
FROM IMPORT.RACES RACES
JOIN IMPORT.RESULTS RESULTS ON RACES.RACEID = RESULTS.RACEID
JOIN IMPORT.DRIVERS DRIVERS ON RESULTS.DRIVERID = DRIVERS.DRIVERID
WHERE RACES."year" = '2020'
	AND RESULTS."position" = '1'