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
    9)
        echo "Bye!"
        Exit="Y"
        ;;
    esac
done
