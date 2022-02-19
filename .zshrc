# load seperated config files
for conf in "$HOME/.config/zsh/"*.zsh; do
    source ${conf}

    if [ $? -ne 0 ]; then 
        echo "! Failed to source ${conf}.\nReturn code was $?"
        break
    fi

    echo "> Sourced ${conf} successfully."
done
unset conf
