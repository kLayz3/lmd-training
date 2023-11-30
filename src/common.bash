# This guy won't kill script if `no` given
ask_to_continue () {
	do_it=
	echo
	read -p "Do you wish to continue? [yY]=yes, anything else=no : " -n 1 yy
	if [[ $yy =~ ^[yY]$ ]]; then
		do_it=1
		echo
	else
		echo -e "Not continuing ..."'\n'
		sleep 1
	fi
}

# This call will exit if `no` given
ask_to_proceed () {
	do_it=
	read -p "Do you wish to proceed? [yY]=yes, anything else=no : " -n 1 yy
	echo
	if [[ $yy =~ ^[yY]$ ]]; then
		do_it=1
	else
		echo -e "Won't proceed, I promise. Exiting ..."'\n'
		echo -e "See you later."'\n'
		exit 0
	fi
}
read_input () {
	read -p "Your input : " answer
	echo -e "Received input: ${BI_GREEN}$answer${COLOR_OFF}"
}

success () {
	echo -e "${BI_GREEN}Correct answer.${COLOR_OFF}"
}
wrong_answer () {
	echo -e "${D_ORANGE}Wrong answer. Try again${COLOR_OFF}"'\n'
}
wrong_format () {
	echo -e "${D_ORANGE}Wrong format. Try again${COLOR_OFF}"'\n'
}

spin_me() {
	local -a m=( '/' '-' '\' '|' )
	rep=$1
	[ -z $1 ] && { $rep=2; }
	_i=0
	while [[ $((_i++)) < $((rep * ${#m[@]})) ]]; do
		printf '%s\r' "${m[i++ % ${#m[@]}]}"
		sleep 0.5
	done
	echo -e "\U00002713"'\r'
}

spin_forever() {
	local -a m=( '/' '-' '\' '|' )
	while [[ 1 ]]; do
		printf '%s\r' "${m[i++ % ${#m[@]}]}"
		sleep 0.5
	done
}

# Who loves regex?
re_dec="^(\-)?[0-9]+$"
re_hex="^(0x)?[0-9abcdef]+$)"
re_bin="^[01 \t]+$"

# Any smilies in the chat?
smiley='\U0001F603'
