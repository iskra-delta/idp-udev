#!/bin/sh
set -eu

ROOT_DIR=$1
EMU_DIR=$2
BIN_DIR=$3
_PRIMARY=${4:-}

if [ -z "$_PRIMARY" ]; then
    echo "usage: $0 ROOT_DIR EMU_DIR BIN_DIR PRIMARY_TEST" >&2
    exit 1
fi

rm -rf "$EMU_DIR"
mkdir -p "$EMU_DIR"
cp -a /opt/z80pack/cpmsim/. "$EMU_DIR"

rm -f "$EMU_DIR"/disks/drivea.dsk "$EMU_DIR"/disks/driveb.dsk
cp "$EMU_DIR"/disks/library/cpm22-1.dsk "$EMU_DIR"/disks/drivea.dsk
cp "$EMU_DIR"/disks/library/cpm22-2.dsk "$EMU_DIR"/disks/driveb.dsk

for com in "$BIN_DIR"/*.COM; do
    name=$(basename "$com")
    cpmcp -f ibm-3740 "$EMU_DIR"/disks/driveb.dsk "$com" "0:$name"
done

run_one() {
    test_name=$1
    command=$2
    log="$BIN_DIR/$test_name.txt"
    (
        cd "$EMU_DIR"
        printf 'B:\n%s\nA:\nBYE\n' "$command" | ./cpmsim
    ) > "$log" 2>&1
    if cpmcp -f ibm-3740 "$EMU_DIR"/disks/driveb.dsk "0:${test_name}.TXT" "$BIN_DIR" 2>/dev/null; then
        if [ -f "$BIN_DIR/${test_name}.TXT" ]; then
            mv "$BIN_DIR/${test_name}.TXT" "$log"
        fi
    fi
}

run_one TULIBC TULIBC
run_one TARITH TARITH
run_one TARGS "TARGS ALPHA BETA"
