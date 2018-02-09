SNOTRA=/home/snotra/Documents/os/
HEL=/home/$USER/Documents/os/
DI=/home/$USER/Documents/os/debian-installer
GPGKEY=
# you need
# apt-get install myrepos subversion git

#echo "dl for Download or i for make the debian-installer"
echo "Download or install debian-installer ?"
select i in Download Install Modification Remove; do
        if [ "$i" = "Download" ]; then
                echo "Download debian-installer source"
                svn checkout svn://anonscm.debian.org/svn/d-i/trunk debian-installer
                cd debian-installer
                scripts/git-setup
                mr -p checkout
                break
        elif [ "$i" = "Install" ]; then
                echo "Make debian-installer source"
                cd $DI/installer/build
                make reallyclean
                fakeroot make build_cdrom_isolinux
                #cp -rf $DI/installer/build/dest/* /media/hel/Depots/miroir/dists/stretch/main/installer-amd64/current/images/
                break

        elif [ "$i" = "Modification" ]; then
                echo "Modification automatiser debian-installer source"
                #automatisation de la création des paquets
                ################################################################

                echo "Udeb creation begin"
                rm -rf $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                touch $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                ################################################################
                #
                #                        rootskel-gtk
                ################################################################

                echo "#include \"base\"" >> $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                echo "#include \"kernel\"" >> $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                echo "rootskel-gtk" >> $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                cd $DI/packages
                #modification de rootskel-gtk
                echo "Creation udeb : rootskel-gtk"
                cd rootskel-gtk
                # A FAIRE FEIGNASSE
                cp -rf $HEL/modd_i/rootskel-gtk/* $DI/packages/rootskel-gtk/src/usr/share/
                #incorporation de l'image dans rootskel-gtk
                debuild -S -rfakeroot -k$GPGKEY
                fakeroot debian/rules binary
                cd ..
                ################################################################
                #                        netcfg
                #                        change hostname default
                ################################################################
                echo "Creation udeb : netcfg"
                echo "netcfg" >> $DI/installer/build/pkg-lists/cdrom/isolinux/gtk/local
                cd netcfg
                debuild -S -rfakeroot -k$GPGKEY
                fakeroot debian/rules binary
                cd ..
                
                echo "Udeb creation finish"

                ################################################################
                echo "copy in localudeb"
                cp -rf $DI/packages/*.udeb $DI/installer/build/localudebs/

                echo "modification des source list"


                break

        elif [ "$i" = "Remove" ]; then
                echo "remove debian-installer source"
                rm -rf $DI
                echo "Remove debian-installer source finish"
                break
        else
                echo "mauvaise reponse"
        fi
done
