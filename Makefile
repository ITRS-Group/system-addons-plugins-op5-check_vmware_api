VI_PERL_PATH=./lib

test:
	perl -I $(VI_PERL_PATH) ./t/check_vmware_api.t
