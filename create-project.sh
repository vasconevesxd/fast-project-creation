#!/bin/bash

sudo apt-get update
sudo apt-get install dialog

getName() {
      OUTPUT="/tmp/input.txt"

      # create empty file
      >$OUTPUT

      # cleanup  - add a trap that will remove $OUTPUT
      # if any of the signals - SIGHUP SIGINT SIGTERM it received.
      trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

      # show an inputbox
      dialog --title "Inputbox - To take input from you" \
            --inputbox "Enter the name of the project " 8 40 2>$OUTPUT

      # get respose
      respose=$?

      # get data stored in $OUPUT using input redirection
      name=$(<$OUTPUT)
}

installPackages() {

      docker_command = docker-compose exec

      dialog --title "Packages Installation" \
            --yesno "Do you want to install packages" 7 60

      response=$?
      case $response in
      0) declare installation=0 ;;
      1) declare installation=1 ;;
      255) echo "[ESC] key pressed." ;;
      esac

      if [ $installation == 0 ]; then
            cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
            options=(1 "Bootstrap" off # any option can be set to default to "on"
                  2 "Bootstrap Vue" off
                  3 "Vue Router" off
                  4 "Vuex" off
                  5 "Axios" off
                  6 "Element Ui"
                  7 "Laravel Ui" off
                  8 "Stylelint" off
                  9 "Eslint" off
                  10 "Sass" off
                  11 "JWT Auth" off
            )
            choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
            clear
            for choice in $choices; do
                  case $choice in
                  1)
                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i bootstrap
                        else
                              cd $frontend_name
                              npm i bootstrap
                        fi

                        ;;
                  2)

                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i bootstrap-vue
                        else
                              cd $frontend_name
                              npm i bootstrap-vue
                        fi

                        ;;
                  3)

                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i vue-router
                        else
                              cd $frontend_name
                              npm i vue-router
                        fi
                        ;;
                  4)
                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i vuex
                        else
                              cd $frontend_name
                              npm i vuex
                        fi

                        ;;
                  5)

                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i axios
                        else
                              cd $frontend_name
                              npm i axios
                        fi
                        ;;
                  6)

                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i element-ui
                        else
                              cd $frontend_name
                              npm i element-ui
                        fi
                        ;;
                  7)

                        if [ $1 == 0 ]; then
                              $docker_command $api_name composer require laravel/ui
                        else
                              cd $api_name
                              composer require laravel/ui
                        fi
                        ;;
                  8)
                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i stylelint
                              $docker_command $frontend_name npm i stylelint-config-standard
                              $docker_command $frontend_name npm i stylelint-config-sass-guidelines
                        else
                              cd $frontend_name
                              npm i stylelint
                              npm i stylelint-config-standard
                              npm i stylelint-config-sass-guidelines
                        fi

                        cp fast-project-creation/vue/.stylelintrc.json $frontend_name

                        ;;
                  9)
                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i eslint
                              $docker_command $frontend_name npm i eslint-plugin-vue
                              $docker_command $frontend_name npm i eslint-plugin-vue-scoped-css
                              $docker_command $frontend_name npm i eslint-plugin-import
                              $docker_command $frontend_name npm i eslint-import-resolver-alias
                              $docker_command $frontend_name npm i eslint-config-airbnb-base
                        else
                              cd $frontend_name
                              npm i eslint
                              npm i eslint-plugin-vue
                              npm i eslint-plugin-vue-scoped-css
                              npm i eslint-plugin-import
                              npm i eslint-import-resolver-alias
                              npm i eslint-config-airbnb-base

                        fi

                        cp fast-project-creation/vue/.eslintrc.js $frontend_name
                        ;;
                  10)

                        if [ $1 == 0 ]; then
                              $docker_command $frontend_name npm i sass
                              $docker_command $frontend_name npm i sass-loader
                              $docker_command $frontend_name npm i node-sass
                        else
                              cd $frontend_name
                              npm i sass
                              npm i sass-loader
                              npm i node-sass
                        fi

                        ;;
                  11)
                        if [ $1 == 0 ]; then
                              $docker_command $api_name composer require tymon/jwt-auth
                              cd $api_name/config
                              sed -i '/RouteServiceProvider::class,/a Tymon\JWTAuth\Providers\LaravelServiceProvider::class,' app.php
                              cd ..
                              cd ..
                              $docker_command $api_name php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
                              $docker_command $api_name php artisan jwt:secret
                              awk -e '/JWT_SECRET/' .env >>$api_name/.env
                        else
                              cd $api_name
                              composer require tymon/jwt-auth
                              cd $api_name/config
                              sed -i '/RouteServiceProvider::class,/a Tymon\JWTAuth\Providers\LaravelServiceProvider::class,' app.php
                              cd ..
                              php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
                              php artisan jwt:secret
                              awk -e '/JWT_SECRET/' .env >>$api_name/.env
                        fi

                        ;;

                  esac
            done
      fi

}

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

if [ $installation_type == 1 ]; then

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

            getName

            # make a decsion
            case $respose in
            0)
                  curl -s "https://laravel.build/${name}" | bash

                  dialog --title "Docker Installation" \
                        --yesno "Do you want to install Docker" 7 60

                  response=$?
                  case $response in
                  0) declare installation_docker=0 ;;
                  1) declare installation_docker=1 ;;
                  255) echo "[ESC] key pressed." ;;
                  esac

                  if [ $installation_docker == 0 ]; then

                        cp -r fast-project-creation/nginx .
                        cp fast-project-creation/docker/docker-compose.yml .
                        cp fast-project-creation/docker/laravel/Dockerfile $name/
                        cp fast-project-creation/laravel/xdebug.ini $name/
                        docker-compose up -d
                  fi

                  installPackages "$installation_docker"

                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            ;;

      2)

            getName

            # make a decsion
            case $respose in
            0)
                  vue create ${name}

                  dialog --title "Docker Installation" \
                        --yesno "Do you want to install Docker" 7 60

                  response=$?
                  case $response in
                  0) declare installation_docker=0 ;;
                  1) declare installation_docker=1 ;;
                  255) echo "[ESC] key pressed." ;;
                  esac

                  if [ $installation_docker == 0 ]; then

                        cp fast-project-creation/docker/vue/Dockerfile $name/
                        docker-compose up -d
                  fi
                  installPackages
                  ;;

            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            ;;
      3)

            getName

            # make a decsion
            case $respose in
            0)
                  npx create-react-app ${name}

                  dialog --title "Docker Installation" \
                        --yesno "Do you want to install Docker" 7 60

                  response=$?
                  case $response in
                  0) declare installation_docker=0 ;;
                  1) declare installation_docker=1 ;;
                  255) echo "[ESC] key pressed." ;;
                  esac

                  if [ $installation_docker == 0 ]; then

                        #cp fast-project-creation/docker/vue/Dockerfile $name/
                        #docker-compose up -d
                  fi
                  installPackages
                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            ;;
      esac

elif
      [ $installation_type == 2 ]
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

            getName

            # make a decsion
            case $respose in
            0)
                  git git@github.com:vasconevesxd/fast-project-creation.git
                  curl -s "https://laravel.build/${name}" | bash
                  chmod -R 777 ${name}/storage
                  cp fast-project-creation/laravel/{supervisord.conf,uploads.ini} ${name}/

                  api_name = ${name}
                  option_type = 1

                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            getName

            # make a decsion
            case $respose in
            0)

                  vue create ${name}
                  cp fast-project-creation/vue/vue.config.js ${name}/
                  frontend_name = ${name}
                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            ;;

      2)

            getName

            # make a decsion
            case $respose in
            0)
                  git git@github.com:vasconevesxd/fast-project-creation.git
                  curl -s "https://laravel.build/${name}" | bash
                  chmod -R 777 ${name}/storage
                  cp fast-project-creation/laravel/{supervisord.conf,uploads.ini} ${name}/
                  api_name = ${name}
                  option_type = 2
                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            getName

            # make a decsion
            case $respose in
            0)

                  npx create-react-app ${name}

                  frontend_name = ${name}
                  ;;
            1)
                  echo "Cancel pressed."
                  ;;
            255)
                  echo "[ESC] key pressed."
                  ;;
            esac

            # remove $OUTPUT file
            rm $OUTPUT

            ;;

      esac

      dialog --title "Docker Installation" \
            --yesno "Do you want to install Docker" 7 60

      response=$?
      case $response in
      0) declare installation_docker=0 ;;
      1) declare installation_docker=1 ;;
      255) echo "[ESC] key pressed." ;;
      esac

      if [ $installation_docker == 0 ]; then

            if [ $option_type == 1 ]; then

                  cp -r fast-project-creation/nginx .
                  cp fast-project-creation/docker/docker-compose.yml .
                  cp fast-project-creation/docker/laravel/Dockerfile $api_name/
                  cp fast-project-creation/laravel/xdebug.ini $api_name/
                  cp fast-project-creation/docker/vue/Dockerfile $frontend_name/
                  docker-compose up -d

                  installPackages

            elif [ $option_type == 2]; then

                  cp -r fast-project-creation/nginx .
                  cp fast-project-creation/docker/docker-compose.yml .
                  cp fast-project-creation/docker/laravel/Dockerfile $api_name/
                  cp fast-project-creation/laravel/xdebug.ini $api_name/
                  cp fast-project-creation/docker/react/Dockerfile $frontend_name/
                  docker-compose up -d

                  installPackages
            fi

      elif [ $installation_docker == 1 ]; then

            installPackages

      fi
fi

clear
