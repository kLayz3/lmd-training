while [[ 1 ]]; do
	read_input
	IFS=',' read -r a1 a2 a3 a4 <<< $answer
	if [[ "x"$a1 == "x1"  && "x"$a2 == "x1" && "x"$a3 == "x17" && "x"$a4 == "x4" ]]; then
		success
		break
	else
		wrong_answer
	fi

done
