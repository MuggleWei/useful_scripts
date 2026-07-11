#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "[ERROR] migrate_irq.sh without target cpu"
	echo "[ERROR] Usage: migrate_irq.sh <cpu>"
	exit 1
fi

# stop irqblance
sudo systemctl stop irqbalance

# migrate all IRQ away from TARGET_CPU
TARGET_CPU=$1
AFFINITY_MASK=$(print '%x' $((~(1 << TARGET_CPU) & 0xFFFFFFFF)))

echo "migrate IRQs away from CPU $TARGET_CPU (mask $AFFINITY_MASK)"

for irq_dir in /proc/irq/[0-9]*; do
	irq=$(basename "$irq_dir")

	echo "migrate $irq away from cpu#$TARGET_CPU"

	# ignore some IRQ
	# TODO: to be continued
done
