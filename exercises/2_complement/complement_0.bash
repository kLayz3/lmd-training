while [[ 1 ]]; do
	read_input
	if [[ ! $answer =~ $re_dec ]]; then
		wrong_format	
	elif (( $answer == -3487 )); then
		success
		break
	else
		wrong_answer
	fi
done
