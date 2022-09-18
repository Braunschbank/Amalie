#!/bin/ash

set -e

echo "-- Waiting 15 seconds for the server to be hopefully up..."
sleep 15

echo "-- Creating admin user $ADMIN_USER..."
$HOME/bin/pleroma_ctl user new $ADMIN_USER $ADMIN_EMAIL --password $ADMIN_PASS --admin --assume-yes
echo "-- Created admin user $ADMIN_USER"

echo "-- Installing frontend..."
$HOME/bin/pleroma_ctl frontend install pleroma-fe --ref stable
echo "-- Installed frontend"
