testing = @echo "\e[1;34mTesting  $<\e[0m"

.ONESHELL:
.PHONY: is_online
is_online: movefile test_service




movefile:
	@echo "Moving file"
	ls
	sudo cp ./is_online.service  /lib/systemd/system/.



test_service:
	$(testing)
	sudo systemctl daemon-reload
	sudo systemctl stop is_online
	sudo systemctl start is_online
	sudo systemctl enable is_online




# sudo systemctl status is_online