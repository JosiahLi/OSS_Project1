#! /bin/bash

Exit="N"
# Show all the options
echo "User Name: LI LIANGJI"
echo "Student Number: 12214588"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"

until [ "${Exit}" = "Y" ]; do
    # get the input from the user.
    read -p "Enter your choice [ 1-9 ] " option
    echo ""
    case ${option} in
    1)
        read -p "Please enter 'movie id' (1~1682): " id
        echo ""
        awk -v ID=${id} -F'|' '$1==ID {print$0}' $1
        echo ""
        ;;
    2)
        read -p "Do you want to get the data of 'action' genre moveis from 'u.item'? (y/n): " choice
        echo ""
        if [ "${choice}" = "y" ]; then
            awk -F'|' '$7==1 {print $1,$2}' $1 | head -n 10
        fi
        echo ""
        ;;
    3)
        read -p "Please enter the 'movie id' (1~1682): " id
        echo ""
        awk -v ID=${id} '$2==1 {sum+=$3; n+=1} END {printf("average rating of %d: %.5f\n", ID, sum / n)}' $2
        echo ""
        ;;
    4)
        read -p "Do you want to delete the 'IMDbURL' from 'u.item'? (y/n) " choice
        echo ""
        if [ "${choice}" = "y" ]; then
            cat $1 | sed -E 's/http:[^\|]*//g' | head -n 10
        fi
        echo ""
        ;;
    5)
        read -p "Do you want to get the data about users from 'u.user'? (y/n): " choice
        echo ""
        if [ "${choice}" = "y" ]; then
            cat $3 | sed -E 's/\|/ /g' | sed -E 's/(\w+) (\w+) (\w+) (\w+).+/user \1 is \2 years old \3 \4/' | head -n 10 | sed -E 's/F/female/g' | sed -E 's/M/male/g'
        fi
        echo ""
        ;;
    6)
        read -p "Do you want to Modify the format of 'release data' in 'u.item' (y/n): " choice
        echo ""
        if [ "${choice}" = "y" ]; then
            cat $1 | sed -E 's/([0-9]{2})-(\w{3})-([0-9]{4})/\3\2\1/' | tail -n 10| sed -E 's/Jan/01/' | sed -E 's/Feb/02/' | sed -E 's/Mar/03/' | sed -E 's/Apr/04/' |\
            sed -E 's/May/05/' | sed -E 's/Jun/06/' | sed -E 's/Jul/07/' | sed -E 's/Aug/08/' | sed -E 's/Sep/09/' | sed -E 's/Oct/10/' |\
            sed -E 's/Nov/11/' | sed -E 's/Dec/12/'
        fi
        ;;
    9)
        echo "Bye!"
        Exit="Y"
        ;;
    esac
done
