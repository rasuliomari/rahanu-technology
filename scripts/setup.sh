#!/bin/bash

# ============================================================
# RAHANU TECHNOLOGY
# Portable Environment Setup Script
# ============================================================

set -e

PROJECT_NAME="RAHANU TECHNOLOGY"

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ENV_FILE="$PROJECT_DIR/.env"

echo
echo "============================================================"
echo "              $PROJECT_NAME"
echo "              ENVIRONMENT SETUP"
echo "============================================================"
echo
echo "Project directory:"
echo "$PROJECT_DIR"
echo

# ------------------------------------------------------------
# COLORS
# ------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ------------------------------------------------------------
# HELPER FUNCTIONS
# ------------------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

error_exit() {
    echo
    echo -e "${RED}ERROR:${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}!${NC} $1"
}

info() {
    echo -e "${BLUE}→${NC} $1"
}

# ------------------------------------------------------------
# CHECK OPERATING SYSTEM
# ------------------------------------------------------------

echo "Checking operating system..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    success "Linux detected."
else
    warning "This setup script is currently designed primarily for Linux."
fi

# ------------------------------------------------------------
# CHECK JAVA
# ------------------------------------------------------------

echo
echo "Checking Java..."

if ! command_exists java; then
    error_exit "Java is not installed. Please install JDK 17 or newer."
fi

JAVA_VERSION=$(java -version 2>&1 | head -n 1)

echo "Java:"
echo "$JAVA_VERSION"

success "Java detected."

# ------------------------------------------------------------
# CHECK MAVEN
# ------------------------------------------------------------

echo
echo "Checking Maven..."

if ! command_exists mvn; then
    error_exit "Maven is not installed. Please install Maven 3.8+."
fi

MAVEN_VERSION=$(mvn -version | head -n 1)

echo "Maven:"
echo "$MAVEN_VERSION"

success "Maven detected."

# ------------------------------------------------------------
# CHECK POSTGRESQL CLIENT
# ------------------------------------------------------------

echo
echo "Checking PostgreSQL..."

if ! command_exists psql; then
    error_exit "PostgreSQL client (psql) is not installed."
fi

success "PostgreSQL client detected."

# ------------------------------------------------------------
# CHECK TOMCAT
# ------------------------------------------------------------

echo
echo "Checking Apache Tomcat..."

DEFAULT_TOMCAT="/opt/tomcat"

if [ -d "$DEFAULT_TOMCAT" ]; then
    TOMCAT_HOME="$DEFAULT_TOMCAT"
else
    echo "Tomcat was not found at:"
    echo "$DEFAULT_TOMCAT"
    echo
    read -rp "Enter your Tomcat installation path: " TOMCAT_HOME

    if [ ! -d "$TOMCAT_HOME" ]; then
        error_exit "Tomcat directory does not exist: $TOMCAT_HOME"
    fi
fi

if [ ! -f "$TOMCAT_HOME/bin/startup.sh" ]; then
    error_exit "Invalid Tomcat installation. startup.sh was not found."
fi

success "Tomcat detected at $TOMCAT_HOME."

# ------------------------------------------------------------
# DATABASE CONFIGURATION
# ------------------------------------------------------------

echo
echo "============================================================"
echo "              DATABASE CONFIGURATION"
echo "============================================================"
echo

read -rp "PostgreSQL host [localhost]: " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -rp "PostgreSQL port [5432]: " DB_PORT
DB_PORT=${DB_PORT:-5432}

read -rp "Database name [rahanu_technology]: " DB_NAME
DB_NAME=${DB_NAME:-rahanu_technology}

read -rp "Application database username [rahanu_admin]: " DB_USER
DB_USER=${DB_USER:-rahanu_admin}

read -rsp "Application database password: " DB_PASSWORD
echo

# ------------------------------------------------------------
# POSTGRESQL ADMIN
# ------------------------------------------------------------

echo
echo "The setup needs a PostgreSQL administrator account"
echo "to create the application database/user if necessary."
echo

read -rp "PostgreSQL administrator username [postgres]: " POSTGRES_ADMIN
POSTGRES_ADMIN=${POSTGRES_ADMIN:-postgres}

# ------------------------------------------------------------
# CREATE ENVIRONMENT FILE
# ------------------------------------------------------------

echo
info "Creating local environment configuration..."

cat > "$ENV_FILE" <<EOF
# RAHANU TECHNOLOGY LOCAL ENVIRONMENT
# DO NOT COMMIT THIS FILE TO GITHUB

RAHANU_DB_URL=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}
RAHANU_DB_HOST=${DB_HOST}
RAHANU_DB_PORT=${DB_PORT}
RAHANU_DB_NAME=${DB_NAME}
RAHANU_DB_USER=${DB_USER}
RAHANU_DB_PASSWORD=${DB_PASSWORD}

RAHANU_TOMCAT_HOME=${TOMCAT_HOME}
EOF

chmod 600 "$ENV_FILE"

success "Environment configuration created."

# ------------------------------------------------------------
# CREATE DATABASE AND USER
# ------------------------------------------------------------

echo
echo "============================================================"
echo "              DATABASE INITIALIZATION"
echo "============================================================"
echo

info "Checking PostgreSQL connection..."

if sudo -u "$POSTGRES_ADMIN" psql -d postgres -c "SELECT 1;" >/dev/null 2>&1; then

    success "PostgreSQL administrator connection successful."

    info "Checking application database..."

    DB_EXISTS=$(sudo -u "$POSTGRES_ADMIN" psql \
        -d postgres \
        -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME';")

    if [ "$DB_EXISTS" != "1" ]; then

        info "Creating database: $DB_NAME"

        sudo -u "$POSTGRES_ADMIN" createdb "$DB_NAME"

        success "Database created."

    else

        success "Database already exists."

    fi

    # --------------------------------------------------------
    # CREATE APPLICATION USER
    # --------------------------------------------------------

    info "Checking application database user..."

    USER_EXISTS=$(sudo -u "$POSTGRES_ADMIN" psql \
        -d postgres \
        -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER';")

    if [ "$USER_EXISTS" != "1" ]; then

        info "Creating database user: $DB_USER"

        sudo -u "$POSTGRES_ADMIN" psql \
            -d postgres \
            -c "CREATE USER \"$DB_USER\" WITH PASSWORD '$DB_PASSWORD';"

        success "Database user created."

    else

        info "Database user already exists."

        sudo -u "$POSTGRES_ADMIN" psql \
            -d postgres \
            -c "ALTER USER \"$DB_USER\" WITH PASSWORD '$DB_PASSWORD';" \
            >/dev/null

        success "Database user password updated."

    fi

    # --------------------------------------------------------
    # DATABASE OWNERSHIP
    # --------------------------------------------------------

    info "Setting database owner..."

    sudo -u "$POSTGRES_ADMIN" psql \
        -d postgres \
        -c "ALTER DATABASE \"$DB_NAME\" OWNER TO \"$DB_USER\";"

    success "Database owner configured."

else

    error_exit "Could not connect to PostgreSQL as $POSTGRES_ADMIN."
fi

# ------------------------------------------------------------
# APPLY DATABASE SCHEMA
# ------------------------------------------------------------

echo
info "Applying database schema..."

PGPASSWORD="$DB_PASSWORD" psql \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -f "$PROJECT_DIR/database/schema.sql"

success "Database schema applied."

# ------------------------------------------------------------
# APPLY SEED DATA
# ------------------------------------------------------------

echo
info "Loading initial application data..."

PGPASSWORD="$DB_PASSWORD" psql \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -f "$PROJECT_DIR/database/seed.sql"

success "Initial data loaded."

# ------------------------------------------------------------
# MAVEN BUILD
# ------------------------------------------------------------

echo
echo "============================================================"
echo "              BUILDING APPLICATION"
echo "============================================================"
echo

cd "$PROJECT_DIR"

info "Running Maven build..."

mvn clean package

success "Maven build completed."

# ------------------------------------------------------------
# DEPLOY WAR
# ------------------------------------------------------------

echo
echo "============================================================"
echo "              DEPLOYING APPLICATION"
echo "============================================================"
echo

WAR_FILE="$PROJECT_DIR/target/rahanu-technology.war"
TOMCAT_WEBAPPS="$TOMCAT_HOME/webapps"

if [ ! -f "$WAR_FILE" ]; then
    error_exit "WAR file was not created: $WAR_FILE"
fi

info "Stopping Tomcat if it is running..."

"$TOMCAT_HOME/bin/shutdown.sh" >/dev/null 2>&1 || true

sleep 3

info "Removing previous deployment..."

rm -rf "$TOMCAT_WEBAPPS/rahanu-technology"
rm -f "$TOMCAT_WEBAPPS/rahanu-technology.war"

info "Copying new WAR file..."

cp "$WAR_FILE" "$TOMCAT_WEBAPPS/"

success "WAR deployed."

# ------------------------------------------------------------
# TOMCAT ENVIRONMENT
# ------------------------------------------------------------

echo
info "Configuring Tomcat database environment..."

cat > "$TOMCAT_HOME/bin/setenv.sh" <<EOF
#!/bin/bash

export RAHANU_DB_URL="jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}"
export RAHANU_DB_HOST="${DB_HOST}"
export RAHANU_DB_PORT="${DB_PORT}"
export RAHANU_DB_NAME="${DB_NAME}"
export RAHANU_DB_USER="${DB_USER}"
export RAHANU_DB_PASSWORD="${DB_PASSWORD}"
EOF

chmod 700 "$TOMCAT_HOME/bin/setenv.sh"

success "Tomcat environment configured."

# ------------------------------------------------------------
# START TOMCAT
# ------------------------------------------------------------

echo
info "Starting Tomcat..."

"$TOMCAT_HOME/bin/startup.sh"

sleep 5

# ------------------------------------------------------------
# FINAL RESULT
# ------------------------------------------------------------

echo
echo "============================================================"
echo "              SETUP COMPLETED"
echo "============================================================"
echo

echo -e "${GREEN}RAHANU TECHNOLOGY has been configured successfully.${NC}"
echo

echo "Database:"
echo "  Host:     $DB_HOST"
echo "  Port:     $DB_PORT"
echo "  Database: $DB_NAME"
echo "  User:     $DB_USER"
echo

echo "Tomcat:"
echo "  Location: $TOMCAT_HOME"
echo

echo "Application:"
echo "  http://localhost:8080/rahanu-technology/"
echo

echo "Admin:"
echo "  http://localhost:8080/rahanu-technology/admin/login"
echo

echo "============================================================"
echo
