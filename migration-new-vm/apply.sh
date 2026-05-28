#!/usr/bin/env bash
# ============================================================
# apply.sh — apply migrate.sql to the NEW DB safely
# Run this on the new VM after copying migrate.sql alongside it.
#
# Usage:
#   ./apply.sh                          # interactive: will prompt
#   DB_HOST=localhost DB_USER=root DB_PASS='...' DB_NAME=cims_db ./apply.sh
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_FILE="${SQL_FILE:-$SCRIPT_DIR/migrate.sql}"

if [ ! -f "$SQL_FILE" ]; then
  echo "ERROR: $SQL_FILE not found" >&2
  exit 1
fi

# ---- read DB connection (env or prompt) ----
: "${DB_HOST:=localhost}"
: "${DB_PORT:=3306}"
: "${DB_USER:=root}"
if [ -z "${DB_NAME:-}" ]; then
  read -rp "DB name: " DB_NAME
fi
if [ -z "${DB_PASS:-}" ]; then
  read -rsp "DB password for ${DB_USER}@${DB_HOST}: " DB_PASS
  echo
fi
export MYSQL_PWD="$DB_PASS"

mysql_run() {
  mysql --protocol=tcp -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" "$DB_NAME" "$@"
}

echo
echo "=== Target: ${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME} ==="

# ---- sanity check connection ----
mysql_run -e "SELECT VERSION();" >/dev/null
echo "Connected OK."

# ---- show current row counts (must be 0 for clean import) ----
echo
echo "Current row counts on target (should all be 0):"
mysql_run --table -e "
  SELECT 'hospitals' tbl,(SELECT COUNT(*) FROM hospitals) c
  UNION SELECT 'cathlabs',(SELECT COUNT(*) FROM cathlabs)
  UNION SELECT 'nris',(SELECT COUNT(*) FROM nris)
  UNION SELECT 'unvs',(SELECT COUNT(*) FROM unvs)
  UNION SELECT 'radios',(SELECT COUNT(*) FROM radios)
  UNION SELECT 'doctors',(SELECT COUNT(*) FROM doctors)
  UNION SELECT 'cathlab_admins',(SELECT COUNT(*) FROM cathlab_admins)
  UNION SELECT 'samu_admins',(SELECT COUNT(*) FROM samu_admins)
  UNION SELECT 'nri_admins',(SELECT COUNT(*) FROM nri_admins)
  UNION SELECT 'unv_admins',(SELECT COUNT(*) FROM unv_admins)
  UNION SELECT 'radio_admins',(SELECT COUNT(*) FROM radio_admins)
  UNION SELECT 'user',(SELECT COUNT(*) FROM user);
"

read -rp "Continue and apply migrate.sql? [y/N] " yn
[ "$yn" = "y" ] || { echo "Aborted."; exit 0; }

# ---- backup (just in case) ----
TS=$(date +%Y%m%d-%H%M%S)
BACKUP="$SCRIPT_DIR/backup-${DB_NAME}-${TS}.sql"
echo
echo "Backing up target DB to $BACKUP ..."
mysqldump --protocol=tcp --no-tablespaces -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" "$DB_NAME" > "$BACKUP"
echo "Backup size: $(du -h "$BACKUP" | cut -f1)"

# ---- apply ----
echo
echo "Applying $SQL_FILE ..."
mysql_run < "$SQL_FILE"
echo "Applied."

# ---- verify ----
echo
echo "New row counts on target:"
mysql_run --table -e "
  SELECT 'hospitals' tbl,(SELECT COUNT(*) FROM hospitals) c
  UNION SELECT 'cathlabs',(SELECT COUNT(*) FROM cathlabs)
  UNION SELECT 'nris',(SELECT COUNT(*) FROM nris)
  UNION SELECT 'unvs',(SELECT COUNT(*) FROM unvs)
  UNION SELECT 'radios',(SELECT COUNT(*) FROM radios)
  UNION SELECT 'doctors',(SELECT COUNT(*) FROM doctors)
  UNION SELECT 'cathlab_admins',(SELECT COUNT(*) FROM cathlab_admins)
  UNION SELECT 'samu_admins',(SELECT COUNT(*) FROM samu_admins)
  UNION SELECT 'nri_admins',(SELECT COUNT(*) FROM nri_admins)
  UNION SELECT 'unv_admins',(SELECT COUNT(*) FROM unv_admins)
  UNION SELECT 'radio_admins',(SELECT COUNT(*) FROM radio_admins)
  UNION SELECT 'user',(SELECT COUNT(*) FROM user);
"

echo
echo "Users imported:"
mysql_run --table -e "SELECT id, email, roles, accountStatus FROM user ORDER BY id;"

echo
echo "Done."
