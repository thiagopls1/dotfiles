LOG_FILE_PACMAN="/var/log/pacman.log"
LOG_FILE_APT="/var/log/apt/history.log"

if [ -f $LOG_FILE_PACMAN ]; then
	DATE_REGEX='[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}\:[0-9]\{2\}\:[0-9]\{2\}\(\+\|-\)[0-9]\{4\}'
	LAST_DATE=$(grep -E "(pacman -Syu|full system upgrade)" $LOG_FILE_PACMAN | tail -n 1 | sed -n "s/.*\($DATE_REGEX\).*/\1/p")

	if [ -z "$LAST_DATE" ]; then
		echo "No updates found"
	else
		echo $(date -d $LAST_DATE '+%a %b %d %H:%M:%S')
	fi
elif [ -f $LOG_FILE_APT ]; then
	LOG_REGEX='Start-Date:\s[0-9]{4}-[0-9]{2}-[0-9]{2}\s{2}[0-9]{2}:[0-9]{2}:[0-9]{2}\nCommandline:\sapt\supgrade'
	DATE_REGEX='[0-9]{4}-[0-9]{2}-[0-9]{2}\s{2}[0-9]{2}:[0-9]{2}:[0-9]{2}'
	LAST_DATE=$(grep -Pzo $LOG_REGEX $LOG_FILE_APT | tail -n 2 | grep -Pzo $DATE_REGEX)
	echo $LAST_DATE
	exit 0
else
	echo "Not found any supported pkg manager"
	exit 0
fi

