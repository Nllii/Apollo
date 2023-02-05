testing = @echo "\e[1;34mTesting  $<\e[0m"

.ONESHELL:
.PHONY: apollo-notification
apollo-notification: movefile test_service


movefile:
	@echo "Moving file"
	ls
	sudo cp ./apollo-notification.service  /lib/systemd/system/.



test_service:
	$(testing)
	sudo systemctl daemon-reload
	sudo systemctl stop apollo-notification
	sudo systemctl start apollo-notification
	sudo systemctl enable apollo-notification




# sudo systemctl status is_online
