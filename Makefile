.PHONY: setup

setup:
	# Ask for the project repository URL
	@echo "Enter the project repository URL (e.g., https://github.com/vinnyrags/yourproject.git):"
	@read -r REPO_URL; \
	if [ -z "$$REPO_URL" ]; then \
		echo "Error: Repository URL cannot be empty."; \
		exit 1; \
	fi; \
	if ! echo "$$REPO_URL" | grep -q "vinnyrags"; then \
		echo "Error: Repository URL does not belong to vinnyrags."; \
		exit 1; \
	fi; \
	echo "Valid repository URL detected: $$REPO_URL"; \
	REPO_NAME=$$(basename "$$REPO_URL" .git); \
	echo "Derived repository name: $$REPO_NAME"; \

	# Remove skeleton-crew's .git and .github directories
	@echo "Removing .git and .github directories from skeleton-crew..."
	rm -rf .git .github
	@echo "Removed .git and .github directories."

	# Initialize a new Git repository and set the new origin
	@echo "Initializing a new Git repository..."
	git init
	@echo "Setting the remote origin to $$REPO_URL..."
	git remote add origin "$$REPO_URL"
	@echo "New Git repository initialized and remote origin set to $$REPO_URL."

	# Replace vinnyrags/skeleton-crew in composer.json with the derived repository name
	@echo "Replacing vinnyrags/skeleton-crew in composer.json with the derived repository name..."
	REPO_NAME=$$(basename "$$REPO_URL" .git); \
	sed -i "s/vinnyrags\/skeleton-crew/vinnyrags\/$$REPO_NAME/g" composer.json
	@echo "Replacement complete."

	# Replace /ender-man/ in composer.json with the derived repository name
	@echo "Replacing /ender-man/ in composer.json with the derived repository name..."
	REPO_NAME=$$(basename "$$REPO_URL" .git); \
	sed -i "s/\/ender-man\//\/$$REPO_NAME\//g" composer.json
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
