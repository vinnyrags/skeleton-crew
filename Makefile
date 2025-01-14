setup:
	@{ \
		echo "Please enter the Git repository URL for your project:"; \
		read REPO_URL; \
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
		if [ -z "$$REPO_NAME" ]; then \
			echo "Error: Repository name could not be derived."; \
			exit 1; \
		fi; \
		echo "Cleaning up Git files from skeleton-crew..."; \
		rm -rf .git .github; \
		\
		echo "Initializing a new Git repository..."; \
		git init; \
		git remote add origin "$$REPO_URL"; \
		echo "Git repository configured with remote URL: $$REPO_URL"; \
		\
		echo "Replacing skeleton-crew with $$REPO_NAME in composer.json name..."; \
		if [ -f composer.json ]; then \
			sed -i '' "s/skeleton-crew/$$REPO_NAME/g" composer.json; \
			echo "Replacing /ender-man/ with /$$REPO_NAME/ in composer.json psr-4..."; \
			sed -i '' "s/\/ender-man\//\/$$REPO_NAME\//g" composer.json; \
		else \
			echo "Error: composer.json file does not exist."; \
			exit 1; \
		fi; \
		echo "Configuring DDEV for WordPress..."; \
		ddev config --project-type=wordpress; \
		echo "Starting DDEV environment..."; \
		ddev start; \
		echo "Installing Composer dependencies..."; \
		ddev composer install; \
		echo "Removing wp-config.php andfrom /wp/ directory..."
		if [ -f wp/wp-config.php ]; then \
			rm wp/wp-config.php; \
			echo "Removed wp-config.php from /wp/."; \
		else \
			echo "No wp-config.php found in /wp/, skipping."; \
		fi
		echo "Removing index.php from /wp/ directory..."
		if [ -f wp/index.php ]; then \
			rm wp/index.php; \
			echo "Removed index.php from /wp/."; \
		else \
			echo "No index.php found in /wp/, skipping."; \
		fi
		echo "Removing vinnyrags/ender-man from require-dev in composer.json..."; \
		sed -i '' '/"vinnyrags\/ender-man"/d' composer.json; \
		echo "Creating an initial Git commit with the message 'skeleton-crew setup'..." \
		git add . \
		git commit -m "skeleton-crew setup" \
		echo "Initial commit created." \
		echo "Pushing changes to the remote repository..." \
		git branch -M main \
		git push -u origin main \
		echo "Changes pushed to the remote repository." \
		echo "Setup complete! Your project is ready to use." \
		echo "Launching the DDEV project..."; \
		ddev launch; \
	}
