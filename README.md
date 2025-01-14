# Skeleton Crew

Skeleton Crew is a WordPress project starter template designed to streamline the setup and management of WordPress projects with Composer and DDEV. This repository includes key files and configurations to help developers quickly set up and customize their WordPress environment.

## Features

- **Composer Integration**: Manage WordPress core, plugins, and themes as Composer dependencies.
- **DDEV Compatibility**: Simplify local development with DDEV configuration.
- **Customizable Structure**: Easily adapt the project structure to your needs.
- **Pre-configured Makefile**: Automate setup tasks, including dependency installation and environment configuration.

---

## File Structure

### 1. **composer.json**

This file manages the dependencies for your WordPress project. It includes:

- **WordPress Core**: Pulled in via `johnpbloch/wordpress`.
- **Custom Installer**: Uses `roots/wordpress-core-installer` to specify the WordPress install directory (`wp`).

Additionally, the `composer.json` file is dynamically updated during setup to replace placeholder names (`vinnyrags/skeleton-crew`) with your project-specific names.

#### Key Features:
- Dependency management
- Autoloader configuration (`App\` namespace maps to `src/`)
- Plugin management via `allow-plugins`

### 2. **Makefile**

Automates project setup tasks. Key steps include:

- Verifying the Git repository context (ensuring it belongs to the `vinnyrags` namespace).
- Dynamically deriving the repository name from the provided URL.
- Replacing placeholder values in `composer.json` with the project directory name.
- Configuring DDEV for local development.
- Starting the DDEV environment and launching the project.

#### Example Usage:
To set up your project, run:

```sh
make setup
```

> **Warning:** If the remote repository is not empty, the script will perform a force push to overwrite its history. Ensure you have a backup of any critical data before running the script.

> **Tip:** If you need to restart the setup process, ensure you clean up previous remnants:
> ```sh
> rm -rf .git .github
> ```

### 3. **wp-config.php**

Contains the WordPress configuration settings:

- Database connection details (managed by DDEV during runtime).
- Custom `WP_CONTENT_DIR` and `WP_CONTENT_URL` settings to allow flexibility in organizing content.
- Composer autoloader integration.
- Reference to DDEV-generated settings (`wp/wp-config-ddev.php`).

---

## Setup Instructions

1. **Clone this repository:**

```sh
git clone https://github.com/vinnyrags/skeleton-crew.git <project-name>
```

2. **Navigate to your project directory:**

```sh
cd <project-name>
```

3. **Run the setup script:**

```sh
make setup
```

This will:
- Validate the Git repository URL (must include `vinnyrags` in the namespace).
- Dynamically derive the repository name from the provided URL.
- Replace placeholder values in `composer.json` with the repository name.
- Remove unnecessary files from the `/wp/` directory.
- Configure and start DDEV for local development.
- Install Composer dependencies.
- Push initial project setup to the remote repository.

4. **Access your project:**

After setup, launch your project in the browser:

```sh
ddev launch
```

---

## Local Development with DDEV

This project is fully compatible with DDEV for local WordPress development. After running `make setup`, the DDEV environment will be fully configured, including:

- Project type set to `wordpress`.
- Necessary WordPress dependencies installed via Composer.
- Placeholder configuration files removed from the `/wp/` directory.

Ensure you have [DDEV installed](https://ddev.readthedocs.io/en/latest/#installation) before running the setup.

---

## Contributing

If you have improvements or suggestions, feel free to fork this repository, make changes, and submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Inspired by modern WordPress development practices.
- Uses components from [johnpbloch/wordpress](https://github.com/johnpbloch/wordpress) and [roots/wordpress-core-installer](https://github.com/roots/wordpress-core-installer).

---

Happy coding!

