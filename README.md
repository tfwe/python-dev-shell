# PyPi Python Development Environment with Nix

This project uses a Nix flake to set up a consistent Python development environment. It provides a reproducible setup with Python 3.11 and other necessary tools.

## Prerequisites

- [Nix package manager](https://nixos.org/download.html) with flakes enabled
- Git (to clone the repository containing the flake)

## Getting Started

1. Ensure you have Nix installed with flakes enabled.

2. Create a `requirements.txt` file in the project root if you haven't already, listing your Python dependencies.

3a. To enter the development environment, run the following command in the same directory as your `requirements.txt` file:

   ```
   nix develop github:tfwe/python-dev-shell
   ```

   This command will:
   - Create a Python virtual environment specific to your project
   - Activate the virtual environment
   - Install dependencies from `requirements.txt` (if it exists)
   - Set up necessary environment variables

3b. Alternatively, clone the repository containing this README and the Nix flake configuration:

   ```
   git clone <repository-url>
   cd <repository-name>
   ```
   Then execute the flake to activate the venv, making sure `requirements.txt` is in the same directory.
   ```
   nix develop .
   ```
## Features

- Python 3.11
- Automatic virtual environment creation and activation
- Dependency installation from `requirements.txt` using wheel
- Fish shell with custom configuration
- Additional libraries: zlib, libGL, libGLU, and X11

## Usage

Once inside the development environment:

- Your Python virtual environment will be automatically activated.
- Dependencies from `requirements.txt` will be installed (if the file exists).
- You can start developing your Python project with all necessary tools and libraries available.
- Use `deactivate` to exit the Python virtual environment while remaining in the Nix shell.
- Exit the Fish shell to leave the Nix development environment completely.

## Customization

You can modify the `flake.nix` file to add or remove dependencies as needed for your project.

## Troubleshooting

If you encounter any issues:
- Ensure Nix is properly installed with flakes support enabled.
- Check that you're running the `nix develop` command in the correct directory.
- Verify that your `requirements.txt` file is properly formatted if you're having issues with dependency installation.

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or encounter any problems.

