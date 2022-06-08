#!/bin/bash


User() { # Prompts the user for a value
    echo "Hello! " $1 " welcome to the program and enter your name with your UserID " $2
    echo "   Time: $(date)"
    echo
    echo " --------< So, lets begin the program togther >--------"
    echo
    showBand
}

showBand(){ # List of the music bands
    echo " |* Here are some list of the music Band in the world |"

    echo "+------------------+"
    echo "| band    | code   |"
    echo "|-------------------"
    echo "|Beatles  | BEA    |"
    echo "|AC/DC    | AD     |"
    echo "|Queen    | QUE    |"
    echo "|Blondie  | BLO    |"
    echo "|Nirvana  | NIR    |"
    echo "|------------------|"
    selectBand
}

selectBand(){ # Function for choosing the music band


     bandSelect=""

 until [[ $bandSelect == QUE ]]

 do

 read bandSelect

case $bandSelect in

 BEA) echo "Your Prediction is wrong."

 ;;

 AD) echo "Your Prediction is wrong."
 ;;

   QUE)echo  "    --> You did it! The which you have selected as your favourite music band is matched :)."
       echo  "          Queen, British rock band whose fusion of heavy metal, glam rock, and camp theatrics made it one of the famous groups in 1970's."
       listBandMembers
;;

   BLO) echo" your prediction is incorrect"

;;

  NIR) echo" your predicion is incorrect"
;;

 *) echo "Please enter the valid code."

;;

esac

done

}

listBandMembers(){ # Function for showing the music band members
    echo ""
    echo "  |* Here are the list of someof the talented Band members: |"

    echo "+-----------------------+"
    echo "| list of band members  |"
    echo "+-----------------------+"
    echo "|John Lenon       | JL  |"
    echo "|Angus Young      | AY  |"
    echo "|Freedie Mercury  | FM  |"
    echo "|Debbie Harry     | DH  |"
    echo "|Kurt Cobian      | KC  |"
    echo "+-----------------------+"
    selectBandMember
}

selectBandMember(){ # Function for choosing the music band member
    echo""
    echo " -- Kindly, select the three member!(space must be given while writing member's code) -- "
    read members
    firstWord=""
    secondWord=""
    thirdWord=""
    while [[ $firstWord == "" ]]
    do
        for artist in $members
        do
            if [[ $artist == "JL" || $artist == "AY" || $artist == "FM" || $artist == "DH"
            || $artist == "KC" ]]
            then
                if [[ $firstWord == "" ]]
                then
                    firstWord=$artist
                elif [[ $secondWord == "" ]]
                then
                    if [[ $firstWord == $artist ]]
                    then
                        echo " -- Selected artist code, $artist is repeated! Please enter three different
                        code of three different member!!!"
                        echo ""
                        listBandMembers
                    else
                        secondWord=$artist
                    fi
                elif [[ $firstWord == $artist || $secondWord == $artist ]]
                then
                    echo "   Selected artist code '$artist' is repeated! Please enter three different 
                    code of three different members !!!"
                    echo ""
                    listBandMembers
                else
                    pickedMember $members
                fi
            else
                echo "  --- Invaild code!!, Yor provided code is invaild, kindly, use the code provided above. ---"
                echo
                listBandMembers
            fi
        done
    done

}

pickedMember(){ # Function for showing the choosen members
    if [[ $# == 3 ]]; then
        echo
        echo "  --- * You have to select the following members --- "
        PS3="  -------  * Just choose a member only by number :) ------- "
        select selectedartist in $members
        do
            case $selectedartist in
                "JL")
                    showFile "Johnlennon.txt"
                break;;
                "AY")
                    showFile "Angusyoung.txt"
                break;;
                "FM")
                    showFile "Freddiemercury.txt"
                break;;
                "DH")
                    showFile "Deborahharry.txt"
                break;;
                "KC")
                    showFile "Kurtcobain.txt"
                break;;
                *)
                    echo "   You chose a wrong number"
                    listBandMembers
            esac
        done
         userinput
    else
        echo "   You must have to choose three members"
        listBandMembers
    fi


}

showFile(){ # Function for displaying the file of the choosen member
    if [ -f $1 ]
    then
        echo "    -> The choosen band member's biography is as follows: "
        cat $1
    else
        echo "      Sorry!, The file does not exist"
        showBand
    fi
}

userinput(){ # Function for asking user to choose again or exit the program
    echo -e "\n   * Do you want to continue? (yes/no)"
    read input
    if [[ $input == "y" || $input == "Y" || $input == "yes" || $input == "Yes" ]]; then
        showBand
    elif [[ $input == "n" || $input == "N" || $input == "no" || $input == "No" ]]; then
        echo "      Hope you have a good time here, See you soon :) "
        exit
    else
        echo "   You have to choose either yes or no!"
        userinput
    fi
}
start(){ # function to start the program
    secretkey=5991
    count=3
    until [ $count -eq 0 ]
    do
        read -s -p "   Enter Password: " key
        if [ $key -eq $secretkey ]; then
            echo -e "\n   Congratulation! You have entered the correct key."
            echo
            User $1 $2
            break
        else
            echo "   You just have $(($count-1)) tries left"
            count=$((count-1))
        fi
    done
    if [ $count -eq 0 ]; then
        echo "   opps! You have entered the wrong key for three times"
        echo "   Sorry! The program will exit"
        exit
    fi
}

if [ $# -eq 2 ]
then
    start $1 $2
else
    echo "   Sorry! You have entered the wrong Name and Id number "
     echo  " 2 Argument is expected."
        echo "Example: $0 xyx 20048538"
fi

