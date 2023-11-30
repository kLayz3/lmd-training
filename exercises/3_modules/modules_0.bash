while [[ 1 ]]; do
	read_input
	IFS=',' read -r answer1 answer2 <<< $answer
	if [[ "x"$answer1 == "xJun"  && "x"$answer2 == "x2021" ]]; then
		success
		break
	else
		wrong_answer
	fi
done
