#!/bin/bash
WPMAKE_PATH=`dirname $0`
source $WPMAKE_PATH/wpmake-config.sh

SITE=$1
DB_NAME=$2

# make the DB
mysqladmin -u $DB_USER -p$DB_PASS create $DB_NAME

wget http://wordpress.org/latest.zip
unzip latest.zip
mv wordpress $SITE
rm latest.zip

# get in to project folder
cd $SITE 

# delete some files
rm wp-content/plugins/hello.php
rm -rf wp-content/themes/twentyeleven
rm readme.html

sed 's/wp-starter-db/'$DB_NAME'/g;s/wp-starter-user/'$DB_USER'/g;s/wp-starter-pass/'$DB_PASS'/g;' $WPMAKE_PATH/wpmake.wp-config.php > wp-config.php

# rcopy my starter based on enfold
cp -R $WPMAKE_PATH/wpmake-themes/wp-starter wp-content/themes/$SITE
cp -R $WPMAKE_PATH/wpmake-themes/enfold wp-content/themes/enfold

mv wp-content/themes/$SITE/functions.php wp-content/themes/$SITE/functions.php_
sed 's/wp-starter/'$SITE'/' wp-content/themes/$SITE/functions.php_ > wp-content/themes/$SITE/functions.php
rm  wp-content/themes/$SITE/functions.php_

mv wp-content/themes/$SITE/style.css wp-content/themes/$SITE/style.css_
sed 's/wp-starter/'$SITE'/' wp-content/themes/$SITE/style.css_ > wp-content/themes/$SITE/style.css
rm  wp-content/themes/$SITE/style.css_

mv wp-content/themes/$SITE/style.scss wp-content/themes/$SITE/style.scss_
sed 's/wp-starter/'$SITE'/' wp-content/themes/$SITE/style.scss_ > wp-content/themes/$SITE/style.scss
rm  wp-content/themes/$SITE/style.scss_


# copy over some plugins
cp -R $WPMAKE_PATH/wpmake-plugins/* wp-content/plugins/
# copy over .htaccess + .gitignore
cp $WPMAKE_PATH/wpmake.htaccess .htaccess
cp $WPMAKE_PATH/wpmake.gitignore .gitignore

mkdir wp-content/uploads
chmod 777 wp-content/uploads

echo "DONE! now create your server and hit http://$SITE"