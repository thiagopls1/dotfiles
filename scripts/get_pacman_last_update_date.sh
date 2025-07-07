LOG_FILE="/var/log/pacman.log"

if [ ! -f $LOG_FILE ]; then
	echo "pacman not found"
  exit 1
fi

DATE_REGEX='[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}\:[0-9]\{2\}\:[0-9]\{2\}\(\+\|-\)[0-9]\{4\}'
LAST_DATE=$(grep -E "(pacman -Syu|full system upgrade)" $LOG_FILE | tail -n 1 | sed -n "s/.*\($DATE_REGEX\).*/\1/p")

if [ -z "$LAST_DATE" ]; then
  echo "No updates found"
else
	echo $(date -d $LAST_DATE '+%a %b %d %H:%m:%S')
fi
