CERT_DIR=$(PWD)/config/certs

initial_structure:
	mkdir -p config/certs data

private_key:	initial_structure
	docker run --rm -v $(pwd):/tmp -w /tmp frapsoft/openssl \ 
	openssl ecparam -genkey -name prime256v1 | openssl ec -out private.key

public_key:	initial_structure
	docker run --rm -v $(pwd):/tmp -w /tmp frapsoft/openssl \ 
	openssl req -new -x509 -days 3650 \
	-key private.key \
	-out public.crt \
	-subj "/C=US/ST=state/L=location/O=organization/CN=<domain.com>"

move_keys:
	mv private.key ${CERT_DIR}
	mv public.crt ${CERT_DIR}

generate_keys: private_key	public_key	move_keys

start:
	docker-compose up -d
	@echo "Open https://localhost"

stop:
	docker-compose down

clean:
	rm -f private.key public.crt
	rm -rf config data