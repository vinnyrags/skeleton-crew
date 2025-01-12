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

### 2. **index.php**

The main entry point for the WordPress site. This file loads the WordPress environment and handles all incoming requests.

### 3. **Makefile**

Automates project setup tasks. Key steps include:

- Cloning the Skeleton Crew repository into a temporary directory.
- Copying files to the current project directory, excluding `.git` and `.github`.
- Verifying the Git repository context.
- Replacing placeholder values in `composer.json` with the project directory name.
- Configuring DDEV for local development.
- Starting the DDEV environment and launching the project.

#### Example Usage:
To set up your project, run:

```sh
make setup
```

### 4. **wp-config.php**

Contains the WordPress configuration settings:

- Database connection details (managed by DDEV during runtime).
- Custom `WP_CONTENT_DIR` and `WP_CONTENT_URL` settings to allow flexibility in organizing content.
- Composer autoloader integration.
- Reference to DDEV-generated settings (`wp/wp-config-ddev.php`).

---

## Setup Instructions

1. **Clone this repository:**

```sh
git clone https://github.com/vinnyrags/skeleton-crew.git
```

2. **Navigate to your project directory:**

```sh
cd skeleton-crew
```

3. **Run the setup script:**

```sh
make setup
```

This will:
- Replace placeholder values in `composer.json`.
- Remove unnecessary files from the `/wp/` directory.
- Configure and start DDEV.
- Install Composer dependencies.

4. **Access your project:**

After setup, launch your project in the browser:

```sh
ddev launch
```

---

## Local Development with DDEV

This project is fully compatible with DDEV for local WordPress development. Ensure you have [DDEV installed](https://ddev.readthedocs.io/en/latest/#installation) before running the setup.

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

