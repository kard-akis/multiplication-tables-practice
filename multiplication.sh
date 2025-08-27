#!/bin/bash
# Author Lubos Rendek <web@linuxconfig.org>
## Contributor kàrdakis <kardakis@proton.me>

errors=0
num=10 ## I changed the number of questions to 10
question_str="prodotto"
random_range=100
result=-1
start=$SECONDS

# Create an array of 100 multiplication questions and answers as a default.
for j in $( seq 1 10); do 
    for i in $( seq 1 10); do 
        questions[((element++))]="$i x $j=$(($i*$j))"
    done
done

# Parse command line options options
while getopts 'dasq:' OPTION; do
    case "$OPTION" in
    d) # Division
        questions=() # Clear questions array
        element=0 
        question_str="division"
        for j in $( seq 1 10); do 
            for i in $( seq 1 10); do 
                questions[((element++))]="$(($i*$j)) : $j=$(($(($i*$j))/$j))"
            done
        done
        ;;
    a) # Addition
        questions=() # Clear questions array
        element=0 
        question_str="sum"
        for j in $( seq 1 10); do 
            for i in $( seq 1 10); do 
                questions[((element++))]="$i + $j=$(($i+$j))"
            done
        done
        ;;
    s) # Subtraction
        questions=() # Clear questions array
        element=0 
        question_str="result"
        random_range=55
        for j in $( seq 1 10); do 
            for i in $( seq 1 10); do 
                item=$( echo "$i - $j=$(($i-$j))" | grep -v "=-")
                if [ ! -z "$item" ]; then
                    questions[((element++))]=$item
                fi
            done
        done
        ;;
    q)
        num=$OPTARG 
        ;;
    ?)
        echo "script usage: $(basename $0) [-d] [-q total_questios]" >&2
        exit 1
        ;;
    esac
done
shift "$(($OPTIND -1))"

# Function to grab a random question from pool.
function get_question {

    rand=$(( ( RANDOM % $random_range )  + 1 ))
    question=$(echo ${questions[$rand]} | cut -d = -f1)
    result=$(echo ${questions[$rand]} | cut -d = -f2)

}

# Function to print questions.
function print_question {

    echo "################################"
    printf "\033[0;36mWhat is the $question_str of $question ?\e[0m\n"
    echo -n "Rispondi qui: "
}

# A core function to ask a question and compare response with a valid result.
function ask_question {

response=0
while [ $response -ne $result ]; do 

    
    print_question
    read response
    
    # Keep asking for a response until we get a valid integer.
    while [[ $((response)) != $response ]]; do
        print_question
        read response
    done
    

    if [ $response -eq $result ]; then
        printf "\033[1;32mCorretto!\e[0m\n"
        num=$[$num-1]
        printf "\033[0;33mDomande rimanenti: $num \e[0m\n"
    else
        printf "\033[1;31mRisposta sbagliata, riprova!\e[0m\n"
        errors=$[$errors+1]
        printf "\033[0;33mDomande rimanenti: $num \e[0m\n"
    fi
    
done

}

start_num=$num
# Main while loop to process the requested number of questions.
until [  $num -eq 0 ]; do
    get_question; ask_question;
done

# echo "Congratulations, your practice test is finished!!!"
s="$((SECONDS - start))"                                                                                                                                                                                                                      
m="$(( (SECONDS - start) / 60))"                                                                                                                                                                                                              
sl="$(((SECONDS - start) % 60))"                                                                                                                                                                                                              
minutes=$(printf %02d $m)                                                                                                                                                                                                                     
seconds=$(printf %02d $sl)                                                                                                                                                                                                                    
echo "Hai risposto a $start_num domande in $minutes:$seconds con $errors risposte sbagliate."
