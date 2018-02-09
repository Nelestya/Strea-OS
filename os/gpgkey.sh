select i in Generation Afficher; do
        if [ "$i" = "Generation" ]; then
                echo "Generation d'un clé gpg"
                gpg --gen-key
                break
        elif [ "$i" = "Afficher" ]; then
                echo "Affichage des clés"
                gpg --list-key

                break
        else
                echo "mauvaise reponse"
        fi
done
