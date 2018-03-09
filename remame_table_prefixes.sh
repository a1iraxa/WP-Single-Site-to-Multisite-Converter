#!/bin/bash
MultisiteDBPrefixSED="t9k3mh8a4p_";
TEMP_FILE="tmp.txt";

echo "Enter the file of your database:";
read DB_FILE;
if [ ! -f $DB_FILE ]; then
    echo "That file was not found!";
    exit 0;
fi

echo "Enter the old database prefix:";
read OLD_DB_PREFIX_SED;

echo "Enter the new site id:";
read SiteID;
SiteIDWithUnderscore=$SiteID"_";

# parsing the replacement of the database prefix
sed s#$OLD_DB_PREFIX_SED#$MultisiteDBPrefixSED$SiteIDWithUnderscore#g $DB_FILE > temp1.txt;

FIXED_DB_FILE="FIXED_";
FIXED_DB_FILE+=$DB_FILE;

# writing the fixed database back to a file
cat temp1.txt > $FIXED_DB_FILE;

# removing all temp files
rm temp*;

exit 0;