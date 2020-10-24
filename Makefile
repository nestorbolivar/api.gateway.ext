apply:
	terraform13 apply -var-file vars/dev1.tfvar

destroy:
	terraform13 destroy -var-file vars/dev1.tfvar

testing:
	tests/test_payload.sh
