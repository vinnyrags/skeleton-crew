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
		echo "Launching the DDEV project..."; \
		ddev launch; \
	}
