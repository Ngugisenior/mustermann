#!/usr/bin/sh
choices=("V" "U" "u" "v" "C" "c")

printf "Do you want to [C]reate/([U]pgrade/[V]ersion)\n"
read choice_input

if [[ ! " ${choices[@]} " =~ " ${choice_input} " ]];then
	printf "\nUnknown Choice\n"
else

	echo "Provide Database Type [HANA, Microsoft_SQL_Server]"

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
        		$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -u -d
			printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -u -d\n"
		elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "V" ]];then
			$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -v
			printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -v \n"
		elif [[ $(echo "${choice_input}" | tr '[:lower:]' '[:upper:]' ) == "C" ]];then
			$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -c -d -o
                        printf "\n$LINK_DIR/bin/repoman -U"${database_username}" -P"${database_password}" -N"${database_type}" -S${database_server_name} -p"${database_port}" -Q"${repo}" -t"${database_repo_type}" -s -c -d -o \n"
		else
			printf "\nUnknown choice\n"
		fi
	done
fi
