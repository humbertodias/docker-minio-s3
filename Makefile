CERT_DIR=$(PWD)/config/certs

ACCESS_KEY ?= CHANGEME
SECRET_KEY ?= CHANGEME

initial_structure:
	mkdir -p config/certs data

private_key:	initial_structure
	docker run --rm -v $(PWD):/tmp -w /tmp rnix/openssl-gost \
	openssl ecparam -genkey -name prime256v1 | openssl ec -out private.key
	
public_key:	private_key
	docker run --rm -v $(PWD):/tmp -w /tmp rnix/openssl-gost \
	openssl req -new -x509 -days 3650 \
	-key private.key \
	-out public.crt \
	-subj "/C=US/ST=state/L=location/O=organization/CN=localhost"

move_keys:
	mv private.key public.crt ${CERT_DIR}

generate_keys:	public_key	move_keys

env:
	echo "ACCESS_KEY=${ACCESS_KEY}\nSECRET_KEY=${SECRET_KEY}" > .env

up:	env
	docker-compose up -d
	@echo "Open https://localhost"

down:
	docker-compose down

clean:
	rm -f private.key public.crt .env
	rm -rf config data