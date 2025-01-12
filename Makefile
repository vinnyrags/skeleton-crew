.PHONY: setup

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
	sed -i.bak "s/vinnyrags\/skeleton-crew/${PROJECT_DIR}/g" composer.json
	@echo "Replacement complete. Backup saved as composer.json.bak."

	# Continue with the rest of the setup
	@echo "Configuring DDEV for WordPress..."
	ddev config --project-type=wordpress
	@echo "Starting DDEV environment..."
	ddev start
	@echo "Downloading WordPress core..."
	ddev wp core download
	@echo "Launching the DDEV project..."
	ddev launch
	@echo "Installing Composer dependencies..."
	ddev composer install

	@echo "Setup complete! Your project is ready to use."
