!! This project will not work on your machine unless adapted as it is was created to work in accordance with my file structures.

**What is Docker? And what makes it different from a VM?**

Docker is a bit like a VM except that instead of installing a whole OS, it uses your computer's existing OS resources.
You can compare Docker to a flat and a VM to a house. They are both isolated environments but a flat will use the building's water/electricity resources whereas a house won't.
Docker is therefore much lighter than a VM.

**Alpine vs Debian**

Alpine is a lot faster and lighter than Debian for this project. I highly recommend it!

**What is Docker-compose?**

Docker-compose is a really handy tool for launching multi-container Docker stacks. 
You can have several containers running different services within one network which can communciate with one another.
It also has some handy commands which combine multiple Docker commands to save you time.

**Communication between containters:**

There are various points where the containers need to communicate with each other.
1) **Nginx + PHP:** I modified the nginx.conf file (Nginx contianer) to tell Nginx to pass php requests to the php container on port 9000 
and the www.conf file (WP/PHP container) to tell the php container to listen to port 9000 for requests from Nginx!
2) **Mariadb + Wordpress:** The script I launch in the entrypoint of my Mariadb container grants my WP container access to the Wordpress database. 
I can then log in and modify the database from my WP container using the login details I set up. They communicate via port 3306.
3) **Wordpress + Nginx:** I use a volume specified in the docker-compose.yml to mount the website files from the WP container into the Nginx container.

![structure](https://user-images.githubusercontent.com/52970539/123990604-345c0880-d9ca-11eb-81b2-c1d9d423c1cd.jpg)

**What does the PID have to do with anything???**

The command used at the end of your Dockerfile (with ENTRYPOINT/COMMAND) will be given the PID 1, which is problematic when you use this commannd to launch a script in which you launch your service.
This is because the script cannot handle SIGTERM signals and pass them onto the service/command launched in your script, so Docker won't be able to exit gracefully. 
To avoid this, if you need to use a script, you can end your script with exec [command] which will give this command the PID 1 instead of the script 
and the sevrice will therefore be able to receive SIGTERM signals and stop if you stop your docker container. 

TO CHECK IF DOCKER EXITS GRACEFULLY:

1) docker stop [container name]
2) docker inspect -f '{{.State.ExitCode}}' [container name]
3) the exit code should be 0... If it is something else, often something like 127, then it didn't exit gracefuly which means it couldn't close all the programs launched in the .sh !

**WP set-up**

I install my WP with an admin (details specified in my .env file and passed on to the container via docker-compose file)

wp core install --url="$WP_SITE" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_EMAIL" --skip-email

And I then create a new non-admin user:
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass="$WP_USER_PASSWORD"

I can then login to website/wp-admin as either user using the login details I gave them:
![users](https://user-images.githubusercontent.com/52970539/123985382-b990ee80-d9c5-11eb-9e12-83eeb2dbcd0d.png)


