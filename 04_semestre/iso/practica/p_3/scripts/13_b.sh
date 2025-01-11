#!/bin/bash

select op in Listar DondeEstoy QuienEsta Quit
do
    case $op in
        Listar)
            echo "$(pwd | ls)"
            ;;
        DondeEstoy)
            echo "$(pwd)"
            ;;
        QuienEsta)
            echo "$(who)"
            ;;
        Quit)
            break
        ;;
    esac
done