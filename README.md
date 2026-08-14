*This project has been created as part of the 42 curriculum by nosahimi.*

## Description
Inception is a system administration project that focuses on virtualizing a complete web infrastructure using Docker. The goal is to deploy a multi-container stack consisting of an NGINX web server, a WordPress application running with PHP-FPM, and a MariaDB database. Each service runs in its own dedicated container, built from custom Dockerfiles based on Debian Bookworm, and they communicate via an internal Docker bridge network.

## Instructions
To compile, install, and execute the project:
1. Ensure Docker and Docker Compose are installed on your host machine.
2. Verify that the required secrets exist in the `../secrets/` directory relative to the `srcs` folder.
3. Verify that your `/etc/hosts` file routes `nosahimi.42.fr` to `127.0.0.1`.
4. Run `make all` or `make up` from the root directory to build the images and start the containers in detached mode.
5. The application will be securely available at `https://nosahimi.42.fr`.

## Resources
*   [Docker Documentation](https://docs.docker.com/)
*   [NGINX Documentation](https://nginx.org/en/docs/)
*   [WordPress Developer Resources](https://developer.wordpress.org/)
*   [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
*   **AI Usage**: Artificial Intelligence was utilized strictly for formatting documentation, and refining technical explanations to ensure clarity and scannability within the project's documentation files.

## Project Description
This infrastructure strictly utilizes Docker to containerize services. The project is managed using `docker-compose.yml` and builds upon custom Debian Bookworm images.

### Virtual Machines vs Docker
Virtual Machines (VMs) hypervise a complete hardware stack, meaning each VM runs a full, heavy guest operating system on top of a hypervisor. Docker, conversely, utilizes containerization at the OS level. Containers share the host machine's kernel, making them significantly more lightweight, faster to spin up, and less resource-intensive than traditional VMs.

### Secrets vs Environment Variables
Environment variables (`.env`) are used for non-sensitive configuration values (like domain names or database names). However, storing sensitive credentials in environment variables can expose them in logs or inspection outputs. Docker Secrets securely manage sensitive data (such as database passwords and WordPress admin credentials) by mounting them directly into the container's temporary memory file system, ensuring they are never exposed in image layers or source control.

### Docker Network vs Host Network
A Docker Network (specifically a user-defined bridge network like `inception_network`) creates an isolated, internal network allowing containers to communicate securely with each other using DNS resolution (e.g., WordPress connecting to `mariadb`). A Host Network removes network isolation, attaching the container directly to the host's networking interface, which poses a security risk and can lead to port conflicts. This project strictly isolates backend services, exposing only NGINX on port 443.

### Docker Volumes vs Bind Mounts
Bind mounts link a container directory directly to a specific, absolute path on the host system, making them dependent on the host's exact directory structure. Docker Volumes are fully managed by the Docker engine, providing better data portability, easier backup mechanisms, and avoiding filesystem permission issues. This project uses local volumes configured to map specifically to `/home/nosahimi/data`.
