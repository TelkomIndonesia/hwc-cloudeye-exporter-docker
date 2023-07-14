#!/bin/sh
set -e

gomplate_flags_config() {
    if [ ! -f "/etc/gomplate/config.yaml" ]; then
        return
    fi

    echo -n "--config '/etc/gomplate/config.yaml' "
}

gomplate_flags_context() {
    if [ ! -f "/etc/gomplate/context.yaml" ]; then
        return
    fi

    echo -n "--context '/etc/gomplate/context.yaml' "
}

gomplate_flags_datasource() {
    if [ ! -d "/etc/gomplate/datasource.d" ]; then
        return
    fi

    for ds in $(find /etc/gomplate/datasource.d -type f); do
        echo -n "--datasource '$ds' "
    done
}

gomplate_flags() {
    gomplate_flags_config
    gomplate_flags_context
    gomplate_flags_datasource
}

for file in $(find /opt/gomplate -type f); do
    out="$(echo "$file" | sed 's|/opt/gomplate||')"
    if [ -f "$out" ]; then
        continue
    fi
    gomplate $(gomplate_flags) -f "$file" -o "$out"
done

exec cloudeye-exporter $@
