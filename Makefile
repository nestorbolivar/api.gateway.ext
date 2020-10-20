apply:
	terraform13 apply -var-file dev1.tfvar

destroy:
	terraform13 destroy -var-file dev1.tfvar
