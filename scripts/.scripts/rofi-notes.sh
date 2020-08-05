#!/bin/bash
NOTES_FILE=$HOME/.notes

if [[ ! -a "${NOTES_FILE}" ]]; then
	touch "${NOTES_FILE}"
fi

function add_todo() {
	echo -e "$*" >> "${NOTES_FILE}"
}

function remove_todo() {
	sed -i "/^${*}$/d" "${NOTES_FILE}"
}

function get_notes() {
	echo "$(cat "${NOTES_FILE}")"
}

if [ -z "$@" ]; then
	get_notes
else
	LINE=$(echo "${@}" | sed "s/\([^a-zA-Z0-9]\)/\\\\\\1/g")
	LINE_UNESCAPED=${@}
	if [[ $LINE_UNESCAPED == +* ]]; then
		LINE_UNESCAPED=$(echo $LINE_UNESCAPED | sed s/^+//g |sed s/^\s+//g )
		add_todo ${LINE_UNESCAPED}
	else
		MATCHING=$(grep "^${LINE_UNESCAPED}$" "${NOTES_FILE}")
		if [[ -n "${MATCHING}" ]]; then
			remove_todo ${LINE_UNESCAPED}
		fi
	fi
	get_notes
fi