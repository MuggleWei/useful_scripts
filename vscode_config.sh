#!/bin/bash

if [ -e ~/.config/Code/User/settings.json ]; then
	cp ./vscode_settings.json ~/.config/Code/User/settings.json
fi
