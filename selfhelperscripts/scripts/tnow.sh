#!/bin/bash

function get_work_hours() {
	local city="$1"
	local timezone="$2"
	local moscow_start_hour=9
	local moscow_end_hour=18

	local moscow_time=$(TZ="Europe/Moscow" date +"%H" | sed 's/^0*//')
	local moscow_minute=$(TZ="Europe/Moscow" date +"%M" | sed 's/^0*//')
	local current_time=$(TZ="$timezone" date +"%H:%M")
	local utc_offset_raw=$(TZ="$timezone" date +"%z")
	local utc_offset="${utc_offset_raw:0:3}:${utc_offset_raw:3}"

	worked_hours=0
	worked_minutes=0
	remaining_hours=0
	remaining_minutes=0

	if ((moscow_time < moscow_start_hour)); then
		worked_hours=0
		worked_minutes=0
		remaining_hours=$((moscow_end_hour - moscow_start_hour))
		remaining_minutes=0
	elif ((moscow_time >= moscow_end_hour)); then
		worked_hours=$((moscow_end_hour - moscow_start_hour))
		worked_minutes=0
		remaining_hours=0
		remaining_minutes=0
	else
		worked_hours=$((moscow_time - moscow_start_hour))
		worked_minutes=$moscow_minute
		remaining_hours=$((moscow_end_hour - moscow_time - 1))
		remaining_minutes=$((60 - moscow_minute))
		if ((remaining_minutes == 60)); then
			remaining_minutes=0
			remaining_hours=$((remaining_hours + 1))
		fi
	fi

	printf "%-15s | %-15s | %-20s | %2d:%02d          | %2d:%02d\n" "$city" "$timezone" "$current_time ($utc_offset)" "$worked_hours" "$worked_minutes" "$remaining_hours" "$remaining_minutes"
}

function print_table() {
	echo "City            | Timezone       | Time Now               | Worked Hours   | Remaining Hours"
	echo "------------------------------------------------------------------------------------------"
	for city in \
		"Tbilisi Asia/Tbilisi" \
		"Moscow Europe/Moscow" \
		"Almaty Asia/Almaty"; do

		city_name=$(echo $city | cut -d ' ' -f 1)
		time_zone=$(echo $city | cut -d ' ' -f 2)

		get_work_hours "$city_name" "$time_zone"
	done
}

print_table
