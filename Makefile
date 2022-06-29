default:
	docker build -t oxr463/gentoo-sdk .
	docker save --output oxr463_gentoo_sdk.tar oxr463/gentoo-sdk
	gzip oxr463_gentoo_sdk.tar

clean:
	docker rmi oxr463/gentoo-sdk:latest
	rm oxr463_gentoo_sdk.tar.gz
