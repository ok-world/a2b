#!/bin/bash

SCRIPT_DIR=$(dirname $0)

export SRC_DIR=/usr/local/src/a2billing
export DB_NAME=cia2b
export DB_USER=ci_a2b
export DB_PASS=$(./passgen.py)
export SQL_PATH=/DataBase/mysql-5.x
export HOST=localhost


SED=/bin/sed
MYSQL=/usr/bin/mysql

${SED} "s,mya2billing,${DB_NAME},g" ${SRC_DIR}${SQL_PATH}/*.sql -i.back
rm -f ${SRC_DIR}${SQL_PATH}/*.back
${SED} "s,a2billinguser,${DB_USER},g" ${SRC_DIR}${SQL_PATH}/*.sql -i.user
rm -f ${SRC_DIR}${SQL_PATH}/*.user
${SED} "s,a2billing,${DB_PASS},g" ${SRC_DIR}${SQL_PATH}/*.sql -i.pass
rm -f ${SRC_DIR}${SQL_PATH}/*.pass

${MYSQL} -u root < ${SRC_DIR}${SQL_PATH}/a2billing-createdb-user.sql

cp ${SCRIPT_DIR}/install-db.sh ${SRC_DIR}${SQL_PATH}/
( cd ${SRC_DIR}${SQL_PATH} ./install-db.sh )

${SED} "s,a2billing_dbuser,${DB_USER},g" < ${SCRIPT_DIR}/a2billing.conf | ${SED} "s,a2billing_dbpassword,${DB_PASS},g" | ${SED} "s,a2billing_dbname,${DB_NAME},g" > ${SRC_DIR}/a2billing.conf

ln -s ${SRC_DIR}/a2billing.conf /etc/a2billing.conf

chmod 777 /etc/asterisk
touch /etc/asterisk/additional_a2billing_iax.conf
touch /etc/asterisk/additional_a2billing_sip.conf
echo \#include additional_a2billing_sip.conf >> /etc/asterisk/sip.conf
echo \#include additional_a2billing_iax.conf >> /etc/asterisk/iax.conf

( cd ${SRC_DIR}/addons/sounds/; ./install_a2b_sounds.sh )
chown -R asterisk:asterisk /usr/share/asterisk/sounds/

echo "[${DB_USER}]" > /etc/asterisk/manager.d/${DB_USER}.conf
echo "secret=${DB_PASS}" >> /etc/asterisk/manager.d/${DB_USER}.conf
echo "read=system,call,log,verbose,command,agent,user" >> /etc/asterisk/manager.d/${DB_USER}.conf
echo "write=system,call,log,verbose,command,agent,user" >> /etc/asterisk/manager.d/${DB_USER}.conf

cp ${SCRIPT_DIR}/extensions.conf /etc/asterisk/

ln -s /usr/local/src/a2billing/AGI/a2billing.php /usr/share/asterisk/agi-bin/a2billing.php
ln -s /usr/local/src/a2billing/AGI/a2billing_monitoring.php /usr/share/asterisk/agi-bin/a2billing_monitoring.php
ln -s /usr/local/src/a2billing/AGI/lib /usr/share/asterisk/agi-bin/lib

chmod +x /usr/share/asterisk/agi-bin/a2billing.php
chmod +x /usr/share/asterisk/agi-bin/a2billing_monitoring.php

mkdir /var/www/a2billing
chown www-data:www-data /var/www/a2billing

mkdir -p /var/lib/a2billing/script
mkdir -p /var/run/a2billing

ln -s /usr/local/src/a2billing/admin /var/www/a2billing/admin
ln -s /usr/local/src/a2billing/agent /var/www/a2billing/agent
ln -s /usr/local/src/a2billing/customer /var/www/a2billing/customer
ln -s /usr/local/src/a2billing/common /var/www/a2billing/common

chmod 755 /usr/local/src/a2billing/admin/templates_c
chmod 755 /usr/local/src/a2billing/customer/templates_c
chmod 755 /usr/local/src/a2billing/agent/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/admin/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/customer/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/agent/templates_c


chown -Rf asterisk:asterisk /etc/asterisk
chown -Rf asterisk:asterisk /usr/share/asterisk
chown -Rf asterisk:asterisk /var/lib/asterisk
chown -Rf asterisk:asterisk /var/log/asterisk
chown -Rf asterisk:asterisk /var/lib/a2billing
chown -Rf asterisk:asterisk /var/run/a2billing

chown -Rf www-data /etc/asterisk/additional_a2billing_iax.conf
chown -Rf www-data /etc/asterisk/additional_a2billing_sip.conf

crontab -u asterisk ${SCRIPT_DIR}/cron.file
