#!/bin/bash
sudo apt-get update
sudo apt-get install dialog

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Base Project Creation"
TITLE="Framework Installation Type"
MENU="Choose one of the following options:"

OPTIONS=(1 "Framework"
         2 "Framework Pack"
         )

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear



case $CHOICE in
        1)
            declare installation_type=1
            ;;
        2)
            declare installation_type=2
            ;;
esac

if [ $installation_type == 1 ]
then
   
 HEIGHT=15
   WIDTH=40
   CHOICE_HEIGHT=4
   BACKTITLE="Base Project Creation"
   TITLE="Framework Installation"
   MENU="Choose one of the following options:"

   OPTIONS=(1 "Laravel"
            2 "Vue"
            3 "React"
            )

   CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)

   clear

   case $CHOICE in
         1)
               curl -s "https://laravel.build/api" | bash

               ;;
         2)
               vue create spa
               ;;
         3)
               npx create-react-app my-app
               ;;               
   esac

elif [ $installation_type == 2 ]
then
   HEIGHT=15
   WIDTH=40
   CHOICE_HEIGHT=4
   BACKTITLE="Base Project Creation"
   TITLE="Framework Pack Installation"
   MENU="Choose one of the following options:"

   OPTIONS=(1 "Laravel\Vue"
            2 "Laravel\React"
            )

   CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)

   clear

   case $CHOICE in
         1)
               curl -s "https://laravel.build/api" | bash
               vue create spa
               ;;
         2)
               curl -s "https://laravel.build/api" | bash
               npx create-react-app my-app
               ;;
   esac

   dialog --title "Docker Installation" \
   --yesno "Do you want to install Docker" 7 60

   # Get exit status
   # 0 means user hit [yes] button.
   # 1 means user hit [no] button.
   # 255 means user hit [Esc] key.
   response=$?
   case $response in
      0) declare installation_docker=0;;
      1) declare installation_docker=1;;
      255) echo "[ESC] key pressed.";;
   esac

fi

if [ $installation_docker == 0 ];
then
  git git@github.com:vasconevesxd/fast-project-creation.git

fi

 dialog --title "Packages Installation" \
   --yesno "Do you want to install packages" 7 60

   # Get exit status
   # 0 means user hit [yes] button.
   # 1 means user hit [no] button.
   # 255 means user hit [Esc] key.
   response=$?
   case $response in
      0) declare installation=0;;
      1) declare installation=1;;
      255) echo "[ESC] key pressed.";;
   esac


if [ $installation == 0 ];
then
   cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
   options=(1 "Bootstrap" off    # any option can be set to default to "on"
            2 "Bootstrap Vue" off
            3 "Vue Router" off
            4 "Vuex" off
            5 "Axios" off
            6 "Element Ui"
            7 "Laravel Ui" off
            8 "Stylelint" off
            9 "Eslint" off
            10 "Sass" off
            )
   choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
   clear
   for choice in $choices
   do
      case $choice in
         1)
               $docker_command npm i bootstrap
               ;;
         2)
               $docker_command npm i bootstrap-vue
               ;;
         3)
               $docker_command npm i vue-router
               ;;
         4)
               $docker_command npm i vuex
               ;;
         5)
               $docker_command npm i axios
               ;;
         6)
               $docker_command npm i element-ui
               ;;
         7)
               $docker_command composer require laravel/ui
               ;;
         8)
               $docker_command npm i stylelint
               $docker_command npm i stylelint-config-standard
               $docker_command npm i stylelint-config-sass-guidelines

               ;;
         9)
               $docker_command npm i eslint
               $docker_command npm i eslint-plugin-vue
               $docker_command npm i eslint-plugin-vue-scoped-css
               $docker_command npm i eslint-plugin-import
               $docker_command npm i eslint-import-resolver-alias
               $docker_command npm i eslint-config-airbnb-base
               ;;
         10)
               $docker_command npm i sass
               $docker_command npm i sass-loader
               $docker_command npm i node-sass
               ;;               
      esac
   done
fi

<< 'MULTILINE-COMMENT'

===Vue===
vue.config.js
.stylelintrc.json
.eslintrc.js

===Laravel===
xdebug.ini
uploads.ini
supervisord.conf


echo "Add Dockers(y)"
read add_docker


echo "Add AUTH(y)"
read add_auth

if [ "$add_auth" == "y" ]
then
    docker-compose exec php composer require tymon/jwt-auth
    cd api/config
    sed -i '/RouteServiceProvider::class,/a Tymon\JWTAuth\Providers\LaravelServiceProvider::class,' app.php
    cd ..
    cd ..
    docker-compose exec php php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
    docker-compose exec php php artisan jwt:secret
    awk -e '/JWT_SECRET/' .env >> api/.env
fi
MULTILINE-COMMENT






