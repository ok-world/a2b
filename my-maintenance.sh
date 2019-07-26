#!/bin/bash

echo ""
echo "Maintenance A2Billing DataBase"
echo "------------------------------"
echo ""

echo "Database Name : ${DB_NAME}"
echo "Hostname : ${HOST}"
echo "UserName : ${DB_USER}"
echo "Password : ${DB_PASS}"

NOW=$(date +"%m-%d-%Y")

echo "Dump a2billing.$NOW.dmp in process..."
mysqldump --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --create-options --routines --triggers ${DB_NAME} > a2billing.$NOW.dmp

echo "Tar.gz a2billing.$NOW.dmp in process..."
tar -pczf a2billing.$NOW.tar.gz a2billing.$NOW.dmp
rm a2billing.$NOW.dmp

echo "Database backup available at a2billing.$NOW.tar.gz"

echo "mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --check --databases ${DB_NAME}"
mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --check --databases ${DB_NAME}


echo "mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --optimize --databases ${DB_NAME}"
mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --optimize --databases ${DB_NAME}


echo "mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --analyze --databases ${DB_NAME}"
mysqlcheck --user=${DB_USER} --password=${DB_PASS} --host=${HOST} --analyze --databases ${DB_NAME}
