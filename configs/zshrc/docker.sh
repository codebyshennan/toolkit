############################################################################
#                                                                          #
#               ------- Useful Docker Aliases --------                     #
#                                                                          #
#     # Installation :                                                     #
#     copy/paste these lines into your .bashrc or .zshrc file or just      #
#     type the following in your current shell to try it out:              #
#     wget -O - https://gist.githubusercontent.com/jgrodziski/9ed4a17709baad10dbcd4530b60dfcbb/raw/d84ef1741c59e7ab07fb055a70df1830584c6c18/docker-aliases.sh | bash
#                                                                          #
#     # Usage:                                                             #
#     daws <svc> <cmd> <opts> : aws cli in docker with <svc> <cmd> <opts>  #
#     dc             : docker-compose                                      #
#     dcu            : docker-compose up -d                                #
#     dcd            : docker-compose down                                 #
#     dcr            : docker-compose run                                  #
#     dex <container>: execute a bash shell inside the RUNNING <container> #
#     di <container> : docker inspect <container>                          #
#     dim            : docker images                                       #
#     dip            : IP addresses of all running containers              #
#     dl <container> : docker logs -f <container>                          #
#     dnames         : names of all running containers                     #
#     dps            : docker ps                                           #
#     dpsa           : docker ps -a                                        #
#     drmc           : remove all exited containers                        #
#     drmid          : remove all dangling images                          #
#     drun <image>   : execute a bash shell in NEW container from <image>  #
#     dsr <container>: stop then remove <container>                        #
#                                                                          #
############################################################################

# retrieves the names of all running Docker containers.
function dnames-fn {
	for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
	do
    	docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}

# $ dnames-fn
# example_container_1
# example_container_2
# ...

# retrieves the IP addresses of all named running Docker containers
function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT | column -t
    unset OUT
}

# $ dip-fn
# IP addresses of all named running containers
# example_container_1      172.17.0.2
# example_container_2      172.17.0.3
# ...

# allows you to run a command inside a running Docker container
function dex-fn {
	docker exec -it $1 ${2:-bash}
}
# e.g. dex-fn <container_id> ls -al

# inspects the Docker container with the given ID. 
function di-fn {
	docker inspect $1
}
# e.g $ di-fn example_container_1

# displays the logs of the Docker container with the given ID in real-time. 
function dl-fn {
	docker logs -f $1
}
# e.g. $ dl-fn example_container_1

# runs a new Docker container with the given image and command
function drun-fn {
	docker run -it $1 $2
}
# e.g. $ drun-fn ubuntu bash

# runs a command in a Docker Compose service
function dcr-fn {
	docker-compose run $@
}
# e.g. $ dcr-fn webserver ls -al

# stops and removes a Docker container with the given ID
function dsr-fn {
	docker stop $1;docker rm $1
}
# $ dsr-fn example_container_1

# removes all stopped Docker containers
function drmc-fn {
       docker rm $(docker ps --all -q -f status=exited)
}

# removes dangling Docker images
function drmid-fn {
       imgs=$(docker images -q -f dangling=true)
       [ ! -z "$imgs" ] && docker rmi "$imgs" || echo "no dangling images."
}

# in order to do things like dex $(dlab label) sh
# returns the ID of a running Docker container with the specified label.
function dlab {
       docker ps --filter="label=$1" --format="{{.ID}}"
}

# used to run docker-compose commands, e.g. start Docker Compose stack in detached mode
function dc-fn {
        docker-compose $*
}
# e.g: $ dc-fn up -d

function d-aws-cli-fn {
    docker run \
           -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
           -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
           -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
           amazon/aws-cli:latest $1 $2 $3
}
# e.g. $ d-aws-cli-fn s3 ls my-bucket

alias daws=d-aws-cli-fn
alias dc=dc-fn
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr=dcr-fn
alias dex=dex-fn
alias di=di-fn
alias dim="docker images"
alias dip=dip-fn
alias dl=dl-fn
alias dnames=dnames-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drmc=drmc-fn
alias drmid=drmid-fn
alias drun=drun-fn
alias dsp="docker system prune --all"
alias dsr=dsr-fn
