#!/bin/bash

matched=""
not_matched=""
input_file="example_input.txt" # TEST
regex_file="regex_list.txt" # TEST

function check_regex () {
    current_regex="$1"
    while read line
    do
        aux=$(echo "$line" | grep -Po ".*index")
        if [ -z "$aux" ]
        then
            echo "$line" >> $not_matched
        else
            echo "$line" >> $matched
        fi
        aux=""
    done < "$input_file"
}

start_time=$(date)
count="1"
while read reg
do
    matched="output/reg_""$count""_matched.txt"
    not_matched="output/reg_""$count""_not_matched.txt"
    start_time_regex=$(date)
    check_regex "$reg"
    end_time_regex=$(date)
    process_time=$(($(date -d "$end_time_regex" '+%s')-$(date -d "$start_time_regex" '+%s')))
    echo -e "Checked reg $count:"
    echo "  $reg"
    echo -e "  Start: $start_time_regex\n  End: $end_time_regex"
    echo -e "  Process time: $process_time seconds ($(($process_time/60)) minutes)\n"
    count=$(($count+1))
done < "$regex_file"
end_time=$(date)
process_time=$(($(date -d "$end_time" '+%s')-$(date -d "$start_time" '+%s')))

echo -e "* Script start time: $start_time\n* End time: $end_time\n"
echo -e "  Process time: $process_time seconds ($(($process_time/60)) minutes)\n"