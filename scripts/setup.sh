#!/bin/bash

set -e

# ============================================================
# RAHANU TECHNOLOGY
# Safe Build and Deployment Script
# Ubuntu + Tomcat 10
#
# IMPORTANT:
# - RAHANU is deployed as the Tomcat ROOT application.
# - Public URL: https://rahanu.rasuliomari.tech/
# - This script DOES NOT install schema.sql or seed.sql.
# - Existing PostgreSQL data is preserved.
# - Online Quiz System is NOT modified.
# ============================================================

APP_NAME="${RAHANU_APP_NAME:-rahanu-technology}"

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

DB_NAME="${RAHANU_DB_NAME:-rahanu_technology}"
DB_USER="${RAHANU_DB_USER:-rahanu_admin}"
DB_URL="${RAHANU_DB_URL:-jdbc:postgresql://localhost:5432/rahanu_technology}"

UPLOAD_DIR="${RAHANU_TEAM_UPLOAD_DIR:-/opt/rahanu-technology-data/team}"

# Ubuntu packaged Tomcat 10
TOMCAT_HOME="${TOMCAT_HOME:-/usr/share/tomcat10}"
TOMCAT_BASE="${TOMCAT_BASE:-/var/lib/tomcat10}"
TOMCAT_SERVICE="${TOMCAT_SERVICE:-tomcat10}"

WEBAPPS_DIR="$TOMCAT_BASE/webapps"

# Maven creates the WAR using the application name.
WAR_FILE="$PROJECT_DIR/target/$APP_NAME.war"

# Production deployment is Tomcat ROOT.
ROOT_WAR_FILE="$WEBAPPS_DIR/ROOT.war"
DEPLOY_DIR="$WEBAPPS_DIR/ROOT"

# Old context deployment names.
OLD_WAR_FILE="$WEBAPPS_DIR/$APP_NAME.war"
OLD_DEPLOY_DIR="$WEBAPPS_DIR/$APP_NAME"

ENV_FILE="/etc/rahanu-technology/rahanu.env"

SYSTEMD_DROPIN="/etc/systemd/system/tomcat10.service.d/rahanu-technology.conf"

# ============================================================
# FUNCTIONS
# ============================================================

print_header() {

    echo
    echo "============================================================"
    echo "              RAHANU TECHNOLOGY"
    echo "              SAFE BUILD AND DEPLOYMENT"
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
        error_exit "$command_name is not installed."
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

echo "[1/12] Checking project..."

[ -d "$PROJECT_DIR" ] ||
error_exit "Project directory does not exist."

[ -f "$PROJECT_DIR/pom.xml" ] ||
error_exit "pom.xml not found."

echo "       OK"


echo "[2/12] Checking application..."

check_not_empty "APP_NAME" "$APP_NAME"

echo "       Application : $APP_NAME"
echo "       Deploy as   : ROOT"
echo "       OK"


echo "[3/12] Checking Java..."

check_command java

java -version

echo "       OK"


echo "[4/12] Checking Maven..."

check_command mvn

mvn -version

echo "       OK"


echo "[5/12] Checking PostgreSQL..."

check_command psql

if ! systemctl is-active --quiet postgresql; then

    echo "       PostgreSQL is not running."
    echo "       Starting PostgreSQL..."

    systemctl start postgresql

    sleep 3

fi

if ! systemctl is-active --quiet postgresql; then

    error_exit "PostgreSQL could not be started."

fi

echo "       OK"


echo "[6/12] Checking PostgreSQL administrator..."

if ! sudo -u postgres psql -c "SELECT version();" >/dev/null 2>&1; then

    error_exit "Cannot access PostgreSQL administrator account."

fi

echo "       OK"


echo "[7/12] Checking database..."

if ! sudo -u postgres psql \
    -d "$DB_NAME" \
    -c "SELECT current_database();" >/dev/null 2>&1; then

    error_exit "Database '$DB_NAME' does not exist."

fi

echo "       Database exists: $DB_NAME"
echo "       Existing database will NOT be recreated."
echo "       OK"


echo "[8/12] Checking Tomcat..."

[ -d "$TOMCAT_HOME" ] ||
error_exit "Tomcat home does not exist: $TOMCAT_HOME"

[ -d "$TOMCAT_BASE" ] ||
error_exit "Tomcat base does not exist: $TOMCAT_BASE"

[ -d "$WEBAPPS_DIR" ] ||
error_exit "Tomcat webapps directory does not exist: $WEBAPPS_DIR"

echo "       Tomcat Home : $TOMCAT_HOME"
echo "       Tomcat Base : $TOMCAT_BASE"
echo "       Webapps     : $WEBAPPS_DIR"
echo "       Service     : $TOMCAT_SERVICE"
echo "       Deploy      : $ROOT_WAR_FILE"
echo "       OK"


echo "[9/12] Checking Tomcat service..."

if ! systemctl list-unit-files | grep -q "^${TOMCAT_SERVICE}.service"; then

    error_exit "Tomcat service '$TOMCAT_SERVICE' was not found."

fi

echo "       OK"


echo "[10/12] Checking persistent storage..."

mkdir -p "$UPLOAD_DIR"

echo "       Upload directory: $UPLOAD_DIR"
echo "       OK"


echo "[11/12] Checking environment configuration..."

if [ ! -f "$ENV_FILE" ]; then

    error_exit \
        "Environment file does not exist: $ENV_FILE"

fi

chmod 600 "$ENV_FILE"

echo "       Environment file exists."
echo "       OK"


echo "[12/12] Checking database tables..."

TABLE_COUNT="$(
    sudo -u postgres psql \
        -d "$DB_NAME" \
        -tAc \
        "SELECT count(*) FROM information_schema.tables
         WHERE table_schema='public';" |
        tr -d '[:space:]'
)"

echo "       Public tables: $TABLE_COUNT"

if [ "$TABLE_COUNT" = "0" ]; then

    echo
    echo "       WARNING:"
    echo "       The database contains no public tables."
    echo
    echo "       This deployment script will NOT install schema.sql."
    echo "       Initialize the database separately if this is a"
    echo "       brand-new installation."
    echo

else

    echo "       Existing database detected."

fi

echo
echo "============================================================"
echo " CONFIGURATION SUMMARY"
echo "============================================================"
echo

echo "Application       : $APP_NAME"
echo "Project           : $PROJECT_DIR"
echo "Database          : $DB_NAME"
echo "DB User           : $DB_USER"
echo "DB URL            : $DB_URL"
echo "Tomcat Home       : $TOMCAT_HOME"
echo "Tomcat Base       : $TOMCAT_BASE"
echo "Webapps           : $WEBAPPS_DIR"
echo "Uploads           : $UPLOAD_DIR"
echo "Maven WAR         : $WAR_FILE"
echo "ROOT WAR          : $ROOT_WAR_FILE"
echo "ROOT Directory    : $DEPLOY_DIR"

echo
echo "IMPORTANT:"
echo "This deployment will NOT modify database tables or data."
echo "schema.sql will NOT be executed."
echo "seed.sql will NOT be executed."
echo "Online Quiz System will NOT be modified."
echo "RAHANU will be deployed as Tomcat ROOT."
echo

read -r -p "Continue with deployment? [y/N]: " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then

    echo
    echo "Deployment cancelled."
    exit 0

fi


# ============================================================
# PHASE 2 - DATABASE VERIFICATION
# ============================================================

echo
echo "============================================================"
echo " PHASE 2: DATABASE VERIFICATION"
echo "============================================================"
echo

echo "[1/3] Checking database connection..."

if ! sudo -u postgres psql \
    -d "$DB_NAME" \
    -c "SELECT current_database(), current_user;" \
    >/dev/null 2>&1; then

    error_exit "Cannot connect to database."

fi

echo "       OK"


echo "[2/3] Checking database tables..."

sudo -u postgres psql \
    -d "$DB_NAME" \
    -c "\dt"

echo "       OK"


echo "[3/3] Database protection..."

echo "       schema.sql will NOT be executed."
echo "       seed.sql will NOT be executed."
echo "       Existing data will be preserved."

echo
echo "       DATABASE VERIFICATION COMPLETE"


# ============================================================
# PHASE 3 - PERSISTENT STORAGE
# ============================================================

echo
echo "============================================================"
echo " PHASE 3: PERSISTENT STORAGE"
echo "============================================================"
echo

echo "[1/3] Creating upload directory..."

mkdir -p "$UPLOAD_DIR"

echo "       $UPLOAD_DIR"


echo "[2/3] Checking Tomcat user..."

if id tomcat >/dev/null 2>&1; then

    echo "       Tomcat user exists."

else

    error_exit "System user 'tomcat' does not exist."

fi


echo "[3/3] Setting upload permissions..."

chown -R tomcat:tomcat "$UPLOAD_DIR"

chmod 755 "$UPLOAD_DIR"

echo "       Owner: tomcat:tomcat"
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

echo "[1/3] Checking environment file..."

if [ ! -f "$ENV_FILE" ]; then

    error_exit "Missing environment file: $ENV_FILE"

fi

chmod 600 "$ENV_FILE"

echo "       Environment file protected."


echo "[2/3] Checking systemd configuration..."

mkdir -p "$(dirname "$SYSTEMD_DROPIN")"

cat > "$SYSTEMD_DROPIN" <<EOF
[Service]
EnvironmentFile=$ENV_FILE
EOF

chmod 644 "$SYSTEMD_DROPIN"

echo "       Systemd drop-in configured."


echo "[3/3] Reloading systemd..."

systemctl daemon-reload

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
echo " PHASE 6: TOMCAT ROOT DEPLOYMENT"
echo "============================================================"
echo

echo "[1/7] Checking current Tomcat status..."

systemctl status "$TOMCAT_SERVICE" --no-pager \
    -l || true

echo


echo "[2/7] Stopping Tomcat service..."

systemctl stop "$TOMCAT_SERVICE"

sleep 5

echo "       Tomcat stopped."


echo "[3/7] Checking deployment directories..."

if [ "$DEPLOY_DIR" = "/" ] ||
   [ "$DEPLOY_DIR" = "$WEBAPPS_DIR" ] ||
   [ "$DEPLOY_DIR" = "$TOMCAT_BASE" ]; then

    error_exit "Unsafe deployment directory."

fi

if [ "$ROOT_WAR_FILE" = "/" ] ||
   [ "$ROOT_WAR_FILE" = "$WEBAPPS_DIR" ]; then

    error_exit "Unsafe ROOT WAR path."

fi

echo "       Deployment path is safe."


echo "[4/7] Removing previous RAHANU deployment..."

# Remove the current ROOT application.
rm -rf "$DEPLOY_DIR"

# Remove the current ROOT WAR.
rm -f "$ROOT_WAR_FILE"

# Remove any old RAHANU context deployment.
# This is intentionally limited to RAHANU.
rm -rf "$OLD_DEPLOY_DIR"
rm -f "$OLD_WAR_FILE"

echo "       Previous RAHANU deployment removed."

echo "       Online Quiz System was NOT touched."
echo "       Database was NOT touched."


echo "[5/7] Installing RAHANU as ROOT.war..."

install \
    -o tomcat \
    -g tomcat \
    -m 0644 \
    "$WAR_FILE" \
    "$ROOT_WAR_FILE"

echo "       ROOT WAR installed:"
echo "       $ROOT_WAR_FILE"


echo "[6/7] Starting Tomcat..."

systemctl start "$TOMCAT_SERVICE"

echo "       Waiting for Tomcat deployment..."

sleep 10


echo "[7/7] Checking Tomcat service..."

if ! systemctl is-active --quiet "$TOMCAT_SERVICE"; then

    echo
    echo "Tomcat failed to start."
    echo
    echo "Recent Tomcat log:"
    journalctl -u "$TOMCAT_SERVICE" \
        -n 80 \
        --no-pager

    error_exit "Tomcat service is not running."

fi

echo "       Tomcat is running."

echo
echo "       TOMCAT ROOT DEPLOYMENT COMPLETE"


# ============================================================
# PHASE 7 - DEPLOYMENT CHECK
# ============================================================

echo
echo "============================================================"
echo " PHASE 7: DEPLOYMENT CHECK"
echo "============================================================"
echo

echo "[1/7] Checking ROOT WAR..."

if [ -f "$ROOT_WAR_FILE" ]; then

    echo "       ROOT.war exists."

else

    error_exit "ROOT.war is missing from Tomcat webapps."

fi


echo "[2/7] Checking ROOT application directory..."

sleep 5

if [ -d "$DEPLOY_DIR" ]; then

    echo "       ROOT application directory exists."

else

    echo "       WARNING: ROOT directory not created yet."
    echo "       Tomcat may still be deploying."

fi


echo "[3/7] Checking old RAHANU context..."

if [ ! -f "$OLD_WAR_FILE" ] &&
   [ ! -d "$OLD_DEPLOY_DIR" ]; then

    echo "       Old /$APP_NAME deployment is removed."

else

    echo "       WARNING: Old RAHANU context still exists."

fi


echo "[4/7] Checking Online Quiz System..."

if [ -f "$WEBAPPS_DIR/online-quiz-system.war" ] ||
   [ -d "$WEBAPPS_DIR/online-quiz-system" ]; then

    echo "       Online Quiz System is present."
    echo "       It was NOT modified."

else

    echo "       WARNING: Online Quiz System was not found."

fi


echo "[5/7] Checking Tomcat service..."

if systemctl is-active --quiet "$TOMCAT_SERVICE"; then

    echo "       Tomcat service is active."

else

    error_exit "Tomcat service is not active."

fi


echo "[6/7] Checking persistent storage..."

if [ -d "$UPLOAD_DIR" ]; then

    echo "       Upload directory exists."

else

    error_exit "Persistent upload directory does not exist."

fi


echo "[7/7] Checking ROOT HTTP response..."

HTTP_CODE="$(
    curl \
        -s \
        -o /dev/null \
        -w "%{http_code}" \
        --max-time 20 \
        "http://127.0.0.1:8080/" \
        || true
)"

echo "       HTTP status: ${HTTP_CODE:-NO_RESPONSE}"

case "$HTTP_CODE" in

    200)
        echo "       RAHANU ROOT application is responding."
        ;;

    301|302|303|307|308)
        echo "       RAHANU application is responding with redirect."
        ;;

    404)
        echo "       Application returned HTTP 404."
        echo "       Check Tomcat deployment logs."
        ;;

    500)
        echo "       Application returned HTTP 500."
        echo "       Check Tomcat logs."
        ;;

    *)
        echo "       Application response could not be confirmed."
        ;;

esac


echo
echo "============================================================"
echo " RECENT TOMCAT LOG"
echo "============================================================"
echo

journalctl \
    -u "$TOMCAT_SERVICE" \
    -n 30 \
    --no-pager

echo

echo "       FINAL DEPLOYMENT CHECK COMPLETE"


# ============================================================
# COMPLETE
# ============================================================

echo
echo "============================================================"
echo "        RAHANU TECHNOLOGY DEPLOYMENT COMPLETE"
echo "============================================================"
echo

echo "Production website:"
echo "https://rahanu.rasuliomari.tech/"

echo
echo "Local Tomcat:"
echo "http://127.0.0.1:8080/"

echo
echo "Home:"
echo "https://rahanu.rasuliomari.tech/"

echo
echo "Services:"
echo "https://rahanu.rasuliomari.tech/services"

echo
echo "Projects:"
echo "https://rahanu.rasuliomari.tech/projects"

echo
echo "Team:"
echo "https://rahanu.rasuliomari.tech/team"

echo
echo "Contact:"
echo "https://rahanu.rasuliomari.tech/contact.jsp"

echo
echo "Admin:"
echo "https://rahanu.rasuliomari.tech/admin/login"

echo
echo "Database:"
echo "$DB_NAME"

echo
echo "Persistent uploads:"
echo "$UPLOAD_DIR"

echo
echo "Maven WAR:"
echo "$WAR_FILE"

echo
echo "Production WAR:"
echo "$ROOT_WAR_FILE"

echo
echo "Tomcat:"
echo "$TOMCAT_SERVICE"

echo
echo "============================================================"
echo "                    RAHANU TECHNOLOGY"
echo "                         READY"
echo "============================================================"
echo
