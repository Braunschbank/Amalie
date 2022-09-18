#!/bin/ash

set -e

echo "-- Waiting for database..."
while ! pg_isready -U ${DB_USER:-pleroma} -d postgres://${DB_HOST:-db}:5432/${DB_NAME:-pleroma} -t 1; do
    sleep 1s
done

echo "-- Running migrations..."
$HOME/bin/pleroma_ctl migrate

if [ ! -f /var/lib/akkoma/first_run_marker ]; then
    echo "-- Running first start script..."
    nohup /opt/akkoma/exec_first_run.sh &
    touch /var/lib/akkoma/first_run_marker
fi

echo "-- Starting!"
exec $HOME/bin/pleroma start
