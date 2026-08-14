# User Documentation

This guide outlines how to operate, manage, and verify the services provided by the Inception stack.

## Provided Services
This infrastructure provides a fully functional, secure web environment consisting of:
*   **NGINX**: A web server acting as the single secure entry point (TLSv1.2/v1.3) handling HTTPS requests.
*   **WordPress**: A content management system (CMS) powered by PHP-FPM for publishing web content.
*   **MariaDB**: A relational database that securely stores all the WordPress site's data.

## Starting and Stopping the Project
The project includes a Makefile at the root for easy management.
*   **To start the project:** Run `make all` or `make up`. This will create the necessary data directories, build the Docker images, and start the containers.
*   **To stop the project:** Run `make stop` (pauses the containers) or `make down` (stops and removes the containers but preserves data).
*   **To perform a clean stop:** Run `make clean` to stop containers and remove networks.

## Accessing the Website and Administration Panel
*   **Website:** Open a web browser and navigate to `https://nosahimi.42.fr`. Note: Because the TLS certificate is self-signed, your browser may issue a security warning. You will need to click "Advanced" and proceed to the site.
*   **Administration Panel:** To manage the WordPress site, navigate to `https://nosahimi.42.fr/wp-admin`.

## Locating and Managing Credentials
All sensitive credentials required for login (Database passwords, WordPress Admin, and User passwords) are managed securely via text files. 
*   They are located in the `secrets/` directory (one level above the `srcs` folder). 
*   **Important:** Never commit these secret files to version control. If you need to change a password, update the respective `.txt` file before building the containers.

## Checking Service Status
To verify that all services are running correctly:
1. Open a terminal in the `srcs` directory.
2. Run `docker compose ps` to view the status of `nginx`, `wordpress`, and `mariadb`. All containers should report an "Up" status.
3. You can also view live logs by running `make logs`.
