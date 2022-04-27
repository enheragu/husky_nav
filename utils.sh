## Setup to run docker without sudo, just to be done once
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker 

UTILS_SH_PATH=${BASH_SOURCE}


build-husky-image()
{
    docker build -t husky-image . 
}

husky-container-run()
{
    xhost +local:root
    docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$UTILS_SH_PATH/..:/workspace" \
    --name=husky-image \
    husky-image "bash"
    xhost -local:root 
}


husky-container-enter()
{
    docker exec -it husky-image bash -c "bash; source /ros_entrypoint.sh; bash"
}

husky-container-delete()
{
    docker container rm husky-image
}