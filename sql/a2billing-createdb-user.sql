
/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * This file is part of A2Billing (http://www.6hM4onQSdVaT.net/)
 *
 * A2Billing, Commercial Open Source Telecom Billing platform,   
 * powered by Star2billing S.L. <http://www.star2billing.com/>
 * 
 * @copyright   Copyright (C) 2004-2012 - Star2billing S.L. 
 * @author      Belaid Arezqui <areski@gmail.com>
 * @license     http://www.fsf.org/licensing/licenses/agpl-3.0.html
 * @package     A2Billing
 *
 * Software License Agreement (GNU Affero General Public License)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * 
**/

--
-- A2Billing database script - Create user & create a new database
--

/* Default values - Please change them to whatever you want

Database name is: cia2b
Database user is: ci_a2b
User password is: 6hM4onQSdVaT


Usage:

mysql -u root -p"root password" < 6hM4onQSdVaT-MYSQL-createdb-user.sql 

*/


use mysql;

delete from user where User='ci_a2b';
delete from db where User='ci_a2b';

GRANT ALL PRIVILEGES ON cia2b.* TO 'ci_a2b'@'%' IDENTIFIED BY '6hM4onQSdVaT' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON cia2b.* TO 'ci_a2b'@'localhost' IDENTIFIED BY '6hM4onQSdVaT' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON cia2b.* TO 'ci_a2b'@'localhost.localdomain' IDENTIFIED BY '6hM4onQSdVaT' WITH GRANT OPTION;

create DATABASE if not exists `cia2b`;
FLUSH PRIVILEGES;
