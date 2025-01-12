.PHONY: setup

# TODO: need to revise this to have the skeleton-crew repo be the starting point, this script assume the project is the starting point and that cant be the case due to the missing Makefile. The script will need to ask for the repository url, we will need to get the project name from the git repository url.

setup:
	# Pull in the skeleton-crew repository and copy its contents
	@echo "Cloning skeleton-crew into a temporary directory..."
	git clone https://github.com/vinnyrags/skeleton-crew.git /tmp/skeleton-crew
	@echo "Copying skeleton-crew contents to the current project..."
	rsync -av --progress /tmp/skeleton-crew/ . --exclude .git --exclude .github
	@echo "Cleaning up temporary skeleton-crew directory..."
	rm -rf /tmp/skeleton-crew

	# Ensure the current project is in its own Git context
	@echo "Verifying the Git repository context remains intact..."
	if [ ! -d .git ]; then \
		echo "Error: .git directory is missing. Ensure this is a cloned repository."; \
		exit 1; \
	fi
	git status >/dev/null 2>&1 || (echo "Error: Not a valid Git repository." && exit 1)

	# Replace vinnyrags/skeleton-crew in composer.json with the project directory name
	@echo "Replacing vinnyrags/skeleton-crew in composer.json with the project directory name..."
	PROJECT_DIR=$(shell basename "$(PWD)")
	sed -i "s/vinnyrags\/skeleton-crew/${PROJECT_DIR}/g" composer.json
	@echo "Replacement complete."

	# Replace /ender-man/ in composer.json with the project directory name
	@echo "Replacing /ender-man/ in composer.json with the project directory name..."
	sed -i "s/\/ender-man\//\/${PROJECT_DIR}\//g" composer.json
	@echo "Replacement complete."

	# Remove "vinnyrags/ender-man" from "require-dev" in composer.json
	@echo "Removing vinnyrags/ender-man from require-dev in composer.json..."
	jq 'del(.["require-dev"]["vinnyrags/ender-man"])' composer.json > composer.temp.json && mv composer.temp.json composer.json
	@echo "vinnyrags/ender-man removed from require-dev."

	# Remove wp-config.php and index.php from /wp/ directory
	@echo "Removing wp-config.php and index.php from /wp/ directory..."
	if [ -f wp/wp-config.php ]; then \
		rm wp/wp-config.php; \
		echo "Removed wp-config.php from /wp/."; \
	else \
		echo "No wp-config.php found in /wp/, skipping."; \
	fi
	if [ -f wp/index.php ]; then \
		rm wp/index.php; \
		echo "Removed index.php from /wp/."; \
	else \
		echo "No index.php found in /wp/, skipping."; \
	fi

	# Continue with the rest of the setup
	@echo "Configuring DDEV for WordPress..."
	ddev config --project-type=wordpress
	@echo "Starting DDEV environment..."
	ddev start
	@echo "Launching the DDEV project..."
	ddev launch
	@echo "Installing Composer dependencies..."
	ddev composer install

	@echo "Setup complete! Your project is ready to use."
