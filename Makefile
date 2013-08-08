VI_PERL_PATH=./t/lib

test:
	perl -I $(VI_PERL_PATH) ./t/check_vmware_api.t
