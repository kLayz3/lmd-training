#!/bin/bash
script_path="$(dirname -- "$(readlink -f -- $0)")"
. ${script_path}/src/colours.sh
. ${script_path}/src/common.bash

test_dir=${script_path}/exercises
curr_prog=

# Source any current process from .progress
curr_prog=$(head -n 1 ${script_path}/src/.progress 2>/dev/null)

# If reset flag given: reset all progress
if [[ $@ =~ (^|[:space:])--reset($|[:space:]) ]]; then
	echo "Resetting all progress." 
	ask_to_proceed; curr_prog=; 
	$(> "${script_path}/src/.progress")
	echo -e "${L_ORANGE}Resetting your progress...${COLOR_OFF}"
	exit 1
fi

# Check for help flag
if [[ $@ =~ -h ]]; then 
    echo -e "This program will guide you through the training about GSI LMD format ... "
	echo -e "${I_GREEN}The script will give you various tasks, and you will need to answer them."
	echo -e "${L_ORANGE}If you exit this program, don't worry! Your progress is saved, and you will continue from the point where you left.${COLOR_OFF}"
    exit 1
fi

# Tests 0_x
if [[ "x"$curr_prog == "x" ]]; then
	echo -e "${I_GREEN}  Welcome to the LMD tutorial!"'\n'
	echo -e "This program will guide you through the training about GSI LMD format ... "
	sleep 1;
	spin_me 1

	echo -e "${I_GREEN}This script will give you various tasks, and you will need to answer them."
	spin_me 1

	echo -e "${L_ORANGE}If you exit this program, don't worry! Your progress is saved, and you will continue from the point where you left."

	echo -e "${I_GREEN}First let's test if it works: "
	echo -e "${I_CYAN}Write a number between 0-9: ${COLOR_OFF}"'\n'
	. $test_dir/0_intro/intro_0.bash
	curr_prog=1_0;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi

# Test 1_x
if [[ "x"$curr_prog == "x1_0" ]]; then 
	ask_to_proceed
	sleep 1
	echo -e "${I_GREEN}This segment will practise word slicing."
	echo -e "A word (32 bit) will always have data payload in certain bits, and then tags and metadata in others."
	echo -e "A slice is specified with low_bit and high_bit ${BI_GREEN}lo${I_GREEN} && ${BI_GREEN}hi${I_GREEN}"
	echo -e "For the next exercises feel free to use whatever programming tool you like $smiley"
	echo -e '\n'"${I_CYAN}Find the value of first 10 bits (slice [9:0]) of the following word ${BI_CYAN}0xdeadbeef${COLOR_OFF}"
	. $test_dir/1_slicing/slicing_0.bash
	curr_prog=1_1;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi
if [[ "x"$curr_prog == "x1_1" ]]; then 
	echo -e '\n'"${I_CYAN}Find the value of the slice [13:6] of the following word ${BI_CYAN}0xbadbaaad${COLOR_OFF}"
	. $test_dir/1_slicing/slicing_1.bash
	curr_prog=2_0;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi

# Test 2_x
if [[ "x"$curr_prog == "x2_0" ]]; then
	ask_to_proceed
	sleep 1
	echo -e "${I_GREEN}This next segment will have a quick explaination of the two's complement."
	echo -e "Sometimes the module data will come out in a two's complement fashion. "
	echo -e "A negative number (say a 16-bit integer) can easily be identified if the highest bit (15th) is a 1"
	echo -e "Then the absolute value of the number is calculated by flipping all the bits 0 <-> 1 and adding incrementing by 1."
	echo -e "So for example: the biggest positive 8-bit signed integer 0b 11111111 = 127"
	echo -e "The smallest negative 8-bit signed integer 0b 10000000 = -(1<<8) = -158"
	echo -e "Always remember exponentiating two is easy .. 2^n == (1 << n) $smiley"

	echo -e '\n'"${I_CYAN}The slice ${BI_CYAN}[27:14]${I_CYAN} of the following word ${BI_CYAN}0x4a678001${I_CYAN} represents a signed TDC value of the signal"
	echo -e "relative to the trigger signal in units of 1 ns. Enter this value (hint: can be negative)${COLOR_OFF}"

	. $test_dir/2_complement/complement_0.bash
	curr_prog=3_0;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi

# Test 3_x
if [[ "x"$curr_prog == "x3_0" ]]; then
	ask_to_proceed
	sleep 1
	echo -e "${I_GREEN}Let's have a quick look at the most common block found in GSI LMD."
	echo -e '\n'"${BI_GREEN}The White Rabbit timestamp${I_GREEN}."'\n'
	echo -e "The whiterabbit data must always come at the top of a subevent."
	echo -e "Its 1. word encodes a WR ID in bits [11:0] followed by only 0's [31:12]"
	echo -e "Its 2. word encodes lowest  16 bits of the timestamp: [15:0]"
	echo -e "Its 3. word encodes low-hi  16 bits of the timestamp: [16:31]"
	echo -e "Its 4. word encodes hi-low  16 bits of the timestamp: [32:47]"
	echo -e "Its 5. word encodes highest 16 bits of the timestamp: [48:63]"

	echo -e '\n'"${I_CYAN}Print the fist event in the ${BI_CYAN}example.lmd${I_CYAN} file. Which month and year was the data taken?"
	echo -e "Write in abbreviation, comma separated e.g. Nov,2023\`"
	echo -e "Hint: shell command \`date -d @timestamp\` will give the date of a second-based \`timestamp\`.${COLOR_OFF}"

	. $test_dir/3_modules/modules_0.bash
	curr_prog=3_1;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi
if [[ "x"$curr_prog == "x3_1" ]]; then
	ask_to_proceed
	sleep 1
	echo -e "${I_GREEN}In the same file, in the subevent with ${BI_GREEN}ProcID 20${I_GREEN}, try to idenfity the data from the V1190 TDC module."
	echo -e "V1190 TDC is a 128 channel TDC readout by 4 individual TDC chips (32 input channels per chip)."
	echo -e "Can you see which words correspond to global header, data header+measurements+trailer, global trailer?"
	echo -e "One of the data header or data trailer words are disabled in the readout. Which one?"'\n'
	echo -e "${I_CYAN}Print the first event, look into ${BI_CYAN}ProcID 20${I_CYAN} subevent. How many hits did each of the four TDC record?"
	echo -e "Write four numbers in a comma separated list e.g. 5,6,7,8${COLOR_OFF}"
	. $test_dir/3_modules/modules_1.bash

	curr_prog=4_0;
	$(echo $curr_prog > ${script_path}/src/.progress 2>/dev/null) 
fi

if [[ "x"$curr_prog == "x4_0" ]]; then
	echo -e '\n'"${BI_GREEN}You've sucessfully completed this small tutorial. ${I_GREEN}$smiley"
	echo -e "You can always reset your progress by calling ${L_ORANGE}./run.bash --reset${COLOR_OFF}"
	echo
fi
