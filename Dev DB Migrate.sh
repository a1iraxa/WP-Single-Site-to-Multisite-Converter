#!/bin/bash
MultisiteDBPrefixSED="t9k3mh8a4p_";
TEMP_FILE="tmp.txt";

echo "Enter the file of your database:";
read DB_FILE;
if [ ! -f $DB_FILE ]; then
    echo "That file was not found!";
    exit 0;
fi

echo "Enter the old subdomain (financialaid) of the website:";
read OLD_SUBDOMAIN;

echo "Enter the new homepage (financial-aid) of the website:";
read NEW_HOMEPAGE;

echo "Enter the old database prefix:";
read OLD_DB_PREFIX_SED;

echo "Enter the new site id:";
read SiteID;
SiteID+="_";

# parsing the replacement of the database prefix
sed s#$OLD_DB_PREFIX_SED#$MultisiteDBPrefixSED$SiteID#g $DB_FILE > temp1.txt;

# parsing the replacement of site URL
sed s#https://$OLD_SUBDOMAIN.uwosh.edu#https://wwwdev.uwosh.edu/$NEW_HOMEPAGE#g temp1.txt > temp2.txt;

# parsing the replacement of the media library URL
sed s#wp-content/uploads#wp-content/uploads/sites/$SITE_ID#g temp2.txt > temp3.txt;

# setting the upload path back to what it should be
sed s#'upload_path',\ 'wp-content/uploads/sites/$SITE_ID#'upload_path',\ 'wp-content/uploads#g temp3.txt > temp4.txt;

FIXED_DB_FILE="FIXED_";
FIXED_DB_FILE+=$DB_FILE;

# writing the fixed database back to a file
cat temp4.txt > $FIXED_DB_FILE;

# removing all temp files
rm temp*;

exit 0;