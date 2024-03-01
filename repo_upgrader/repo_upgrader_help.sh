#!/usr/bin/sh

# TODO: Support for the following Databases
#       - HANA
#       - Microsoft_SQL_Server
#	- Oracle
#	- MySQL
#	- DB2
#	- Sybase
#	- SQL_Anywhere

# TODO: Support SSL/TLS for each database Repo type

# TODO: Support the following authentication methods for Microsoft SQL Server
#	- SQLServer
#	- Windows
#	- Azure_AD_Password


choices=("V" "U" "u" "v" "C" "c")

printf "Do you want to [C]reate/([U]pgrade/[V]ersion)\n"
read choice_input

if [[ ! " ${choices[@]} " =~ " ${choice_input} " ]];then
	printf "\nUnknown Choice\n"
else

	printf "Specify one database type:\n1) SAP HANA\n2) Microsoft SQL Server\n3) Oracle\n4) Sybase\n5) SQL Anywhere\n6)IBM DB2\n"

	read database_type

	echo "Provide the Database Server Name:"
	read database_server_name

	echo "Database port: "
	read database_port

	echo "Database Username"
	read database_username

	read -s -p "Database Password: " database_password

	printf "\n"

	read -p "Enter comma separated repository names: " repo_input

	IFS=','

	read -ra database_repo <<< "${repo_input}"

	printf "\nDatabase repository type [local,central]\n"
	read database_repo_type

	for repo in "${database_repo[@]}";do
		printf "\n${repo}\n"
		if [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "U" ]]; then
			SAPHANAUPGRADE
		elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "V" ]];then
			SAPHANAVERSIONCHECK
		elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "C" ]];then
			SAPHANAREPOCREATION
		else
			printf "\nUnknown choice\n"
		fi
	done
fi

# TODO: Commands for SAP HANA upgrade
function SAPHANAUPGRADE{
	$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -u -d
	printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -u -d\n"
}

# TODO: Commands for SAP HANA repository creation
function SAPHANAREPOCREATION{
	$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -c -d -o
    printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -c -d -o \n"
}

# TODO: Commands for SAP HANA repository version check
function SAPHANAVERSIONCHECK{
	$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -v
	printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -v \n"
}