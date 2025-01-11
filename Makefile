# Default command
default: setup

# Setup project using DDEV
setup:
	@echo "Configuring DDEV for a WordPress project..."
	ddev config --project-type=wordpress
	@echo "Starting DDEV..."
	ddev start
	@echo "Downloading WordPress core files..."
	ddev wp core download
	@echo "Launching the project in your browser..."
	ddev launch
	@echo "Installing composer dependencies..."
	ddev composer install

