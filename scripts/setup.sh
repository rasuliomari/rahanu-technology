#!/bin/bash

set -e

# ============================================================
# RAHANU TECHNOLOGY
# Complete Build and Deployment Script
# ============================================================

APP_NAME="${RAHANU_APP_NAME:-rahanu-technology}"

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

DB_NAME="${RAHANU_DB_NAME:-rahanu_technology}"
DB_USER="${RAHANU_DB_USER:-rahanu_admin}"
DB_PASSWORD="${RAHANU_DB_PASSWORD:-ChangeThisPassword123!}"
DB_URL="${RAHANU_DB_URL:-jdbc:postgresql://localhost:5432/rahanu_technology}"

TOMCAT_HOME="${TOMCAT_HOME:-/opt/tomcat}"

UPLOAD_DIR="${RAHANU_TEAM_UPLOAD_DIR:-/opt/rahanu-technology-data/team}"

WAR_FILE="$PROJECT_DIR/target/$APP_NAME.war"

DEPLOY_DIR="$TOMCAT_HOME/webapps/$APP_NAME"

TOMCAT_ENV_FILE="$TOMCAT_HOME/bin/setenv.sh"

# ============================================================
# FUNCTIONS
# ============================================================

print_header() {

    echo
    echo "============================================================"
    echo "              RAHANU TECHNOLOGY"
    echo "              BUILD AND DEPLOYMENT"
    echo "============================================================"
    echo
}

error_exit() {

    echo
    echo "============================================================"
    echo "ERROR"
    echo "============================================================"
    echo
    echo "$1"
    echo
    exit 1
}

check_command() {

    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        error_exit "$command_name is not installed or not available in PATH."
    fi
}

check_not_empty() {

    local variable_name="$1"
    local variable_value="$2"

    if [ -z "$variable_value" ]; then
        error_exit "$variable_name cannot be empty."
    fi
}

# ============================================================
# START
# ============================================================

print_header

echo "Project directory:"
echo "$PROJECT_DIR"
echo

# ============================================================
# PHASE 1 - VALIDATION
# ============================================================

echo "============================================================"
echo " PHASE 1: VALIDATION"
echo "============================================================"
echo

echo "[1/10] Checking project..."

[ -d "$PROJECT_DIR" ] ||
error_exit "Project directory does not exist."

[ -f "$PROJECT_DIR/pom.xml" ] ||
error_exit "pom.xml not found."

[ -f "$PROJECT_DIR/database/schema.sql" ] ||
error_exit "database/schema.sql not found."

echo "       OK"


echo "[2/10] Checking configuration..."

check_not_empty "APP_NAME" "$APP_NAME"
check_not_empty "DB_NAME" "$DB_NAME"
check_not_empty "DB_USER" "$DB_USER"
check_not_empty "DB_PASSWORD" "$DB_PASSWORD"
check_not_empty "DB_URL" "$DB_URL"
check_not_empty "TOMCAT_HOME" "$TOMCAT_HOME"
check_not_empty "UPLOAD_DIR" "$UPLOAD_DIR"

echo "       Database : $DB_NAME"
echo "       DB User  : $DB_USER"
echo "       DB URL   : $DB_URL"
echo "       OK"


echo "[3/10] Checking Java..."

check_command java

java -version

echo "       OK"


echo "[4/10] Checking Maven..."

check_command mvn

mvn -version

echo "       OK"


echo "[5/10] Checking PostgreSQL..."

check_command psql

if ! sudo systemctl is-active --quiet postgresql; then

    echo "       PostgreSQL is not running."
    echo "       Starting PostgreSQL..."

    sudo systemctl start postgresql

    sleep 3

fi

if ! sudo systemctl is-active --quiet postgresql; then
    error_exit "PostgreSQL could not be started."
fi

echo "       OK"


echo "[6/10] Checking PostgreSQL administrator..."

if ! sudo -u postgres psql -c "SELECT version();" >/dev/null 2>&1; then
    error_exit "Cannot access PostgreSQL administrator account."
fi

echo "       OK"


echo "[7/10] Checking Tomcat..."

[ -d "$TOMCAT_HOME" ] ||
error_exit "Tomcat directory does not exist: $TOMCAT_HOME"

[ -f "$TOMCAT_HOME/bin/startup.sh" ] ||
error_exit "Tomcat startup.sh not found."

[ -f "$TOMCAT_HOME/bin/shutdown.sh" ] ||
error_exit "Tomcat shutdown.sh not found."

[ -d "$TOMCAT_HOME/webapps" ] ||
error_exit "Tomcat webapps directory not found."

echo "       Tomcat: $TOMCAT_HOME"
echo "       OK"


echo "[8/10] Checking deployment path..."

if [ "$DEPLOY_DIR" = "/" ]; then
    error_exit "Unsafe deployment directory."
fi

if [ "$DEPLOY_DIR" = "$TOMCAT_HOME" ]; then
    error_exit "Unsafe deployment directory."
fi

if [ "$DEPLOY_DIR" = "$TOMCAT_HOME/webapps" ]; then
    error_exit "Unsafe deployment directory."
fi

EXPECTED_DEPLOY_DIR="$TOMCAT_HOME/webapps/$APP_NAME"

if [ "$DEPLOY_DIR" != "$EXPECTED_DEPLOY_DIR" ]; then
    error_exit "Deployment path safety check failed."
fi

echo "       Deploy: $DEPLOY_DIR"
echo "       OK"


echo "[9/10] Checking database files..."

[ -f "$PROJECT_DIR/database/schema.sql" ] ||
error_exit "schema.sql is missing."

echo "       schema.sql found."

if [ -f "$PROJECT_DIR/database/seed.sql" ]; then
    echo "       seed.sql found."
else
    echo "       WARNING: seed.sql not found."
fi

echo "       OK"


echo "[10/10] Checking Tomcat configuration..."

echo "       Environment file:"
echo "       $TOMCAT_ENV_FILE"

echo "       OK"


echo
echo "============================================================"
echo " CONFIGURATION SUMMARY"
echo "============================================================"
echo

echo "Application : $APP_NAME"
echo "Project     : $PROJECT_DIR"
echo "Database    : $DB_NAME"
echo "DB User     : $DB_USER"
echo "DB URL      : $DB_URL"
echo "Tomcat      : $TOMCAT_HOME"
echo "Uploads     : $UPLOAD_DIR"
echo "WAR         : $WAR_FILE"
echo "Deploy      : $DEPLOY_DIR"

echo

echo "============================================================"
echo " ALL VALIDATIONS PASSED"
echo "============================================================"
echo

read -r -p "Continue with deployment? [y/N]: " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then

    echo
    echo "Deployment cancelled."
    exit 0

fi

# ============================================================
# PHASE 2 - DATABASE
# ============================================================

echo
echo "============================================================"
echo " PHASE 2: DATABASE CONFIGURATION"
echo "============================================================"
echo


echo "[1/4] Creating/updating PostgreSQL user..."

ROLE_EXISTS="$(
    sudo -u postgres psql -tAc \
        "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" |
        tr -d '[:space:]'
)"

if [ "$ROLE_EXISTS" = "1" ]; then

    echo "       User already exists."

    sudo -u postgres psql \
        -v ON_ERROR_STOP=1 \
        -c "ALTER ROLE \"$DB_USER\" WITH LOGIN PASSWORD '$DB_PASSWORD';"

else

    echo "       Creating user..."

    sudo -u postgres psql \
        -v ON_ERROR_STOP=1 \
        -c "CREATE ROLE \"$DB_USER\" LOGIN PASSWORD '$DB_PASSWORD';"

fi

echo "       OK"


echo "[2/4] Creating database..."

DB_EXISTS="$(
    sudo -u postgres psql -tAc \
        "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" |
        tr -d '[:space:]'
)"

if [ "$DB_EXISTS" != "1" ]; then

    sudo -u postgres createdb \
        -O "$DB_USER" \
        "$DB_NAME"

    echo "       Database created."

else

    echo "       Database already exists."

fi

sudo -u postgres psql \
    -v ON_ERROR_STOP=1 \
    -c "ALTER DATABASE \"$DB_NAME\" OWNER TO \"$DB_USER\"" \
    >/dev/null

echo "       Database owner verified."
echo "       OK"


echo "[3/4] Installing database schema..."

PGPASSWORD="$DB_PASSWORD" \
psql \
    -h localhost \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -v ON_ERROR_STOP=1 \
    -f "$PROJECT_DIR/database/schema.sql"

echo "       Schema installed."


echo "[4/4] Installing seed data..."

if [ -f "$PROJECT_DIR/database/seed.sql" ]; then

    PGPASSWORD="$DB_PASSWORD" \
    psql \
        -h localhost \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -v ON_ERROR_STOP=1 \
        -f "$PROJECT_DIR/database/seed.sql"

    echo "       Seed data installed."

else

    echo "       WARNING: seed.sql not found."
    echo "       Skipping seed data."

fi

echo "       OK"

echo
echo "       DATABASE CONFIGURATION COMPLETE"

# ============================================================
# PHASE 3 - PERSISTENT STORAGE
# ============================================================

echo
echo "============================================================"
echo " PHASE 3: PERSISTENT STORAGE"
echo "============================================================"
echo


echo "[1/2] Creating upload directory..."

sudo mkdir -p "$UPLOAD_DIR"

echo "       $UPLOAD_DIR"


echo "[2/2] Setting permissions..."

CURRENT_USER="$(whoami)"
CURRENT_GROUP="$(id -gn)"

sudo chown -R "$CURRENT_USER:$CURRENT_GROUP" "$UPLOAD_DIR"

sudo chmod 755 "$UPLOAD_DIR"

echo "       Owner: $CURRENT_USER:$CURRENT_GROUP"
echo "       Permissions: 755"

echo
echo "       STORAGE CONFIGURATION COMPLETE"

# ============================================================
# PHASE 4 - TOMCAT ENVIRONMENT
# ============================================================

echo
echo "============================================================"
echo " PHASE 4: TOMCAT ENVIRONMENT"
echo "============================================================"
echo


echo "[1/2] Creating Tomcat environment configuration..."

sudo tee "$TOMCAT_ENV_FILE" >/dev/null <<EOF
#!/bin/sh

export RAHANU_APP_NAME="$APP_NAME"

export RAHANU_DB_NAME="$DB_NAME"
export RAHANU_DB_USER="$DB_USER"
export RAHANU_DB_PASSWORD="$DB_PASSWORD"
export RAHANU_DB_URL="$DB_URL"

export RAHANU_TEAM_UPLOAD_DIR="$UPLOAD_DIR"
EOF

echo "       Environment configuration written."


echo "[2/2] Setting permissions..."

sudo chmod 750 "$TOMCAT_ENV_FILE"

echo "       OK"

echo
echo "       TOMCAT ENVIRONMENT CONFIGURATION COMPLETE"

# ============================================================
# PHASE 5 - MAVEN BUILD
# ============================================================

echo
echo "============================================================"
echo " PHASE 5: MAVEN BUILD"
echo "============================================================"
echo

cd "$PROJECT_DIR"


echo "[1/2] Downloading Maven dependencies..."

mvn dependency:go-offline

echo "       Dependencies ready."


echo "[2/2] Building WAR..."

mvn clean package

[ -f "$WAR_FILE" ] ||
error_exit "WAR file was not created."

echo
echo "       WAR CREATED:"
echo "       $WAR_FILE"

echo
echo "       MAVEN BUILD COMPLETE"

# ============================================================
# PHASE 6 - TOMCAT DEPLOYMENT
# ============================================================

echo
echo "============================================================"
echo " PHASE 6: TOMCAT DEPLOYMENT"
echo "============================================================"
echo


echo "[1/4] Stopping Tomcat..."

"$TOMCAT_HOME/bin/shutdown.sh" \
    >/dev/null 2>&1 || true

sleep 5

echo "       OK"


echo "[2/4] Removing previous deployment..."

rm -rf "$DEPLOY_DIR"

rm -f "$TOMCAT_HOME/webapps/$APP_NAME.war"

echo "       OK"


echo "[3/4] Copying WAR..."

cp "$WAR_FILE" \
    "$TOMCAT_HOME/webapps/$APP_NAME.war"

echo "       WAR deployed."


echo "[4/4] Starting Tomcat..."

"$TOMCAT_HOME/bin/startup.sh"

echo "       Waiting for Tomcat..."

sleep 10

echo "       Tomcat started."

# ============================================================
# PHASE 7 - FINAL CHECK
# ============================================================

echo
echo "============================================================"
echo " PHASE 7: DEPLOYMENT CHECK"
echo "============================================================"
echo


echo "[1/5] Checking deployed WAR..."

if [ -f "$TOMCAT_HOME/webapps/$APP_NAME.war" ]; then

    echo "       WAR exists."

else

    error_exit "WAR is missing from Tomcat webapps."

fi


echo "[2/5] Checking application directory..."

if [ -d "$DEPLOY_DIR" ]; then

    echo "       Application directory exists."

else

    echo "       WARNING: Application directory not created yet."
    echo "       Tomcat may still be deploying the application."

fi


echo "[3/5] Checking persistent storage..."

if [ -d "$UPLOAD_DIR" ]; then

    echo "       Upload directory exists."

else

    error_exit "Persistent upload directory does not exist."

fi


echo "[4/5] Checking Tomcat process..."

if pgrep -f "$TOMCAT_HOME" >/dev/null 2>&1; then

    echo "       Tomcat process is running."

else

    echo "       WARNING: Tomcat process was not detected."

fi


echo "[5/5] Checking HTTP application response..."

HTTP_CODE="$(
    curl \
        -s \
        -o /dev/null \
        -w "%{http_code}" \
        --max-time 15 \
        "http://localhost:8080/$APP_NAME/" \
        || true
)"

if [ "$HTTP_CODE" = "200" ]; then

    echo "       HTTP status: 200"
    echo "       Application is responding."

elif [ "$HTTP_CODE" = "302" ] || [ "$HTTP_CODE" = "301" ]; then

    echo "       HTTP status: $HTTP_CODE"
    echo "       Application is responding with a redirect."

elif [ "$HTTP_CODE" = "404" ]; then

    echo "       HTTP status: 404"
    echo "       WARNING: Application context may still be deploying."

else

    echo "       HTTP status: ${HTTP_CODE:-NO_RESPONSE}"
    echo "       WARNING: Application response could not be confirmed."

fi

# ============================================================
# COMPLETE
# ============================================================

echo
echo "============================================================"
echo "        RAHANU TECHNOLOGY DEPLOYMENT COMPLETE"
echo "============================================================"
echo

echo "Website:"
echo "http://localhost:8080/$APP_NAME/"

echo
echo "Home:"
echo "http://localhost:8080/$APP_NAME/index.jsp"

echo
echo "Services:"
echo "http://localhost:8080/$APP_NAME/services"

echo
echo "Projects:"
echo "http://localhost:8080/$APP_NAME/projects"

echo
echo "Team:"
echo "http://localhost:8080/$APP_NAME/team"

echo
echo "Contact:"
echo "http://localhost:8080/$APP_NAME/contact.jsp"

echo
echo "Admin:"
echo "http://localhost:8080/$APP_NAME/admin/login"

echo
echo "Database:"
echo "$DB_NAME"

echo
echo "Persistent uploads:"
echo "$UPLOAD_DIR"

echo
echo "WAR:"
echo "$WAR_FILE"

echo
echo "============================================================"
echo "                    RAHANU TECHNOLOGY"
echo "                         READY"
echo "============================================================"
echo
