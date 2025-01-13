.PHONY: setup

setup:
	# Validate repository URL
	@echo "Please enter the Git repository URL for your project:"
	@read REPO_URL; \
	if [ -z "$$REPO_URL" ]; then \
		echo "Error: Repository URL cannot be empty."; \
		exit 1; \
	fi; \
	if [[ "$$REPO_URL" != *"vinnyrags"* ]]; then \
		echo "Error: Repository URL is not recognized as one of your repositories."; \
		exit 1; \
	fi; \
	REPO_NAME=$$(basename "$${REPO_URL%.git}"); \
	echo "Derived repository name: $$REPO_NAME"; \
	\
	# Remove skeleton-crew Git-related files
	echo "Cleaning up Git files from skeleton-crew..."; \
	rm -rf .git .github; \
	\
	# Initialize a new Git repository
	echo "Initializing a new Git repository..."; \
	git init; \
	git remote add origin "$$REPO_URL"; \
	echo "Git repository configured with remote URL: $$REPO_URL"; \
	\
	# Replace placeholder names in composer.json
	echo "Replacing vinnyrags/skeleton-crew with $$REPO_NAME in composer.json..."; \
	if [ "$(uname)" == "Darwin" ]; then \
		sed -i '' "s/vinnyrags\/skeleton-crew/$$REPO_NAME/g" composer.json; \
	else \
		sed -i "s/vinnyrags\/skeleton-crew/$$REPO_NAME/g" composer.json; \
	fi; \
	echo "Replacing /ender-man/ with /$$REPO_NAME/ in composer.json..."; \
	if [ "$(uname)" == "Darwin" ]; then \
		sed -i '' "s/\/ender-man\//\/$$REPO_NAME\//g" composer.json; \
	else \
		sed -i "s/\/ender-man\//\/$$REPO_NAME\//g" composer.json; \
	fi; \
	\
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

	# Configure and start DDEV
	@echo "Configuring DDEV for WordPress..."
	ddev config --project-type=wordpress
	@echo "Starting DDEV environment..."
	ddev start
	@echo "Launching the DDEV project..."
	ddev launch

	# Install Composer dependencies
	@echo "Installing Composer dependencies..."
	ddev composer install

	# Remove vinnyrags/ender-man from require-dev in composer.json using sed
	echo "Removing vinnyrags/ender-man from require-dev in composer.json..."; \
	if [ "$(uname)" == "Darwin" ]; then \
		sed -i '' '/"vinnyrags\/ender-man"/d' composer.json; \
	else \
		sed -i '/"vinnyrags\/ender-man"/d' composer.json; \
	fi;

	# Commit the changes
	@echo "Creating an initial Git commit with the message 'skeleton-crew setup'..."
	git add .
	git commit -m "skeleton-crew setup"
	@echo "Initial commit created."

	# Push the changes to the remote repository
	@echo "Pushing changes to the remote repository..."
	git branch -M main
	git push -u origin main
	@echo "Changes pushed to the remote repository."

	@echo "Setup complete! Your project is ready to use."
