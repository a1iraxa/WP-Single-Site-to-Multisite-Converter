#!/bin/bash
MULTISITE_DB_PREFIX_SED="wp_7s225g_";
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
read SITE_ID;

# parsing the replacement of the database prefix
PREFIX_SED="s#";
PREFIX_SED+=$OLD_DB_PREFIX_SED;
PREFIX_SED+="#";
PREFIX_SED+=$MULTISITE_DB_PREFIX_SED;
PREFIX_SED+=$SITE_ID;
PREFIX_SED+="_";
PREFIX_SED+="#g";

sed $PREFIX_SED $DB_FILE > $TEMP_FILE;

# parsing the replacement of site URL
URL_SED="s#";
URL_SED+="https://";
URL_SED+=$OLD_SUBDOMAIN;
URL_SED+=".uwosh.edu#http://localhost/";
URL_SED+=$NEW_HOMEPAGE;
URL_SED+="#g";

sed $URL_SED $TEMP_FILE > $TEMP_FILE;

# parsing the replacement of the media library URL
MEDIA_PATH="s#";
MEDIA_PATH+="wp-content/uploads#wp-content/uploads/sites/";
MEDIA_PATH+=$SITE_ID;
MEDIA_PATH+="#g";

sed $MEDIA_PATH $TEMP_FILE > $TEMP_FILE;

# setting the upload path back to what it should be
UPLOAD_PATH="s#";
UPLOAD_PATH+="\'upload_path\',\ \'wp-content/uploads/sites/";
UPLOAD_PATH+=$SITE_ID;
UPLOAD_PATH+="#\'upload_path\',\ \'wp-content/uploads#g";

echo $UPLOAD_PATH;

sed $UPLOAD_PATH $TEMP_FILE > $TEMP_FILE;

FIXED_DB_FILE="FIXED_";
FIXED_DB_FILE+=$DB_FILE;

# writing the fixed database back to a file
cp $TEMP_FILE $FIXED_DB_FILE;

# removing the temp file
rm $TEMP_FILE;

exit 0;