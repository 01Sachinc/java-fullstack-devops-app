#!/bin/bash
# -------------------------------------------------------------------
# Project: DevOps Task Manager
# Component: Health & Log Monitoring
# Author: Sachin C S
# -------------------------------------------------------------------

echo "========================================"
echo "[PIPELINE] STAGE: MONITORING & ALERTS"
echo "========================================"

SERVICES=("task-backend" "task-db" "task-frontend")

for SERVICE in "${SERVICES[@]}"
do
    STATUS=$(docker inspect -f '{{.State.Running}}' $SERVICE 2>/dev/null)
    
    if [ "$STATUS" == "true" ]; then
        echo "[HEALTH] $SERVICE: OK"
    else
        echo "[ALERT] $SERVICE: DOWN!"
        # In real scenario: trigger SNS/Email alert
    fi
done

echo "----------------------------------------"
echo "[LOGS] Recent Backend activity:"
docker logs task-backend --tail 10
