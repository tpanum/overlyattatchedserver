# CAPITALIZE USERNAME

name=${(C)$(whoami)[1]}${$(whoami)[2,-1]}

# CALCULATE TIME SINCE LAST LOGIN

sdate=$(more ~/.lastlogin)
prevdate=$(date -d $sdate "+%s")
curdate=$(date "+%s")
diff=$(($curdate-$prevdate))

years=0
days=0
hours=0
mins=0

time=""

if [ $diff -gt 31536000 ]; then
        years=$(($diff/31536000))
        diff=$(($diff-($years*31536000)))

    time="$time$years"

    if [ $years -gt 1 ]; then
    time="$time years "
    else
    time="$time year "
    fi
fi

if [ $diff -gt 86400 ]; then
        days=$(($diff/86400))
        diff=$(($diff-($days*86400)))

    time="$time$days"

    if [ $days -gt 1 ]; then
    time="$time days "
    else
    time="$time day "
    fi
fi

if [ $diff -gt 3600 ]; then
        hours=$(($diff/3600))
        diff=$(($diff-($hours*3600)))

    time="$time$hours"

    if [ $hours -gt 1 ]; then
    time="$time hours "
    else
    time="$time hour "
    fi
fi

if [ $diff -gt 60 ]; then
        mins=$(($diff/60))
        diff=$(($diff-($mins*60)))

    time="$time$mins"

    if [ $mins -gt 1 ]; then
    time="$time mins "
    else
    time="$time min "
    fi
fi

if [ ${#time} -eq 0 ]; then
   time="$diff secs "
fi


time="${time%?}"

unset years
unset days
unset hours
unset mins

numberOfGreets=$(nl /PATH/TO/greetings | tail -n 1 | awk '{print $1}')
greetTargetLine=$(($((($RANDOM*$numberOfGreets) / 32767))+1))
targetGreet=$(awk 'NR=='$greetTargetLine /PATH/TO/greetings)

echo " *  $targetGreet\n" | sed -e "s/%NAME/$name/" | sed -e "s/%TIME/$time/"