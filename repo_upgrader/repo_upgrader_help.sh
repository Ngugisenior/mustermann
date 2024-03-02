#!/usr/bin/sh

# This script assumes the following
#	1. All the repositories are of the same database type
#	2. They belong to the same Database Server
#	3. They all use the same Database username
#	4. They all use the same Database password


# TODO: Support for the following Databases
#       - HANA
#       - Microsoft_SQL_Server
#		- Oracle
#		- MySQL
#		- DB2
#		- Sybase
#		- SQL_Anywhere

# TODO: Support SSL/TLS for each database Repo type

# TODO: Support the following authentication methods for Microsoft SQL Server
#		- SQLServer
#		- Windows
#		- Azure_AD_Password


choices=("V" "U" "u" "v" "C" "c")


# returns the database type based on the index 
function repo_database_type(){
	DATABASE_TYPES=("HANA" "Microsoft_SQL_Server" "Oracle" "Sybase" "SQL_Anywhere" "DB2" "MySQL")
	echo "${DATABASE_TYPES[$1]}"
}

# Checks the repositories versions
# Upgrades the repository
# TODO: Version check test for the following databases
	# Oracle
	# Sybase
	# SQL Anywhere
	# IBM DB2
	# MySQL
function repo_version_check(){
	$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -v
	printf "\n$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -v \n"
}

# Upgrades the repository
# TODO: Upgrade test for the following databases
	# Oracle
	# Sybase
	# SQL Anywhere
	# IBM DB2
	# MySQL
function repo_upgrade(){
	$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -u -d
	printf "\n$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -u -d\n"
}

# Creates repositories
# TODO: Repo creation test for the following databases
	# Oracle
	# Sybase
	# SQL Anywhere
	# IBM DB2
	# MySQL
function repo_rreation(){
	$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -c -d -o
    printf "\n$LINK_DIR/bin/repoman -U"${1}" -P"${2}" -N"${3}" -S${4} -p"${5}" -Q"${6}" -t"${7}" -s -c -d -o \n"
}




function repo_manager(){
	printf "Do you want to [C]reate/([U]pgrade/[V]ersion)\n"
	read choice_input

	if [[ ! " ${choices[@]} " =~ " ${choice_input} " ]];then
		printf "\nUnknown Choice\n"
	else

		printf "Specify one database type:\n1) SAP HANA\n2) Microsoft SQL Server\n3) Oracle\n4) Sybase\n5) SQL Anywhere\n6)IBM DB2\n7) MySQL\n"

		read database_index

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
				case $database_index in
					"1"|"2")
						repo_upgrade "${database_username}" "${database_password}" $(repo_database_type $((database_index - 1))) ${database_server_name} "${database_port}" "${repo}" "${database_repo_type}"
					;;

					"3")
						Oracle_Upgrade
					;;
					"4")
						Sybase_Upgrade
					;;
					"5")
						SQL_Anywhere_Upgrade
					;;
					"6")
						IBM_DB2_Upgrade
					;;
					"7")
						MySQL_Upgrade
					;;
					*)
						printf "\nUnknown Choice\n"
					;;
				esac
			elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "V" ]];then
				case $database_index in
					"1"|"2")
						repo_version_check "${database_username}" "${database_password}" $(repo_database_type $((database_index - 1))) ${database_server_name} "${database_port}" "${repo}" "${database_repo_type}"
					;;

					"3")
						Oracle_Version_Check
					;;
					"4")
						Sybase_Version_Check
					;;
					"5")
						SQL_Anywhere_Version_Check
					;;
					"6")
						IBM_DB2_Version_Check
					;;
					"7")
						MySQL_Version_Check
					;;
					*)
						printf "\nUnknown Choice\n"
					;;
				esac
			elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "C" ]];then
				case $database_index in
					"1"|"2")
						repo_creation "${database_username}" "${database_password}" $(repo_database_type $((database_index - 1))) ${database_server_name} "${database_port}" "${repo}" "${database_repo_type}"
					;;

					"3")
						Oracle_Repo_Creation
					;;
					"4")
						Sybase_Repo_Creation
					;;
					"5")
						SQL_Anywhere_Repo_Creation
					;;
					"6")
						IBM_DB2_Repo_Creation
					;;
					"7")
						MySQL_Repo_Creation
					;;
					*)
						printf "\nUnknown Choice\n"
					;;
				esac
			else
				printf "\nUnknown choice\n"
			fi
		done
	fi
}

repo_manager