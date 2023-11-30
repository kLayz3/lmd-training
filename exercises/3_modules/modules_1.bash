while [[ 1 ]]; do
	read_input
	IFS=',' read -r a1 a2 a3 a4 <<< $answer
	if [[ "x"$a1 == "x0"  && "x"$a2 == "x0" && "x"$a3 == "x16" && "x"$a4 == "x3" ]]; then
		success
		break
	else
		wrong_answer
	fi

done
