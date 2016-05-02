for x in *; do echo $x $(head -c 8 $x | od -t x1 --width=18); done > types.txt

cat types.txt | cut -d ' ' -f 3,4 | sort | uniq -c  | sort -n

mkdir jpeg png mov sqlite

for x in $(grep "000000 ff d8 ff e" types.txt  | cut -d ' ' -f 1); do mv $x jpeg/${x}.jpeg; done
for x in $(grep "000000 89 50 4e 47 0d 0a 1a 0a" types.txt  | cut -d ' ' -f 1); do mv $x png/${x}.png; done
for x in $(grep "000000 .. .. .. .. 66 74 79 70" types.txt  | cut -d ' ' -f 1); do mv $x mov/${x}.mov; done
for x in $(grep -c "SQLite format 3" ???????????????????????????????????????? | grep -v ":0" | cut -d ":" -f 1); do mv ${x} sqlite/${x}.sqlite; done

for y in sqlite/*.sqlite; do
    for x in $(sqlite3 ${y} '.tables' ); do echo $y $x; done
done > tables.txt

file=$(grep "chat_handle_join" tables.txt  | cut -d ' ' -f 1)
echo "sms file is: ${file}"
cat sms_code.sql | sqlite3 "${file}" > sms.csv

file=$(grep "ZCALLRECORD" tables.txt  | cut -d ' ' -f 1)
for x in ${file}; doq
    echo "calls file is: ${x}" 1>&2
    cat calls_code.sql | sqlite3 "${x}"
done > calls.csv
