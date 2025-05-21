@echo off
SETLOCAL ENABLEEXTENSIONS

ECHO Checking for uv...
uv --version >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO uv is not installed or not in PATH. Please install it from https://docs.astral.sh/uv/getting-started/installation/ and re-run this script.
    GOTO EOF
)

ECHO Installing Python dependencies using uv...
uv sync
IF ERRORLEVEL 1 (
    ECHO uv sync failed. Please check for errors.
    GOTO EOF
)

ECHO Copying .env.example to .env...
copy .env.example .env
ECHO Copying conf.yaml.example to conf.yaml...
copy conf.yaml.example conf.yaml

ECHO Checking for pnpm...
pnpm --version >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO pnpm is not installed or not in PATH. Please install it from https://pnpm.io/installation/ and re-run this script.
    GOTO EOF
)

ECHO Navigating to web directory...
cd web
IF ERRORLEVEL 1 (
    ECHO Failed to navigate to web directory. Ensure it exists in the current path.
    GOTO EOF
)

ECHO Installing web UI dependencies using pnpm...
pnpm install
IF ERRORLEVEL 1 (
    ECHO pnpm install failed. Please check for errors.
    cd ..
    GOTO EOF
)

ECHO Navigating back to root directory...
cd ..
IF ERRORLEVEL 1 (
    ECHO Failed to navigate back to root directory.
    GOTO EOF
)

ECHO.
ECHO --- Marp CLI Installation ---
ECHO This project uses marp-cli for PPT generation.

npm --version >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO npm (Node Package Manager) is not detected. marp-cli is typically installed using npm.
    ECHO Please install Node.js (which includes npm) from https://nodejs.org/.
    ECHO After installing Node.js, you can install marp-cli globally by running this command in your terminal:
    ECHO   npm install -g @marp-team/marp-cli
) ELSE (
    ECHO npm detected. You can install marp-cli globally by running the following command in your terminal:
    ECHO   npm install -g @marp-team/marp-cli
)
ECHO Alternatively, refer to marp-cli installation options at https://github.com/marp-team/marp-cli#install
ECHO.

ECHO --- Configuration Required ---
ECHO Installation steps complete!
ECHO IMPORTANT: Please configure your API keys and other settings in the following files:
ECHO   - .env
ECHO   - conf.yaml
ECHO Refer to the README.md and docs/configuration_guide.md for details.
ECHO.
ECHO Once configured, you can start the application using:
ECHO   bootstrap.bat
ECHO Or for development mode:
ECHO   bootstrap.bat -d
ECHO.

:EOF
ENDLOCAL
