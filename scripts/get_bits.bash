#!/bin/bash

usage() {
	echo "Optional arguments in []"
	echo -e "Usage:"'\n'
	echo -e "./"$(basename $BASH_SOURCE)" [--hex] word_1 word_2 ... word_n lo hi [-x]"'\n'
	echo "Will print the slice from (and including) bits from \`lo\` to \`hi\` [hi:lo] of a number \`word\`."
	echo "Assuming word is given in decimal. Add --hex as first flag to indicate that all the following words are hex (\`lo\` and \`hi\` are still in decimal though)"
	echo "Otherwise add 0x in front of the word, to imply hex."
	echo 'Add -x as final argument, to output the slice value in hex.'
	echo
	echo "Example:"
	echo -e "$(basename $BASH_SOURCE)"" --hex 1d1d1d1d 2d2d2d2d deadbeef 5 10 -x"'\n'
	exit 1
}

[ $# -lt 3 ] && { usage; }

if [[ x"${@: -1}" =~ -help ]]; then
	usage;
fi
if [[ x"$1" == "x--hex" ]]; then
	assume_hex="1"
	shift
fi

if [[ x"${@: -1}" == 'x-x' ]]; then
	print_hex='y'
	lo=${@: -3:1}
	hi=${@: -2:1}
	set -- "${@:1:$#-2}"
else 
	lo=${@: -2:1}
	hi=${@: -1:1}
	set -- "${@:1:$#-1}"
fi

while [ $# -gt 1 ]; do
	word=$1
	hexword=
	if [[ $word =~ '0x' ]]; then
		hexword=$word;
		word="${word:2}"
		word="$((16#$word))"
	elif [[ "x"$assume_hex == "x1" ]]; then
		hexword="0x"$word
		word="$((16#$word))"
	fi
	if [[ x"$print_hex" == "x" ]]; then
		if [[ x"$hexword" == "x" ]]; then
			python3 -c "mask=(1<<($hi-$lo+1))-1; print(\"{:>10} => {}\".format($word, ($word >> $lo) & mask))" 
		else
			python3 -c "mask=(1<<($hi-$lo+1))-1; print(\"0x{:08x} => {}\".format($word, ($word >> $lo) & mask))" 
		fi
	else
		if [[ x"$hexword" == "x" ]]; then
			python3 -c "mask=(1<<($hi-$lo+1))-1; print(\"{:>10} => 0x{:x}\".format($word, ($word >> $lo) & mask))" 
		else
			python3 -c "mask=(1<<($hi-$lo+1))-1; print(\"0x{:08x} => 0x{:x}\".format($word, ($word >> $lo) & mask))" 
		fi
	fi

	shift
done


# Martin Bajzek [m.bajzek@gsi.de] 05.11.2023
