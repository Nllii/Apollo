#!bin/bash



fibbernacci () {
    a=0
    b=1
    sum=0

    while read j; do
        sum=$((a+b))
        a=$b
        b=$sum
    done < <(seq 0 "${1}")
    echo $b
}



fibbernacci 100


# important_install(){
# 	perform_task "installing the important stuff first"
# 	# use for loop to read all values and indexes
# 	for (( i=0; i<${important_}; i++ ));
# 	do
# 		# check to see if its important with the .important file
# 		if [[ -f "$project_dir/services/${important[$i]}/.is_important" ]]; then
# 			if [[ -f "$project_dir/services/${important[$i]}/.enable" ]]; then
# 				perform_task "${important[$i]} already enabled."
# 			else
# 				perform_task "enabling ${important[$i]}"
# 				execute "$project_dir/services/${important[$i]}/enable.sh"
# 			fi
# 		else
# 			perform_task "skipping ${important[$i]}"
# 		fi
# 	done
# }
